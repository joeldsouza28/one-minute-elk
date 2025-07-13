#!/bin/bash

openssl genrsa -out tls/ca.key 4096
openssl req -x509 -new -key tls/ca.key -sha256 -days 3650 -subj="/CN=elkca" -out tls/ca.crt
openssl genrsa -out tls/elasticsearch.key 2048
openssl req -new -key tls/elasticsearch.key -subj="/CN=elasticsearch.logging.svc.cluster.local" -out tls/elasticsearch.csr
cat > tls/san.cnf <<EOF                                                                                 
[ v3_ca ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = elasticsearch
DNS.2 = elasticsearch.logging
DNS.3 = elasticsearch.logging.svc
DNS.4 = elasticsearch.logging.svc.cluster.local
EOF

openssl x509 -req -in tls/elasticsearch.csr -CA tls/ca.crt  -CAkey tls/ca.key -CAcreateserial -out tls/elasticsearch.crt -days 3650 -sha256 -extfile tls/san.cnf -extensions v3_ca
 

kubectl get namespace logging >/dev/null 2>&1 || kubectl create namespace logging

kubectl create secret generic elasticsearch-tls -n logging --from-file=tls/elasticsearch.crt --from-file=tls/elasticsearch.key --from-file=tls/ca.crt