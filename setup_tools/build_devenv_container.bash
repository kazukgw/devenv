docker build -t devenv \
  --build-arg USER= \
  --build-arg USERID=501 \
  --build-arg DOCKER_GID=999 \
  --build-arg PASSWORD= \
  --build-arg HOMEDIR=/Users/__user__/devenv \
  .

