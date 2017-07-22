#!/bin/bash
# function devenv() {
cname=$(docker ps -a --format '{{.Image}} {{.Names}} {{.Status}}' | awk 'match($1, /devenv/) {print $2} ')
if [[ -n "$cname" ]]; then
  status=$(docker ps -a --format '{{.Image}} {{.Names}} {{.Status}}' | awk 'match($1, /devenv/) {print $3} ')
  echo ""
  echo "==> status: $status"
  if [[ $status =~ ^Up.* ]]; then
    echo "==> exec $cname"
    echo ""
    docker attach $cname
  elif [[ $status =~ ^Exited.* ]]; then
    echo "==> start and attach $cname"
    echo ""
    docker attach $(docker start $cname)
  else
    echo "==> undefined status: $status"
    echo ""
  fi
else
  echo ""
  echo "==> run new devenv container"
  echo ""
  docker-compose -f $DEVENV_COMPOSE_FILE run --name devenv devenv
fi
# }
