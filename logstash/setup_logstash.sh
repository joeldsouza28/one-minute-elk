#!/bin/bash


NEW_PASSWORD=$(awk -F ' = ' '/PASSWORD elastic/ {print $2}' ./tls/password.txt | tr -d '\r')

PIPELINE_FILE="./logstash/pipeline.conf"

sed -i "s|password => \".*\"|password => \"$NEW_PASSWORD\"|" "$PIPELINE_FILE"

echo "Password updated successfully in $PIPELINE_FILE"

if [[ -z "$NEW_PASSWORD" ]]; then
  echo "Usage: $0 <new_password>"
  exit 1
fi

kubectl delete configmap logstash-pipeline -n logging --ignore-not-found
kubectl create configmap logstash-pipeline \
  --from-file=pipeline.conf=./logstash/pipeline.conf \
  -n logging \
  --dry-run=client -o yaml | kubectl apply -f -



kubectl apply -f ./logstash/logstash.yaml
kubectl rollout restart deployment logstash