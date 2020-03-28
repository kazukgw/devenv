docker build -t devenv \
  --build-arg USER=developer \
  --build-arg USERID=501 \
  --build-arg DOCKER_GID=999 \
  --build-arg PASSWORD=password \
  --build-arg HOMEDIR=/Users/developer/devenv \
  .

