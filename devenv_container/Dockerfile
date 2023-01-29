################################### stage1
FROM ubuntu:22.04 as stage1


ARG USER="devenv"
ARG USERID="501"
ARG PASSWORD="devenv"
ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv

ENV DEBIAN_FRONTEND=noninteractive


## create user, group, home
RUN groupadd -g $USERID $USER \
  && useradd -u $USERID -g $USER -G sudo -m -d $HOMEDIR -s /bin/bash $USER \
  && echo "$USER:$PASSWORD" | chpasswd \
  && mkdir -p $DEVENVROOT/bin \

## apt {{{
  && apt-get update --fix-missing \
  && apt-get install -y wget software-properties-common gnupg \
  && apt-get update --fix-missing && apt-get install -y --no-install-recommends\
    # gfortran \
    # tmux \
    apt-transport-https \
    bc \
    bison \
    bubblewrap \
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
    traceroute \
    tree \
    tshark \
    unzip \
    wget\
    xz-utils\
    zip \
    zlib1g-dev \
    zsh \
    && apt install  -y --no-install-recommends -o Dpkg::Options::="--force-overwrite" bat \
# }}}


### devenv {{{
  && mkdir ${HOMEDIR}/src \
  && mkdir ${HOMEDIR}/bin \
  && mkdir ${HOMEDIR}/pkg \
# }}}


### tmux {{{
  && ( \
    curl -sSL -o tmux-3.3a.tar.gz https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz \
    && tar zxvf tmux-3.3a.tar.gz \
    && cd tmux-3.3a \
    && ./configure \
    && make \
    && make install \
  ) \
# }}}


### neovim {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -o nvim-linux64.deb -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb \
    && apt install ./nvim-linux64.deb -f \
  ) \
# }}}


### apt clean {{{
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
# }}}




################################### stage2
FROM stage1 as stage2

ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv

### fzf {{{
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ${HOMEDIR}/.fzf \
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
    export CLOUD_SDK_VERSION=412.0.0 \
    && set -x; cd "$(mktemp -d)" \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && mv google-cloud-sdk ${HOMEDIR}/.google-cloud-sdk \
  ) \
# }}}


### terraform {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && git clone https://github.com/tfutils/tfenv.git $HOMEDIR/.tfenv \
    && export TERRAFORM_VERSION=1.3.6 \
    && curl -o ./terraform.zip -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform.zip \
    && chmod +x ./terraform \
    && mv ./terraform ${DEVENVROOT}/bin/ \
  ) \
#}}}


### termshark {{{
  && ( \
    export TERMSHARK_VERSION=2.4.0 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://github.com/gcla/termshark/releases/download/v${TERMSHARK_VERSION}/termshark_${TERMSHARK_VERSION}_linux_x64.tar.gz \
    && tar -zxvf termshark_${TERMSHARK_VERSION}_linux_x64.tar.gz \
    && mv termshark_${TERMSHARK_VERSION}_linux_x64/termshark  ${DEVENVROOT}/bin \
    && rm -r termshark_${TERMSHARK_VERSION}_linux_x64* \
  ) \
# }}}


### ttyd {{{
  && ( \
    export TTYD_VERSION=1.7.2 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.x86_64 \
    && mv ttyd.x86_64 ${DEVENVROOT}/bin/ttyd \
    && chmod +x ${DEVENVROOT}/bin/ttyd \
  ) \
# }}}


### lf {{{
  && curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | tar xzC ${DEVENVROOT}/bin \
  && mkdir -p ${HOMEDIR}/.config/lf
# }}}




################################### stage3
FROM stage1 as stage3

ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv

### kubectl {{{
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
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
  && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64 \
  && chmod +x ./kind \
  && mv ./kind ${DEVENVROOT}/bin/kind \
# }}}


### k9s {{{
  && ( \
    export K9S_VERSION="0.26.7" \
    && set -x; cd "$(mktemp -d)" \
    && curl -sSL -o k9s.tar.gz https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz \
    && tar zxvf k9s.tar.gz \
    && chmod +x k9s \
    && mv k9s ${DEVENVROOT}/bin/ \
  )
# }}}



################################### stage4
FROM stage1 as stage4

ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv

### golang {{{
RUN ( \
    export GOVERSION=1.19.4 \
    && set -x; cd "$(mktemp -d)" \
    && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
    && tar -zxvf go${GOVERSION}.linux-amd64.tar.gz \
    && mv go ${HOMEDIR}/.go \
    && rm go${GOVERSION}.linux-amd64.tar.gz \
  ) \
# }}}

## go pkgs {{{
  && export GOROOT=${HOMEDIR}/.go \
  && export PATH=${HOMEDIR}/.go/bin:$PATH \
  && mkdir -p ${DEVENVROOT}/go \
  && mkdir -p ${DEVENVROOT}/go/src \
  && mkdir -p ${DEVENVROOT}/go/bin \
  && mkdir -p ${DEVENVROOT}/go/pkg \
  && export GOPATH=${DEVENVROOT}/go \
  && go install github.com/x-motemen/ghq@latest \
  && go install github.com/itchyny/mmv/cmd/mmv@latest \
  && go install github.com/mattn/efm-langserver@latest \
  && go install github.com/go-delve/delve/cmd/dlv@latest \
  && go install github.com/mholt/archiver/cmd/arc@latest \
  && go install github.com/laurent22/massren@latest \
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
  purescript \
  spago \
# }}}

### ocaml {{{
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -o opam -sLl https://github.com/ocaml/opam/releases/download/2.1.4/opam-2.1.4-x86_64-linux \
    && chmod +x opam \
    && mv opam ${DEVENVROOT}/bin/opam \
  )
