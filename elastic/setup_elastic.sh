#!/bin/bash


kubectl apply -f ./elastic/elasticsearch-pvc.yaml
kubectl apply -f ./elastic/elasticsearch.yaml

