FROM ubuntu:20.04

ENV DEVENV_VERSION=2.5.0

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
    netcat \
    ngrep \
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
    && apt install  -y --no-install-recommends -o Dpkg::Options::="--force-overwrite" bat \
# }}}


### devenv {{{
  && mkdir -p ${DEVENVROOT} \
  && mkdir -p ${DEVENVROOT}/src \
  && mkdir -p ${DEVENVROOT}/bin \
  && mkdir -p ${DEVENVROOT}/pkg \
# }}}


### golang {{{
  && ( \
    export GOVERSION=1.16.3 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
    && mkdir -p ${DEVENVPATH}/.go \
    && tar -zxvf go${GOVERSION}.linux-amd64.tar.gz -C ${DEVENVROOT} \
    && mv ${DEVENVROOT}/go  ${DEVENVROOT}/.go \
    && rm go${GOVERSION}.linux-amd64.tar.gz \
  ) \
# }}}


### fzf {{{
  && git clone --depth 1 https://github.com/junegunn/fzf.git ${DEVENVROOT}/.fzf \
  && ${DEVENVROOT}/.fzf/install --bin \
# }}}


### lemonade {{{
  && ( \
    export LEMONADE_VERSION=v1.1.1 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://github.com/lemonade-command/lemonade/releases/download/${LEMONADE_VERSION}/lemonade_linux_amd64.tar.gz \
    && tar -zxvf lemonade_linux_amd64.tar.gz \
    && mv lemonade ${DEVENVROOT}/bin/ \
    && rm lemonade_linux_amd64.tar.gz \
  ) \
# }}}


### gdrive {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -fsL -o gdrive 'https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download' \
    && chmod +x gdrive \
    && mv gdrive ${DEVENVROOT}/bin/ \
  ) \
# }}}


### rclone {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip rclone-current-linux-amd64.zip \
    && cd rclone-*-linux-amd64 \
    && chmod +x rclone \
    && cp rclone ${DEVENVROOT}/bin/ \
  ) \
# }}}


### google cloud sdk {{{
  && ( \
    export CLOUD_SDK_VERSION=338.0.0 \
    && set -x; cd "$(mktemp -d)" \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && mv google-cloud-sdk ${DEVENVROOT}/.google-cloud-sdk \
  ) \
# }}}


### docker {{{
#  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
#  && add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable test edge" \
#  && apt-get update \
#  && apt-get install docker-ce -y \
# }}}


### neovim {{{
  && add-apt-repository -y ppa:neovim-ppa/unstable \
  && apt-get update \
  && apt-get install neovim -y \
# }}}


### terraform-ls {{{
  && curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
  && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  && sudo apt-get update && sudo apt-get install terraform-ls \
# }}}


### apt clean {{{
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
# }}}


### nodejs {{{
  && export N_PREFIX=${DEVENVROOT}/.n \
  && curl -L https://git.io/n-install | bash -s -- -y \
  && chmod +x ${DEVENVROOT}/.n/bin/n \
  && export PATH=${DEVENVROOT}/.n/bin:$PATH \
  && ${DEVENVROOT}/.n/bin/npm install --global \
  eslint \
  yarn \
  prettier \
  vim-language-server \
  typescript-language-server \
  yaml-language-server \
  bash-language-server \
  vscode-html-languageserver-bin \
  vscode-css-languageserver-bin \
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
    black \
# }}}


### java {{{
  && export SDKMAN_DIR=${DEVENVROOT}/.sdkman \
  && curl -s "https://get.sdkman.io" | bash \
# }}}


### terraform {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && git clone https://github.com/tfutils/tfenv.git $DEVENVROOT/.tfenv \
    && export TERRAFORM_VERSION=0.15.1 \
    && curl -o ./terraform.zip -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform.zip \
    && chmod +x ./terraform \
    && mv ./terraform ${DEVENVROOT}/bin/ \
  ) \
#}}}


