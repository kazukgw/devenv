FROM ubuntu

ARG USER=devenv
ARG PASSWORD=P@55w0rd
ARG HOMEDIR=/home/devenv

RUN apt-get update && apt-get install -y sudo \
  && groupadd -g 1000 $USER \
  && mkdir -p $HOMEDIR \
  && useradd -g $USER -G sudo -m -d $HOMEDIR -s /bin/bash $USER && \
  echo "$USER:$PASSWORD" | chpasswd

RUN apt-get update --fix-missing && apt-get install -y \
  git \
  curl \
  wget \
  make \
  gawk \
  connect-proxy \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  mysql-client \
  bzip2 \
  tmux \
  python \
  python-dev \
  python-setuptools \
  python3 \
  python3-dev \
  python3-setuptools \
  python-software-properties \
  && easy_install pip \
  && easy_install3 pip

## golang
RUN wget https://storage.googleapis.com/golang/go1.7.1.linux-amd64.tar.gz \
  && mkdir $HOMEDIR/.go \
  && tar -zxvf go1.7.1.linux-amd64.tar.gz -C $HOMEDIR/.go \
  && rm go1.7.1.linux-amd64.tar.gz \
  && chown -R $USER:$USER $HOMEDIR/.go \
  && mkdir $HOMEDIR/src \
  && mkdir $HOMEDIR/bin \
  && mkdir $HOMEDIR/pkg

ENV GOROOT $HOMEDIR/.go/go
ENV GOPATH $HOMEDIR
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

## Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
  && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update && apt-get install google-cloud-sdk -y

## docker
RUN apt-key adv \
    --keyserver hkp://ha.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-cache policy docker-engine \
    && apt-get install docker-engine -y \
    && usermod -aG docker $USER

## neovim
RUN add-apt-repository -y ppa:neovim-ppa/unstable \
  && apt-get update \
  && apt-get install neovim -y

RUN wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add - \
  && wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add - \
  && wget https://www.ubuntulinux.jp/sources.list.d/xenial.list -O /etc/apt/sources.list.d/ubuntu-ja.list \
  && apt-get update

## apt pkgs
RUN apt-get update --fix-missing && apt-get install -y \
  man \
  telnet \
  tcpdump \
  traceroute \
  jq \
  tig \
  g++ \
  gfortran \
  silversearcher-ag \
  nkf \
  htop \
  tree \
  git-extras \
  exuberant-ctags \
  shellcheck \
  language-pack-ja-base \
  language-pack-ja \
  dbus \
  ibus

ENV N_PREFIX=$HOMEDIR/.n
RUN curl -L https://git.io/n-install | bash -s -- -y \
  && chmod +x $HOMEDIR/.n/bin/n
ENV PATH $HOMEDIR/.n/bin:$PATH

RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOMEDIR/.fzf \
  && $HOMEDIR/.fzf/install --all

ENV PATH $HOMEDIR/.fzf/bin:$PATH

## go pkgs
RUN mkdir /usr/local/go \
  && mkdir /usr/local/go/src \
  && mkdir /usr/local/go/bin \
  && mkdir /usr/local/go/pkg \
  && export GOPATH=/usr/local/go \
  && go get -u github.com/motemen/ghq \
  && go get -u github.com/laurent22/massren \
  && go get -u github.com/dinedal/textql/... \
  && go get -u github.com/derekparker/delve/cmd/dlv \
  && go get github.com/mholt/archiver/cmd/archiver \
  && export GOPATH=$HOMEDIR

ENV PATH /usr/local/go/bin:$PATH

RUN pip2 install --upgrade pip && pip2 install --upgrade \
 jedi \
 requests \
 pylint \
 cython \
 awscli \
 mycli \
 docker-compose \
 numpy scipy \
 virtualenv \
 neovim

RUN pip install --upgrade pip && pip install --upgrade \
 jedi \
 requests \
 pylint \
 cython \
 awscli \
 mycli \
 docker-compose \
 numpy scipy \
 virtualenv \
 neovim

RUN mkdir $HOMEDIR/.config \
  && wget https://github.com/ok-borg/borg/releases/download/v0.0.1/borg_linux_amd64 -O $HOMEDIR/bin/borg \
  && chmod 755 $HOMEDIR/bin/borg \
  && localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS \
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

ENV LANG=ja_JP.UTF-8

RUN apt-get clean \
  && apt-get autoremove \
  && dpkg -l 'linux-*' \
  | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' \
  | xargs sudo apt-get -y purge

## vim plugins
ADD nvim $HOMEDIR/.config/nvim
ADD bash_profile $HOMEDIR/.bash_profile
ADD bash_prompt $HOMEDIR/.bash_prompt
ADD templates $HOMEDIR/.templates
ADD functions $HOMEDIR/.functions
ADD tmux.conf $HOMEDIR/.tmux.conf
ADD git-completion $HOMEDIR/.git-completion
ADD gitconfig $HOMEDIR/.gitconfig
ADD tigrc $HOMEDIR/.tigrc
RUN mkdir $HOMEDIR/.docker
ADD docker-config.json $HOMEDIR/.docker/config.json
ADD fzf.bash $HOMEDIR/.fzf.bash

RUN chown -R $USER:$USER $HOMEDIR && echo 'source ~/.bash_profile' >> $HOMEDIR/.bashrc

USER $USER

WORKDIR $HOMEDIR

