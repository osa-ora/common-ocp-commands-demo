# SampleOffer
Java Web Application that uses maven to build the war file.

## Common Openshift command line operations:

To Deploy on Openshift:
```
oc new-project dev

oc new-app jws31-tomcat8-basic-s2i -n dev -p SOURCE_REPOSITORY_URL=https://github.com/osa-ora/SampleOffer -p SOURCE_REPOSITORY_REF=master -p CONTEXT_DIR="" -p APPLICATION_NAME=offers

oc logs -f bc/offers -n dev

oc expose svc/offers -n dev
```

To define an environemnt variable while deploying add -e with the required environment variable e.g. test="Hello"
```
oc new-app jws31-tomcat8-basic-s2i -n dev -p SOURCE_REPOSITORY_URL=https://github.com/osa-ora/SampleOffer -p SOURCE_REPOSITORY_REF=master -p CONTEXT_DIR="" -p APPLICATION_NAME=offers -e test="Hello"
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
