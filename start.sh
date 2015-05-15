#!/bin/bash
echo "Start ElasticSearch"
/home/elasticsearch/bin/elasticsearch -d
echo "Wait few seconds until ES is UP"
sleep 20
echo "Start mail import"
python /home/elasticsearch/index_emails.py --infile=/tmp/mails.mbox &
echo "Start WebServer : http://localhost:8080"
cd /home/elasticsearch/kibana/ && python -m SimpleHTTPServer 8080
