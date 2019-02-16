FROM ubuntu

ENV DEVENV_VERSION=1.7.1

ENV DEVENVROOT=/home/devenv

## for ubuntu 18.04 tzdata
ENV DEBIAN_FRONTEND=noninteractive


### do apt-get update and install wget due to get repository {{{
RUN apt-get update --fix-missing \
  && apt-get install -y wget software-properties-common gnupg \
# }}}


### change repository {{{
  && wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - \
  && wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - \
  && wget https://www.ubuntulinux.jp/sources.list.d/xenial.list -O /etc/apt/sources.list.d/ubuntu-ja.list \
  && echo "Package: *\nPin: origin \"archive.ubuntulinux.jp\"\nPin-Priority: 600\n" > /etc/apt/preferences \
# }}}


### apt pkgs {{{
  && apt-get update --fix-missing && apt-get install -y \
    apt-transport-https \
    bc \
    build-essential\
    bzip2 \
    ca-certificates \
    connect-proxy \
    curl \
    dbus \
    dnsutils \
    exuberant-ctags \
    g++ \
    gawk \
    gfortran \
    git \
    git-extras \
    htop \
    ibus \
    iproute2 \
    iputils-ping \
    jq \
    language-pack-ja \
    language-pack-ja-base \
    less \
    libbz2-dev\
    libffi-dev\
    libncurses5-dev\
    libreadline-dev\
    libsqlite3-dev\
    libssl-dev\
    libxml2-dev\
    libxmlsec1-dev\
    llvm\
    lsof \
    make \
    man \
    mysql-client \
    netcat \
    nkf \
    python \
    python-dev \
    python-setuptools \
    python-pip \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    shellcheck \
    silversearcher-ag \
    software-properties-common \
    strace \
    sudo \
    tcpdump \
    telnet \
    tig \
    tk-dev\
    tmux \
    traceroute \
    tree \
    unzip \
    wget\
    xz-utils\
    zip \
    zlib1g-dev\
# }}}


### devenv {{{
  && mkdir -p ${DEVENVROOT} \
  && mkdir -p ${DEVENVROOT}/src \
  && mkdir -p ${DEVENVROOT}/bin \
  && mkdir -p ${DEVENVROOT}/pkg \
# }}}


### golang {{{
  && export GOVERSION=1.11.4 \
  && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
  && mkdir -p ${DEVENVPATH}/.go \
  && tar -zxvf go${GOVERSION}.linux-amd64.tar.gz -C ${DEVENVROOT} \
  && mv ${DEVENVROOT}/go  ${DEVENVROOT}/.go \
  && rm go${GOVERSION}.linux-amd64.tar.gz \
# }}}


### lemonade {{{
  && export LEMONADE_VERSION=v1.1.1 \
  && wget https://github.com/lemonade-command/lemonade/releases/download/${LEMONADE_VERSION}/lemonade_linux_amd64.tar.gz \
  && tar -zxvf lemonade_linux_amd64.tar.gz \
  && mv lemonade ${DEVENVROOT}/bin/ \
  && rm lemonade_linux_amd64.tar.gz \
# }}}


### gdrive {{{
  && curl -fsL -o gdrive 'https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download' \
  && chmod +x gdrive \
  && mv gdrive ${DEVENVROOT}/bin/ \
# }}}


### tldr {{{
  && export TLDR_VERSION=0.5.0 \
  && curl -OL https://github.com/isacikgoz/tldr/releases/download/v${TLDR_VERSION}/tldr_${TLDR_VERSION}_linux_amd64.tar.gz \
  && tar xzf tldr_${TLDR_VERSION}_linux_amd64.tar.gz \
  && chmod +x tldr \
  && mv tldr ${DEVENVROOT}/bin/ \
  && rm tldr_${TLDR_VERSION}_linux_amd64.tar.gz \
# }}}


### google cloud sdk {{{
  && export CLOUD_SDK_VERSION=228.0.0 \
  && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && mv /google-cloud-sdk ${DEVENVROOT}/.google-cloud-sdk \
#}}}


### docker {{{
  && apt-get update \
  && apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
  && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable test edge" \
  && apt-get update \
  && apt-get install docker-ce -y \
# }}}


### neovim {{{
  && add-apt-repository -y ppa:neovim-ppa/stable \
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
# }}}


### nodejs {{{
  && export N_PREFIX=${DEVENVROOT}/.n \
  && curl -L https://git.io/n-install | bash -s -- -y \
  && chmod +x ${DEVENVROOT}/.n/bin/n \
  && export PATH=${DEVENVROOT}/.n/bin:$PATH \
  && ${DEVENVROOT}/.n/bin/npm install --global eslint babel-eslint tern \
# }}}


### python {{{
  && git clone https://github.com/pyenv/pyenv.git $DEVENVROOT/.pyenv \
  && rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python \
  && rm -f /usr/bin/pip && ln -s /usr/bin/pip3 /usr/bin/pip \
  && pip install --upgrade \
    pipenv \
    requests \
    pylint \
    awscli \
    mycli \
    docker-compose \
    virtualenv \
    flake8 \
    autopep8 \
    neovim \
# }}}


### java {{{
  && export SDKMAN_DIR=${DEVENVROOT}/.sdkman \
  && curl -s "https://get.sdkman.io" | bash \
# }}}


### fzf {{{
  && git clone --depth 1 https://github.com/junegunn/fzf.git ${DEVENVROOT}/.fzf \
  && ${DEVENVROOT}/.fzf/install --all \
#}}}


### terraform {{{
  && curl -o ./terraform.zip -L https://releases.hashicorp.com/terraform/0.11.2/terraform_0.11.2_linux_amd64.zip \
  && unzip ./terraform.zip \
  && chmod +x ./terraform \
  && mv ./terraform ${DEVENVROOT}/bin/ \
#}}}


### lang {{{
  # && localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS \
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

ENV LANG ja_JP.UTF-8
# }}}


### nvim & dotfiles {{{
ADD nvim ${DEVENVROOT}/.config/nvim
ADD bash_profile ${DEVENVROOT}/.bash_profile
ADD bashrc ${DEVENVROOT}/.bashrc
ADD bash_prompt ${DEVENVROOT}/.bash_prompt
ADD templates ${DEVENVROOT}/.templates
ADD note ${DEVENVROOT}/.note
ADD functions ${DEVENVROOT}/.functions
ADD tmux.conf ${DEVENVROOT}/.tmux.conf
ADD git-prompt ${DEVENVROOT}/.git-prompt
ADD git-completion ${DEVENVROOT}/.git-completion
ADD gitconfig ${DEVENVROOT}/.gitconfig
ADD tigrc ${DEVENVROOT}/.tigrc
ADD docker-config.json ${DEVENVROOT}/.docker/config.json
ADD fzf.bash ${DEVENVROOT}/.fzf.bash
# }}}


### clean (disabled) {{{
# RUN
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

## change permission
ONBUILD RUN chown -R $USER:$USER $HOMEDIR

ONBUILD USER $USER
ONBUILD WORKDIR $HOMEDIR

ONBUILD ENV PATH $HOME/.sdkman/bin:$PATH
ONBUILD RUN /bin/bash -c 'source ~/.sdkman/bin/sdkman-init.sh \
  && sdk update \
  && sdk install java \
  && sdk install scala \
  && sdk install sbt'

ONBUILD RUN /bin/bash -c 'source ~/.bash_profile \
  && pyenv install 3.7


# }}}

# vim: foldmethod=marker foldlevel=0
