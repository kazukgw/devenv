#!/bin/bash
PROJECT=
SERVICE_ACCOUNT=
MACHINE_TYPE=e2-medium
BOOT_DISK_SIZE=100GB

gcloud beta compute \
 --project=$PROJECT instances create devenv \
 --zone=asia-northeast1-b \
 --machine-type=$MACHINE_TYPE \
 --subnet=default \
 --no-address \
 --metadata=enable-oslogin=TRUE \
 --can-ip-forward \
 --no-restart-on-failure \
 --maintenance-policy=TERMINATE \
 --preemptible \
 --service-account=$SERVICE_ACCOUNT \
 --scopes=https://www.googleapis.com/auth/cloud-platform \
 --image=ubuntu-minimal-2004-focal-v20200917 \
 --image-project=ubuntu-os-cloud \
 --boot-disk-size=$BOOT_DISK_SIZE \
 --shielded-secure-boot \
 --shielded-vtpm \
 --shielded-integrity-monitoring \
 --reservation-affinity=any