# }}}


################################### stage5
FROM stage1 as stage5

ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv

### rust {{{
RUN ( \
    set -x; cd "$(mktemp -d)" \
    && export RUSTUP_HOME=${HOMEDIR}/.rustup \
    && export CARGO_HOME=${HOMEDIR}/.cargo \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz -o rust-analyzer.gz \
    && gzip -d -c rust-analyzer.gz > ${DEVENVROOT}/bin/rust-analyzer \
    && chmod +x ${DEVENVROOT}/bin/rust-analyzer \
  ) \
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
  && curl -s "https://get.sdkman.io" | bash
# }}}



################################### stage6
# FROM stage1 as stage6
#
# ARG HOMEDIR=/home/devenv
# ARG DEVENVROOT=/home/devenv/.devenv
#
#
# ### haskell {{{
# RUN ( \
#     set -x; cd "$(mktemp -d)" \
#     && export GHCUP_INSTALL_BASE_PREFIX=${HOMEDIR} \
#     && export BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
#     && curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh \
#   )
# # }}}
#
#
# ################################# stage7
# FROM stage1 as stage7
#
# ARG HOMEDIR=/home/devenv
# ARG DEVENVROOT=/home/devenv/.devenv
#
#
# ### PureScript {{{
# RUN ( \
#     set -x; cd "$(mktemp -d)" \
#     && curl -L https://github.com/purescript/purescript/releases/download/v0.15.7/linux64.tar.gz -o linux64.tar.gz \
#     && tar xzvf linux64.tar.gz \
#     && chmod +x ./purescript/purs \
#     && cp ./purescript/purs ${DEVENVROOT}/bin/ \
#   )
# # }}}


################################# stage8
FROM stage1 as stage8

ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv

COPY --from=stage2 --chown=devenv:devenv ${HOMEDIR} ${HOMEDIR}
COPY --from=stage3 --chown=devenv:devenv ${HOMEDIR} ${HOMEDIR}
COPY --from=stage4 --chown=devenv:devenv ${HOMEDIR} ${HOMEDIR}
COPY --from=stage5 --chown=devenv:devenv ${HOMEDIR} ${HOMEDIR}
# COPY --from=stage6 --chown=devenv:devenv ${HOMEDIR} ${HOMEDIR}
# COPY --from=stage7 --chown=devenv:devenv ${HOMEDIR} ${HOMEDIR}
# }}}


### nvim & dotfiles {{{
COPY --chown=devenv:devenv nvim ${HOMEDIR}/.config/nvim
COPY --chown=devenv:devenv zshrc ${HOMEDIR}/.zshrc
COPY --chown=devenv:devenv functions ${HOMEDIR}/.functions
COPY --chown=devenv:devenv tmux.conf ${HOMEDIR}/.tmux.conf
COPY --chown=devenv:devenv gitconfig ${HOMEDIR}/.gitconfig
COPY --chown=devenv:devenv tigrc ${HOMEDIR}/.tigrc
COPY --chown=devenv:devenv fzf.zsh ${HOMEDIR}/.fzf.zsh
COPY --chown=devenv:devenv lfrc ${HOMEDIR}/.config/lf/lfrc
COPY --chown=devenv:devenv lfcd.sh ${HOMEDIR}/.lfcd.sh
COPY --chown=devenv:devenv sudo_as_admin_successful ${HOMEDIR}/.sudo_as_admin_successful
COPY --chown=devenv:devenv starship.toml ${HOMEDIR}/.config/starship.toml
# }}}



################################### stage9
FROM stage1 as devenv

ARG USER="devenv"
ARG USERID="501"
ARG PASSWORD="devenv"
ARG HOMEDIR=/home/devenv
ARG DEVENVROOT=/home/devenv/.devenv


ENV DEVENV_VERSION=5.3.0

# golang
ENV GOROOT $HOMEDIR/.go
ENV GOPATH $HOMEDIR
ENV PATH $GOPATH/bin:$GOROOT/bin:${DEVENVROOT}/go/bin:$PATH

# sdkman & java
ENV PATH $HOMEDIR/.sdkman/bin:$PATH

# node
ENV N_PREFIX $HOMEDIR/.n
ENV PATH $HOMEDIR/.n/bin:$PATH

## pyenv
ENV PATH $HOMEDIR/.pyenv/bin:$PATH
ENV PYENV_ROOT $HOMEDIR/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH


# 日本語の入力に必要
ENV LANG=ja_JP.UTF-8

COPY --from=stage8 ${HOMEDIR} ${HOMEDIR}

### starship {{{
RUN ( \
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y \
  ) \
# }}}


### timezone {{{
  && ln -sf /usr/share/zoneinfo/Asia//Tokyo /etc/localtime \
# }}}


### lang {{{
  && update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja" \
# }}}


### chsh {{{
  && chsh devenv -s /usr/bin/zsh
# }}}


USER $USER
WORKDIR $HOMEDIR

# RUN /bin/bash -c 'source ~/.sdkman/bin/sdkman-init.sh \
#   && sdk update \
#   && sdk install java' \
#   && /bin/bash -c '\
#   if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi \
#   && pyenv install 3.11.0'

RUN /bin/bash -c '\
    if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi \
    && pyenv install 3.11.0 \
    && /home/devenv/.devenv/bin/opam init -y -n --disable-sandboxing \
    && /home/devenv/.devenv/bin/opam install -y core ocaml-lsp-server ocamlformat utop'

# vim: foldmethod=marker foldlevel=0
