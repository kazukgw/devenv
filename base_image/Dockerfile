FROM ubuntu:22.04

ENV DEVENV_VERSION=4.1.0

## for ubuntu 18.04 tzdata
ENV DEBIAN_FRONTEND=noninteractive

ARG USER="developer"
ARG USERID="501"
ARG PASSWORD="password"
ARG HOMEDIR=/home/developer
ARG DEVENVROOT=/home/.devenv

## create user, group, home
RUN groupadd -g $USERID $USER \
  && useradd -u $USERID -g $USER -G sudo -m -d $HOMEDIR -s /bin/bash $USER \
  && echo "$USER:$PASSWORD" | chpasswd \
  && mkdir -p $DEVENVROOT/bin \

## apt {{{
  && apt-get update --fix-missing \
  && apt-get install -y wget software-properties-common gnupg \
  && apt-get update --fix-missing && apt-get install -y --no-install-recommends\
    apt-transport-https \
    bc \
    bison \
    build-essential\
    bzip2 \
    ca-certificates \
    connect-proxy \
    curl \
    dbus \
    dnsutils \
    docker.io \
    exuberant-ctags \
    fd-find \
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
    libevent-dev \
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
    ncurses-dev \
    netcat \
    ngrep \
    nkf \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    ripgrep \
    shellcheck \
    silversearcher-ag \
    ssh \
    strace \
    sudo \
    tcpdump \
    telnet \
    tig \
    tk-dev\
    # tmux \
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
  && mkdir ${HOMEDIR}/src \
  && mkdir ${HOMEDIR}/bin \
  && mkdir ${HOMEDIR}/pkg \
# }}}


### tmux {{{
  && ( \
    curl -sSL -o tmux-3.2.tar.gz https://github.com/tmux/tmux/releases/download/3.2/tmux-3.2.tar.gz \
    && tar zxvf tmux-3.2.tar.gz \
    && cd tmux-3.2 \
    && ./configure \
    && make \
    && make install \
  ) \
# }}}


### golang {{{
  && ( \
    export GOVERSION=1.17.5 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
    && tar -zxvf go${GOVERSION}.linux-amd64.tar.gz \
    && mv go  ${HOMEDIR}/.go \
    && rm go${GOVERSION}.linux-amd64.tar.gz \
  ) \
# }}}


### fzf {{{
  && git clone --depth 1 https://github.com/junegunn/fzf.git ${HOMEDIR}/.fzf \
  && ${HOMEDIR}/.fzf/install --bin \
# }}}


### lemonade {{{
  && ( \
    export LEMONADE_VERSION=v1.1.1 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://github.com/lemonade-command/lemonade/releases/download/${LEMONADE_VERSION}/lemonade_linux_amd64.tar.gz \
    && tar zxvf lemonade_linux_amd64.tar.gz \
    && mv lemonade ${DEVENVROOT}/bin/ \
    && rm lemonade_linux_amd64.tar.gz \
  ) \
# }}}


### gdrive {{{
  && ( \
    export GDRIVE_VERSION=2.1.1 \
    && set -x; cd "$(mktemp -d)" \
    && curl -fsL -o gdrive.tar.gz "https://github.com/prasmussen/gdrive/releases/download/${GDRIVE_VERSION}/gdrive_2.1.1_linux_amd64.tar.gz" \
    && tar zxvf gdrive.tar.gz \
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
    export CLOUD_SDK_VERSION=366.0.0 \
    && set -x; cd "$(mktemp -d)" \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && mv google-cloud-sdk ${HOMEDIR}/.google-cloud-sdk \
  ) \
# }}}


### neovim {{{
  && add-apt-repository -y ppa:neovim-ppa/stable \
  && apt-get update \
  && apt-get install neovim -y \
# }}}


### terraform-ls {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && export TERRAFORM_VERSION=1.1.0 \
    && curl -fsSL -o terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && unzip terraform.zip \
    && chmod +x terraform \
    && mv terraform ${DEVENVROOT}/bin/ \
  ) \
# }}}


### apt clean {{{
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
# }}}


### nodejs {{{
  && export N_PREFIX=${HOMEDIR}/.n \
  && curl -L https://git.io/n-install | bash -s -- -y \
  && chmod +x ${HOMEDIR}/.n/bin/n \
  && export PATH=${HOMEDIR}/.n/bin:$PATH \
  && ${HOMEDIR}/.n/bin/npm install --global \
  eslint \
  yarn \
  prettier \
  @google/clasp \
  vim-language-server \
  typescript \
  typescript-language-server \
  svelte-language-server \
  yaml-language-server \
  bash-language-server \
  pyright \
  vscode-langservers-extracted \
  zx \
# }}}


### python {{{
  && git clone https://github.com/pyenv/pyenv.git $HOMEDIR/.pyenv \
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
  && export SDKMAN_DIR=${HOMEDIR}/.sdkman \
  && curl -s "https://get.sdkman.io" | bash \
# }}}


### terraform {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && git clone https://github.com/tfutils/tfenv.git $HOMEDIR/.tfenv \
    && export TERRAFORM_VERSION=1.1.0 \
    && curl -o ./terraform.zip -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform.zip \
    && chmod +x ./terraform \
    && mv ./terraform ${DEVENVROOT}/bin/ \
  ) \
