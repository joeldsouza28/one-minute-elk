#!/bin/bash

kubectl exec -it elasticsearch-0 -n logging -- bin/elasticsearch-setup-passwords auto -b >> tls/password.txt
