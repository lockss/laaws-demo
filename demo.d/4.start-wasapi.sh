#!/bin/sh

# Start the WASAPI service
docker exec laawsdemo_laaws-demo_1 wasapi/app.py 2>&1 >/var/log/wasapi.log &
