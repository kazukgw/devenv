FROM ubuntu

ENV DEVENVROOT=/home/devenv

### do apt-get update and install wget due to get repository {{{
RUN apt-get update --fix-missing \
  && apt-get install -y wget \
# }}}


### change repository {{{
  && wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - \
  && wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - \
  && wget https://www.ubuntulinux.jp/sources.list.d/xenial.list -O /etc/apt/sources.list.d/ubuntu-ja.list \
  && echo "Package: *\nPin: origin \"archive.ubuntulinux.jp\"\nPin-Priority: 600\n" > /etc/apt/preferences \
# }}}


### apt pkgs {{{
  && apt-get update --fix-missing && apt-get install -y \
    sudo \
    man \
    telnet \
    tcpdump \
    traceroute \
    g++ \
    gfortran \
    htop \
    tree \
    git-extras \
    exuberant-ctags \
    shellcheck \
    language-pack-ja-base \
    language-pack-ja \
    dbus \
    ibus \
    git \
    curl \
    iputils-ping \
    make \
    gawk \
    connect-proxy \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    mysql-client \
    bzip2 \
    tmux \
    jq \
    tig \
    nkf \
    silversearcher-ag \
    python \
    python-dev \
    python-setuptools \
    python3 \
    python3-dev \
    python3-setuptools \
    python-software-properties \
    openjdk-8-jdk-headless \
    ant \
    ivy \
  && easy_install pip \
  && easy_install3 pip \
# }}}


### devenv {{{
  && mkdir -p ${DEVENVROOT} \
  && mkdir -p ${DEVENVROOT}/src \
  && mkdir -p ${DEVENVROOT}/bin \
  && mkdir -p ${DEVENVROOT}/pkg \
# }}}


### golang {{{
  && export GOVERSION=1.8 \
  && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
  && mkdir -p ${DEVENVPATH}/.go \
  && tar -zxvf go${GOVERSION}.linux-amd64.tar.gz -C ${DEVENVROOT} \
  && mv ${DEVENVROOT}/go  ${DEVENVROOT}/.go \
  && rm go${GOVERSION}.linux-amd64.tar.gz \
# }}}


### google cloud sdk {{{
  && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
  && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update && apt-get install google-cloud-sdk -y \
#}}}


### docker {{{
  && apt-key adv \
    --keyserver hkp://ha.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
  && echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list \
  && apt-get update \
  && apt-cache policy docker-engine \
  && apt-get install docker-engine -y \
# }}}


### neovim {{{
  && add-apt-repository -y ppa:neovim-ppa/unstable \
  && apt-get update \
  && apt-get install neovim -y
# }}}


### go pkgs {{{
RUN export GOROOT=${DEVENVROOT}/.go \
  && export PATH=${DEVENVROOT}/.go/bin:$PATH \
  && mkdir -p /usr/local/go \
  && mkdir -p /usr/local/go/src \
  && mkdir -p /usr/local/go/bin \
  && mkdir -p /usr/local/go/pkg \
  && export GOPATH=/usr/local/go \
  && go get -u github.com/motemen/ghq \
  && go get -u github.com/laurent22/massren \
  && go get -u github.com/dinedal/textql/... \
  && go get -u github.com/derekparker/delve/cmd/dlv \
  && go get -u github.com/mholt/archiver/cmd/archiver \
# }}}


### nodejs {{{
  && export N_PREFIX=${DEVENVROOT}/.n \
  && curl -L https://git.io/n-install | bash -s -- -y \
  && chmod +x ${DEVENVROOT}/.n/bin/n \
  && export PATH=${DEVENVROOT}/.n/bin:$PATH \
  && ${DEVENVROOT}/.n/bin/npm install --global eslint babel-eslint tern \
# }}}


### pips {{{
  && pip2 install --upgrade pip && pip2 install --upgrade \
    jedi \
    requests \
    pylint \
    cython \
    awscli \
    mycli \
    docker-compose \
    numpy scipy \
    virtualenv \
    flake8 \
    autopep8 \
    neovim \
  && pip install --upgrade pip && pip install --upgrade \
    jedi \
    requests \
    pylint \
    cython \
    awscli \
    mycli \
    docker-compose \
    numpy scipy \
    flake8 \
    autopep8 \
    virtualenv \
    neovim \
# }}}


### borg {{{
  && wget https://github.com/ok-borg/borg/releases/download/v0.0.2/borg_linux_amd64 -O /usr/local/bin/borg \
  && chmod +x /usr/local/bin/borg \

# }}}


### fzf {{{
  && git clone --depth 1 https://github.com/junegunn/fzf.git ${DEVENVROOT}/.fzf \
  && ${DEVENVROOT}/.fzf/install --all \
#}}}


### lang {{{
  && localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS \
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

ENV LANG ja_JP.UTF-8
# }}}


### nvim & dotfiles {{{
ADD nvim ${DEVENVROOT}/.config/nvim
ADD bash_profile ${DEVENVROOT}/.bash_profile
ADD bash_prompt ${DEVENVROOT}/.bash_prompt
ADD templates ${DEVENVROOT}/.templates
ADD note ${DEVENVROOT}/.note
ADD functions ${DEVENVROOT}/.functions
ADD tmux.conf ${DEVENVROOT}/.tmux.conf
ADD git-completion ${DEVENVROOT}/.git-completion
ADD gitconfig ${DEVENVROOT}/.gitconfig
ADD tigrc ${DEVENVROOT}/.tigrc
ADD docker-config.json ${DEVENVROOT}/.docker/config.json
ADD fzf.bash ${DEVENVROOT}/.fzf.bash
# }}}


### clean (disabled) {{{
# RUN apt-get clean \
#   && apt-get autoremove \
#   && dpkg -l 'linux-*' \
#     | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' \
#     | xargs sudo apt-get -y purge
# }}}


### ONBUILD ############### {{{
## create user
ONBUILD ARG USER
ONBUILD ARG USERID
ONBUILD ARG DOCKER_GID
ONBUILD ARG PASSWORD
ONBUILD ARG HOMEDIR

ONBUILD RUN groupadd -g $USERID $USER \
    && mkdir -p $HOMEDIR \
    && useradd -u $USERID -g $USER -G sudo -m -d $HOMEDIR -s /bin/bash $USER \
    && echo "$USER:$PASSWORD" | chpasswd \
    && if [ -n "$DOCKER_GID" ]; then groupmod -g $DOCKER_GID docker; fi \
    && usermod -aG docker $USER \
    && mv ${DEVENVROOT}/* $HOMEDIR/ \
    && mv ${DEVENVROOT}/.[^.]* $HOMEDIR/

## env go
ONBUILD ENV GOROOT $HOMEDIR/.go
ONBUILD ENV GOPATH $HOMEDIR
ONBUILD ENV PATH $GOPATH/bin:$GOROOT/bin:/usr/local/go/bin:$PATH

## env node
ONBUILD ENV N_PREFIX $HOMEDIR/.n
ONBUILD ENV PATH $HOMEDIR/.n/bin:$PATH

## PATH
ONBUILD ENV PATH $HOMEDIR/.fzf/bin:$PATH

## change permission
ONBUILD RUN echo 'source ~/.bash_profile' >> $HOMEDIR/.bashrc && chown -R $USER:$USER $HOMEDIR

ONBUILD USER $USER
ONBUILD WORKDIR $HOMEDIR

# }}}

# vim: foldmethod=marker foldlevel=0
