FROM ubuntu:20.04

ENV DEVENV_VERSION=2.2.0

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
  && apt-get update --fix-missing && apt-get install -y --no-install-recommends\
    apt-transport-https \
    zsh \
    fzf \
    bc \
    build-essential\
    bzip2 \
    ca-certificates \
    connect-proxy \
    curl \
    dbus \
    dnsutils \
    docker.io \
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
    neovim \
    netcat \
    nkf \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    shellcheck \
    silversearcher-ag \
    ripgrep \
    ssh \
    strace \
    sudo \
    tcpdump \
    telnet \
    tig \
    tk-dev\
    tmux \
    traceroute \
    tree \
    tshark \
    unzip \
    wget\
    xz-utils\
    zip \
    zlib1g-dev \
# }}}


### devenv {{{
  && mkdir -p ${DEVENVROOT} \
  && mkdir -p ${DEVENVROOT}/src \
  && mkdir -p ${DEVENVROOT}/bin \
  && mkdir -p ${DEVENVROOT}/pkg \
# }}}


### golang {{{
  && export GOVERSION=1.15.2 \
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


### google cloud sdk {{{
  && export CLOUD_SDK_VERSION=311.0.0 \
  && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && mv /google-cloud-sdk ${DEVENVROOT}/.google-cloud-sdk \
#}}}


### docker {{{
#  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
#  && add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable test edge" \
#  && apt-get update \
#  && apt-get install docker-ce -y \
# }}}


# ### neovim {{{
#   && add-apt-repository -y ppa:neovim-ppa/stable \
#   && apt-get update \
#   && apt-get install neovim -y \
# # }}}


### apt clean {{{
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
# }}}


### go pkgs {{{
  && export GOROOT=${DEVENVROOT}/.go \
  && export PATH=${DEVENVROOT}/.go/bin:$PATH \
  && mkdir -p /usr/local/go \
  && mkdir -p /usr/local/go/src \
  && mkdir -p /usr/local/go/bin \
  && mkdir -p /usr/local/go/pkg \
  && export GOPATH=/usr/local/go \
# }}}


### nodejs {{{
  && export N_PREFIX=${DEVENVROOT}/.n \
  && curl -L https://git.io/n-install | bash -s -- -y \
  && chmod +x ${DEVENVROOT}/.n/bin/n \
  && export PATH=${DEVENVROOT}/.n/bin:$PATH \
  && ${DEVENVROOT}/.n/bin/npm install --global eslint yarn \
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


### terraform {{{
  && export TERRAFORM_VERSION=0.13.3 \
  && curl -o ./terraform.zip -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip ./terraform.zip \
  && chmod +x ./terraform \
  && mv ./terraform ${DEVENVROOT}/bin/ \
#}}}


### termshark {{{
  && export TERMSHARK_VERSION=2.1.1 \
  && wget https://github.com/gcla/termshark/releases/download/v${TERMSHARK_VERSION}/termshark_${TERMSHARK_VERSION}_linux_x64.tar.gz \
  && tar -zxvf termshark_${TERMSHARK_VERSION}_linux_x64.tar.gz \
  && mv termshark_${TERMSHARK_VERSION}_linux_x64/termshark  ${DEVENVROOT}/bin \
  && rm -r termshark_${TERMSHARK_VERSION}_linux_x64* \
# }}}


### ttyd {{{
  && export TTYD_VERSION=1.6.1 \
  && wget https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd_linux.x86_64 \
  && mv ttyd_linux.x86_64 ${DEVENVROOT}/bin/ttyd \
  && chmod +x ${DEVENVROOT}/bin/ttyd \
# }}}


### kubectl {{{
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  && mv kubectl ${DEVENVROOT}/bin/kubectl \
  && chmod +x ${DEVENVROOT}/bin/kubectl \
# }}}


### timezone {{{
  && ln -sf /usr/share/zoneinfo/Asia//Tokyo /etc/localtime \
# }}}


### lang {{{
  # && localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS \
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja" \
# }}}

### move DEVENVROOT/bin to DEVENVROOT/.devenv_bin {{{
  && mv ${DEVENVROOT}/bin ${DEVENVROOT}/.devenv_bin \
  && mkdir -p ${DEVENVROOT}/bin
# }}}

# 日本語の入力に必要
ENV LANG=ja_JP.UTF-8

### nvim & dotfiles {{{
COPY nvim ${DEVENVROOT}/.config/nvim
COPY bashrc ${DEVENVROOT}/.bashrc
COPY bash_prompt ${DEVENVROOT}/.bash_prompt
COPY templates ${DEVENVROOT}/.templates
COPY functions ${DEVENVROOT}/.functions
COPY tmux.conf ${DEVENVROOT}/.tmux.conf
COPY git-prompt ${DEVENVROOT}/.git-prompt
COPY git-completion ${DEVENVROOT}/.git-completion
COPY gitconfig ${DEVENVROOT}/.gitconfig
COPY tigrc ${DEVENVROOT}/.tigrc
COPY fzf.bash ${DEVENVROOT}/.fzf.bash
COPY sudo_as_admin_successful ${DEVENVROOT}/.sudo_as_admin_successful
# }}}


# vim: foldmethod=marker foldlevel=0
