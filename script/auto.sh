#!/bin/sh
if [ "$#" -ne 2 ];  then
  echo "Usage: $0 ocp-project base-ocp-url" >&2
  exit 1
fi

echo "Please Login to OCP using oc login ..... "
read
echo "Create Required Project … $1"
oc new-project $1


echo "Deploy Application"
oc new-app jws31-tomcat8-basic-s2i -n $1 -p SOURCE_REPOSITORY_URL=https://github.com/osa-ora/SampleOffer -p SOURCE_REPOSITORY_REF=master -p CONTEXT_DIR="" -p APPLICATION_NAME=offers

#oc logs -f bc/offers -n dev

echo "****** Application Deployed Successfully *****"
read
echo "Set Auto Scaling Parameters"

oc set probe dc/offers --readiness --get-url=http://:8080/FreeOffers-1.0-SNAPSHOT/ --initial-delay-seconds=12
oc set resources dc/offers --limits=cpu=40m,memory=512Mi --requests=cpu=4m,memory=256Mi -n dev
oc autoscale dc/offers --min 1 --max 3 --cpu-percent=60 -n dev

read
echo "Check the resource consumption, and start the stress testing"
echo "Press Control+C to break the stress testing at any time!"

read

curl -L https://goo.gl/S1Dc3R
chmod 777 load-test.sh

./load-test.sh 20 "http://offers-dev.$2/FreeOffers-1.0-SNAPSHOT/"

echo "Check the resource consumption, and start the stress testing"
read