#}}}


### termshark {{{
  && ( \
    export TERMSHARK_VERSION=2.3.0 \
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
  && mkdir -p ${HOMEDIR}/.config/lf \
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


### kustomize {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash \
    && mv kustomize ${DEVENVROOT}/bin/ \
  ) \
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
    export KREW_ROOT=${HOMEDIR}/.krew \
    && mkdir -p $KREW_ROOT/bin \
    && mkdir -p $KREW_ROOT/receipts \
    && touch $KREW_ROOT/receipts/__dummy.yaml \
    && mkdir -p $KREW_ROOT/store \
    && mkdir -p $KREW_ROOT/index \
    && set -x; cd "$(mktemp -d)" \
    && OS="$(uname | tr '[:upper:]' '[:lower:]')" \
    && ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" \
    && KREW="krew-${OS}_${ARCH}" \
    && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" \
    && tar zxvf "${KREW}.tar.gz" \
    && ./"${KREW}" install krew \
  ) \
# }}}


### kind {{{
  && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 \
  && chmod +x ./kind \
  && mv ./kind ${DEVENVROOT}/bin/kind \
# }}}


### Helmfile {{{
  && ( \
    export HELMFILE_VERSION="0.142.0" \
    && set -x; cd "$(mktemp -d)" \
    && curl -fsSL -o helmfile https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 \
    && chmod +x helmfile \
    && mv helmfile ${DEVENVROOT}/bin/ \
  ) \
# }}}


### k9s {{{
  && ( \
    export K9S_VERSION="0.25.8" \
    && set -x; cd "$(mktemp -d)" \
    && curl -sSL -o k9s.tar.gz https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz \
    && tar zxvf k9s.tar.gz \
    && chmod +x k9s \
    && mv k9s ${DEVENVROOT}/bin/ \
  ) \
# }}}


### starship {{{
  && ( \
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y \
  ) \
# }}}


### go pkgs {{{
  && export GOROOT=${HOMEDIR}/.go \
  && export PATH=${HOMEDIR}/.go/bin:$PATH \
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
  && go install github.com/laurent22/massren@latest \
# }}}


### clean tmpdir {{{
  && rm -rf /tmp/* \
# }}}


### timezone {{{
  && ln -sf /usr/share/zoneinfo/Asia//Tokyo /etc/localtime \
# }}}


### lang {{{
  # && localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS \
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja" \
# }}}


### change permission {{{
  && chown -R $USER:$USER $HOMEDIR
# }}}


# 日本語の入力に必要
ENV LANG=ja_JP.UTF-8

### nvim & dotfiles {{{
COPY --chown=developer:developer nvim ${HOMEDIR}/.config/nvim
COPY --chown=developer:developer bashrc ${HOMEDIR}/.bashrc
COPY --chown=developer:developer bash_prompt ${HOMEDIR}/.bash_prompt
COPY --chown=developer:developer templates ${HOMEDIR}/.templates
COPY --chown=developer:developer cheatsheets ${HOMEDIR}/.cheatsheets
COPY --chown=developer:developer functions ${HOMEDIR}/.functions
COPY --chown=developer:developer tmux.conf ${HOMEDIR}/.tmux.conf
COPY --chown=developer:developer git-prompt ${HOMEDIR}/.git-prompt
COPY --chown=developer:developer git-completion ${HOMEDIR}/.git-completion
COPY --chown=developer:developer gitconfig ${HOMEDIR}/.gitconfig
COPY --chown=developer:developer tigrc ${HOMEDIR}/.tigrc
COPY --chown=developer:developer fzf.bash ${HOMEDIR}/.fzf.bash
COPY --chown=developer:developer fzf-command.bash ${HOMEDIR}/.fzf-command.bash
COPY --chown=developer:developer lfrc ${HOMEDIR}/.config/lf/lfrc
COPY --chown=developer:developer lfcd.sh ${HOMEDIR}/.lfcd.sh
COPY --chown=developer:developer sudo_as_admin_successful ${HOMEDIR}/.sudo_as_admin_successful
COPY --chown=developer:developer starship.toml ${HOMEDIR}/.config/starship.toml
# }}}

USER $USER
WORKDIR $HOMEDIR

# golang
ENV GOROOT $HOMEDIR/.go
ENV GOPATH $HOMEDIR
ENV PATH $GOPATH/bin:$GOROOT/bin:/usr/local/go/bin:$PATH

# sdkman & java
ENV PATH $HOMEDIR/.sdkman/bin:$PATH

# node
ENV N_PREFIX $HOMEDIR/.n
ENV PATH $HOMEDIR/.n/bin:$PATH

## pyenv
ENV PATH $HOMEDIR/.pyenv/bin:$PATH
ENV PYENV_ROOT $HOMEDIR/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN /bin/bash -c 'source ~/.sdkman/bin/sdkman-init.sh \
  && sdk update \
  && sdk install java \
  && sdk install maven \
  && sdk install gradle' \
  && /bin/bash -c '\
  if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi \
  && pyenv install 3.9.4'

# vim: foldmethod=marker foldlevel=0
