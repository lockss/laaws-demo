#!/bin/sh
sudo find . -type f -name "*.warc" -exec touch {} \;
sleep 60
docker exec laawsdemo_laaws-demo_1 /usr/local/apache2/cgi-bin/test-demo.sh