### termshark {{{
  && ( \
    export TERMSHARK_VERSION=2.2.0 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://github.com/gcla/termshark/releases/download/v${TERMSHARK_VERSION}/termshark_${TERMSHARK_VERSION}_linux_x64.tar.gz \
    && tar -zxvf termshark_${TERMSHARK_VERSION}_linux_x64.tar.gz \
    && mv termshark_${TERMSHARK_VERSION}_linux_x64/termshark  ${DEVENVROOT}/bin \
    && rm -r termshark_${TERMSHARK_VERSION}_linux_x64* \
  ) \
# }}}


### ttyd {{{
  && ( \
    export TTYD_VERSION=1.6.3 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.x86_64 \
    && mv ttyd.x86_64 ${DEVENVROOT}/bin/ttyd \
    && chmod +x ${DEVENVROOT}/bin/ttyd \
  ) \
# }}}


### lf {{{
  && curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | tar xzC ${DEVENVROOT}/bin \
  && mkdir -p ${DEVENVROOT}/.config/lf \
# }}}


### git-now {{{
  && git clone --recursive git://github.com/iwata/git-now.git \
  && (cd git-now && make install) \
# }}}


### kubectl {{{
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && mv kubectl ${DEVENVROOT}/bin/kubectl \
  && chmod +x ${DEVENVROOT}/bin/kubectl \
# }}}


### Helm {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && bash get_helm.sh \
  ) \
# }}}


### krew {{{
  && ( \
    export KREW_ROOT=${DEVENV_ROOT}/.krew \
    && mkdir -p $KREW_ROOT \
    && set -x; cd "$(mktemp -d)" \
    && OS="$(uname | tr '[:upper:]' '[:lower:]')" \
    && ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" \
    && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" \
    && tar zxvf krew.tar.gz \
    && KREW=./krew-"${OS}_${ARCH}" \
    && "$KREW" install krew \
  ) \
  && export PATH=${KREW_ROOT}/bin:$PATH \
# }}}


### kind {{{
  && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64 \
  && chmod +x ./kind \
  && mv ./kind ${DEVENV_ROOT}/bin/kind \
# }}}


### k9s {{{
  && curl -sS https://webinstall.dev/k9s | bash \
# }}}


### go pkgs {{{
  && export GOROOT=${DEVENVROOT}/.go \
  && export PATH=${DEVENVROOT}/.go/bin:$PATH \
  && mkdir -p /usr/local/go \
  && mkdir -p /usr/local/go/src \
  && mkdir -p /usr/local/go/bin \
  && mkdir -p /usr/local/go/pkg \
  && export GOPATH=/usr/local/go \
  && go install github.com/x-motemen/ghq@latest \
  && go install github.com/itchyny/mmv/cmd/mmv@latest \
  && go install github.com/mattn/efm-langserver@latest \
  && go install github.com/go-delve/delve/cmd/dlv@latest \
  && go install github.com/mholt/archiver/cmd/arc@latest \
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
COPY cheatsheets ${DEVENVROOT}/.cheatsheets
COPY functions ${DEVENVROOT}/.functions
COPY tmux.conf ${DEVENVROOT}/.tmux.conf
COPY git-prompt ${DEVENVROOT}/.git-prompt
COPY git-completion ${DEVENVROOT}/.git-completion
COPY gitconfig ${DEVENVROOT}/.gitconfig
COPY tigrc ${DEVENVROOT}/.tigrc
COPY fzf.bash ${DEVENVROOT}/.fzf.bash
COPY fzf-command.bash ${DEVENVROOT}/.fzf-command.bash
COPY lfrc ${DEVENVROOT}/.config/lf/lfrc
COPY lfcd.sh ${DEVENVROOT}/.lfcd.sh
COPY sudo_as_admin_successful ${DEVENVROOT}/.sudo_as_admin_successful
# }}}


# vim: foldmethod=marker foldlevel=0
