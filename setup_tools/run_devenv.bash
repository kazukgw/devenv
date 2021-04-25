#!/bin/bash
export DEVENV_COMPOSE_FILE="/Users/developer/devenv/docker-compose.yaml"
export DEVENV_CONTAINER_NAME="devenv_container"

# function devenv() {
status=$(docker inspect $DEVENV_CONTAINER_NAME --format {{.State.Status}})
echo ""
echo "==> status: $status"

if [[ $status =~ ^running.* ]]; then
  if [[ $1 == "new-session" ]]; then
    echo "==> docker exec $DEVENV_CONTAINER_NAME"
    docker exec -it $DEVENV_CONTAINER_NAME tmux new -s devenv-$(date +%s)
  else
    echo "==> docker attach $DEVENV_CONTAINER_NAME"
    docker attach $DEVENV_CONTAINER_NAME
  fi
else
  echo ""
  echo "==> run new devenv container"
  echo "==> docker-compose -f $DEVENV_COMPOSE_FILE up -d"
  docker-compose -f $DEVENV_COMPOSE_FILE up -d
fi
# }
