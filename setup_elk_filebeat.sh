#!/bin/bash


./tls/generate_tls.sh


./elastic/setup_elastic.sh

sleep 20

./tls/get_password.sh


./kibana/setup_kibana.sh


./logstash//setup_logstash.sh


./filebeat/setup_filebeat.sh