#!/bin/bash
PROJECT=
ZONE=asia-northeast1-b
gcloud compute instances start devenv --project=$PROJECT --zone=$ZONE
