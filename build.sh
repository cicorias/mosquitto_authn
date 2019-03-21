#!/usr/bin/env bash

if docker build  --rm -f ./modules/sender/Dockerfile.amd64 -t localhost:5000/sender:0.0.1-amd64 ./modules/sender
then
    echo "now starting simulator"
    iotedgehubdev start -d $(pwd)/config/deployment.amd64.json -v
else
    echo "dockekr build failed"
fi