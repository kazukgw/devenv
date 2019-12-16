FROM kazukgw/devenv

ARG USER
ARG USERID
ARG DOCKER_GID
ARG PASSWORD
ARG HOMEDIR

## create user, group, home
RUN groupadd -g $USERID $USER \
    && mkdir -p $HOMEDIR \
    && useradd -u $USERID -g $USER -G sudo -m -d $HOMEDIR -s /bin/bash $USER \
    && echo "$USER:$PASSWORD" | chpasswd \
    && if [ -n "$DOCKER_GID" ]; then groupmod -g $DOCKER_GID docker; fi \
    && usermod -aG docker $USER \
    && mv ${DEVENVROOT}/* $HOMEDIR/ \
    && mv ${DEVENVROOT}/.[^.]* $HOMEDIR/

## change permission
RUN chown -R $USER:$USER $HOMEDIR

USER $USER
WORKDIR $HOMEDIR

# sdkman & java
ENV PATH $HOME/.sdkman/bin:$PATH
RUN /bin/bash -c 'source ~/.sdkman/bin/sdkman-init.sh \
  && sdk update \
  && sdk install java \
  && sdk install maven \
  && sdk install gradle'

# golang
ENV GOROOT $HOME/.go
ENV GOPATH $HOME
ENV PATH $GOPATH/bin:$GOROOT/bin:/usr/local/go/bin:$PATH

# node
ENV N_PREFIX $HOME/.n
ENV PATH $HOME/.n/bin:$PATH

## pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN /bin/bash -c '\
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi \
&& pyenv install 3.7.3'
