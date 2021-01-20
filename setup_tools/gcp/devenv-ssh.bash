
#!/bin/bash

PROJECT=""
ZONE="asia-northeast1-b"
INSTANCE="devenv"
DEVENV_COMMAND='. run_devenv'

case "$1" in
  "start")
    gcloud compute start --zone $ZONE $INSTANCE --project $PROJECT
    ;;

  "stop")
    gcloud compute stop --zone $ZONE $INSTANCE --project $PROJECT
    ;;

  "restart")
    gcloud compute stop --zone $ZONE $INSTANCE --project $PROJECT
    gcloud compute start --zone $ZONE $INSTANCE --project $PROJECT
    ;;

  "ssh")
    gcloud compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT
    ;;

  "pf")
    if [ -n "$2" ]; then
      gcloud compute start-iap-tunnel --zone $ZONE $INSTANCE $2 --tunnel-through-iap --project $PROJECT
    else
      echo "pf(port-foward) subcommand port-number argument expected."
    fi
    ;;

  "")
    gcloud compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT -- bash kill-portfoward-process
    gcloud compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT -- -o ExitOnForwardFailure=yes -R 2489:127.0.0.1:2489 -g $DEVENV_COMMAND
    ;;
esac



