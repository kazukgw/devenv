
#!/bin/bash

PROJECT=""
ZONE="asia-northeast1-b"
INSTANCE="devenv"
DEVENV_COMMAND='. run_devenv'
DEVENV_COMMAND_NEW_SESSION="${DEVENV_COMMAND} new-session"

function usage() {
cat <<EOF

USAGE: devenv <subcommand> (<arguments>)

Available subcommands is berow.
  help                Show this help
  start               Start devenv-machine
  stop                Stop devenv-machine
  restart             Stop and start devenv-machine
  ssh                 SSH Login to devenv-machine
  scp-get             Get files from devenv-machine via SCP
  scp-put             Put files to devenv-machine via SCP
  pf                  Start local port-forwading from devenv-machine
  ns                  Create new devenv session
  (no subcommand)     Attach to exists devenv session, or create
                      new one if no exists session
EOF

}

case "$1" in
  "start")
    gcloud compute instances start --zone $ZONE $INSTANCE --project $PROJECT
    ;;

  "stop")
    gcloud compute instances stop --zone $ZONE $INSTANCE --project $PROJECT
    ;;

  "restart")
    gcloud compute instances stop --zone $ZONE $INSTANCE --project $PROJECT
    gcloud compute instances start --zone $ZONE $INSTANCE --project $PROJECT
    ;;

  "ssh")
    gcloud compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT
    ;;

  "scp-get")
    if [[ -z "$2" ]] || [[ -z "$3" ]]; then
      echo "USAGE: devenv scg-get <src at instance> <dest>"
    else
      gcloud compute scp --zone $ZONE --tunnel-through-iap --project $PROJECT --compress --recurse $INSTANCE:$2 $3
    fi
    ;;

  "scp-put")
    if [[ -z "$2" ]] || [[ -z "$3" ]]; then
      echo "USAGE: devenv scg-put <src> <dest at instance>"
    else
      gcloud compute scp --zone $ZONE --tunnel-through-iap --project $PROJECT --compress --recurse $2 $INSTANCE:$3
    fi
    ;;

  "pf")
    gcloud compute start-iap-tunnel --zone $ZONE $INSTANCE $2 --local-host-port localhost:$3 --project $PROJECT
    ;;

  "ns")
    gcloud compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT -- \
      -o ControlMaster=auto \
      -o ControlPath=$HOME/.ssh/controlmasters.%r@%h:%p \
      -o ControlPersist=1h \
      -o TCPKeepAlive=yes \
      -o ServerAliveInterval=120 \
      -o ExitOnForwardFailure=yes \
      -R 2489:127.0.0.1:2489 \
      -g $DEVENV_COMMAND_NEW_SESSION
    ;;

  "")
    gcloud compute ssh --zone $ZONE $INSTANCE --tunnel-through-iap --project $PROJECT -- \
      -o ControlMaster=auto \
      -o ControlPath=$HOME/.ssh/controlmasters.%r@%h:%p \
      -o ControlPersist=1h \
      -o TCPKeepAlive=yes \
      -o ServerAliveInterval=120 \
      -o ExitOnForwardFailure=yes \
      -R 2489:127.0.0.1:2489 \
      -g $DEVENV_COMMAND
    ;;

  "help")
    usage
    ;;

  *)
    usage
    ;;
esac
