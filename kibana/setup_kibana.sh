#!/bin/bash

echo "Password is: $(awk -F ' = ' '/PASSWORD kibana_system/ {print $2}' ./tls/password.txt | tr -d '\r')"

password=$(awk -F ' = ' '/PASSWORD kibana_system/ {print $2}' ./tls/password.txt | tr -d '\r')


kubectl delete secret kibana-creds -n logging --ignore-not-found
kubectl create secret generic kibana-creds -n logging \
  --from-literal=elastic_username=kibana_system \
  --from-literal=elastic_password=$password


kubectl apply -f ./kibana/kibana.yaml


