#!/bin/bash
PORT=8080
INSTANCE=devenv
PROJECT=
ZONE=

gcloud --project=$PROJECT compute start-iap-tunnel $INSTANCE 8080 \
  --local-host-port=localhost:8080 \
  --zone=$ZONE
