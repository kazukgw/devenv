FROM ubuntu

ENV DEVENV_VERSION=1.10.1

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
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    shellcheck \
    silversearcher-ag \
    software-properties-common \
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
  && export GOVERSION=1.13.5 \
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
  && export CLOUD_SDK_VERSION=273.0.0 \
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
  && apt-get install neovim -y \
# }}}


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


### fzf {{{
  && git clone --depth 1 https://github.com/junegunn/fzf.git ${DEVENVROOT}/.fzf \
  && ${DEVENVROOT}/.fzf/install --all \
#}}}


### terraform {{{
  && curl -o ./terraform.zip -L https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip \
  && unzip ./terraform.zip \
  && chmod +x ./terraform \
  && mv ./terraform ${DEVENVROOT}/bin/ \
#}}}


### termshark {{{
  && wget https://github.com/gcla/termshark/releases/download/v2.0.0/termshark_2.0.0_linux_x64.tar.gz \
  && tar -zxvf termshark_2.0.0_linux_x64.tar.gz \
  && mv termshark_2.0.0_linux_x64/termshark  ${DEVENVROOT}/bin \
  && rm -r termshark_2.0.0_linux_x64* \
# }}}


### timezone {{{
  && ln -sf /usr/share/zoneinfo/Asia//Tokyo /etc/localtime \
# }}}


### lang {{{
  # && localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS \
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

ENV LANG ja_JP.UTF-8
# }}}


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
COPY docker-config.json ${DEVENVROOT}/.docker/config.json
COPY fzf.bash ${DEVENVROOT}/.fzf.bash
COPY sudo_as_admin_successful ${DEVENVROOT}/.sudo_as_admin_successful
# }}}


# vim: foldmethod=marker foldlevel=0
