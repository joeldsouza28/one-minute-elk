#!/bin/bash

#!/bin/bash

NAMESPACE=logging

# Delete the ConfigMap if it exists
kubectl delete configmap filebeat-config -n $NAMESPACE --ignore-not-found

# Create the ConfigMap from your local filebeat.yml
kubectl create configmap filebeat-config \
  --from-file=filebeat.yml=./filebeat/filebeat.yml \
  -n $NAMESPACE


kubectl apply -f ./filebeat/filebeat-rbac.yaml
kubectl apply -f ./filebeat/filebeat-daemonset.yaml
kubectl rollout restart ds filebeat -n logging