# SampleOffer
Java Web Application that uses maven to build the war file.

## Common Openshift command line operations:

To Deploy on Openshift:
```
oc new-project dev

oc new-app jws31-tomcat8-basic-s2i -n dev -p SOURCE_REPOSITORY_URL=https://github.com/osa-ora/common-ocp-commands-demo -p SOURCE_REPOSITORY_REF=master -p CONTEXT_DIR="" -p APPLICATION_NAME=offers

oc logs -f bc/offers -n dev

```
Acces the application using: Route_URL/FreeOffers-1.0-SNAPSHOT

To define an environemnt variable while deploying add -e with the required environment variable e.g. test="Hello"
```
oc new-app jws31-tomcat8-basic-s2i -n dev -p SOURCE_REPOSITORY_URL=https://github.com/osa-ora/common-ocp-commands-demo -p SOURCE_REPOSITORY_REF=master -p CONTEXT_DIR="" -p APPLICATION_NAME=offers -e test="Hello"
```
To create config map and attach it to the application:
```
oc create configmap env-settings --from-literal  test="hello" --from-literal ip_param="ip_address"

oc set env dc/offers --from configmap/env-settings
```

To scale it manually
```
oc scale dc/offers --replicas=2 -n dev

oc rollout status dc/offers -n dev
```

To enable horizontal auto-scalling
```
oc set resources dc/offers --limits=cpu=400m,memory=512Mi --requests=cpu=2m,memory=256Mi -n dev

oc autoscale dc/offers --min 1 --max 3 --cpu-percent=40 -n dev
```
This will create a HorizontalPodAutoscaler object with the target CPU and pod limits (CPU here is the average across all pods), to change this to memory, edit the HorizontalPodAutoscaler yaml file and change it to memory instead of CPU as currently this cannot be set by the oc command.  

To add readiness and liveness probes
```
oc set probe dc/offers --liveness --get-url=http://:8080/FreeOffers-1.0-SNAPSHOT/ --initial-delay-seconds=12

oc set probe dc/offers --readiness --get-url=http://:8080/FreeOffers-1.0-SNAPSHOT/ --initial-delay-seconds=12 
```
To rollback a release
```
oc rollback offers
```

This rollback will disable the auto-trigger of the deployment, to enable it again:
```
oc set triggers dc/offers --auto
```

To deploy as Serverless if Openshift serverless framework already deployed
```
oc apply -f serverlessoffers.yaml -n dev

oc get ksvc serverlessoffers -n dev

//Then Access the Serverless app from the URL/FreeOffers-1.0-SNAPSHOT
```

Here is the content of this serverlessoffers.yaml
```
apiVersion: serving.knative.dev/v1
kind: Service
metadata:
  name: serverlessoffers
  namespace: dev
spec:
  template:
    spec:
      containers:
        - image: image-registry.openshift-image-registry.svc:5000/dev/offers
```
You can stress the application to test the auto-scalling by:

```
curl -L https://goo.gl/S1Dc3R | bash -s 20 "{ROUTE_URL}/FreeOffers-1.0-SNAPSHOT/"
//or
./load-test.sh 20 "{ROUTE_URL}/FreeOffers-1.0-SNAPSHOT/"
```
Note: replace {ROUTE_URL} with the acutal end point of the application route. 
The load-test.sh is at the URL "https://goo.gl/S1Dc3R" or you can create it simply by the following content:
```
max="$1"
date
echo "url: $2
rate: $max calls / second"
START=$(date +%s);

get () {
  curl -s -v "$1" 2>&1 | tr '\r\n' '\\n' | awk -v date="$(date +'%r')" '{print $0"\n-----", date}' >> /tmp/perf-test.log
}

while true
do
  echo $(($(date +%s) - START)) | awk '{print int($1/60)":"int($1%60)}'
  sleep 1

  for i in `seq 1 $max`
  do
    get $2 &
  done
done
```

