FROM ubuntu

ARG USER=devenv
ARG PASSWORD=P@55w0rd

RUN apt-get update && apt-get install -y sudo \
  && groupadd -g 1000 $USER && \
  useradd -g $USER -G sudo -m -s /bin/bash $USER && \
  echo "$USER:$PASSWORD" | chpasswd

RUN apt-get install -y \
  git \
  curl \
  wget \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  mysql-client \
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
  && mkdir /home/$USER/.go \
  && tar -zxvf go1.7.1.linux-amd64.tar.gz -C /home/$USER/.go \
  && rm go1.7.1.linux-amd64.tar.gz \
  && chown -R $USER:$USER /home/$USER/.go

ENV GOROOT /home/$USER/.go/go
ENV GOPATH /home/$USER
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
    && apt-get install docker-engine -y

## neovim
RUN add-apt-repository -y ppa:neovim-ppa/unstable \
  && apt-get update \
  && apt-get install neovim -y

## apt pkgs
RUN apt-get install -y \
  jq \
  tig \
  g++ \
  gfortran \
  silversearcher-ag \
  nkf \
  htop \
  git-extras \
  exuberant-ctags

RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/$USER/.fzf \
  && /home/$USER/.fzf/install

ENV PATH /home/$USER/.fzf/bin:$PATH

## go pkgs
RUN go get -u github.com/motemen/ghq \
  && go get -u github.com/laurent22/massren \
  && go get -u github.com/dinedal/textql/...

RUN pip install --upgrade \
 jedi \
 requests \
 pylint \
 cython \
 awscli \
 mycli \
 neovim

RUN mkdir /home/$USER/.config \
  && git clone https://github.com/b4b4r07/enhancd /home/$USER/.config/enhancd \
  && wget https://github.com/ok-borg/borg/releases/download/v0.0.1/borg_linux_amd64 -O /home/$USER/bin/borg \
  && chmod 755 /home/$USER/bin/borg

## vim plugins
ADD nvim /home/$USER/.config/nvim
ADD bash_profile /home/$USER/.bash_profile
ADD bash_prompt /home/$USER/.bash_prompt
ADD templates /home/$USER/.templates
ADD functions /home/$USER/.functions
ADD tmux.conf /home/$USER/.tmux.conf
ADD git-completion /home/$USER/.git-completion
ADD gitconfig /home/$USER/.gitconfig

RUN chown -R $USER:$USER /home/$USER && echo 'source ~/.bash_profile' >> /home/$USER/.bashrc

USER devenv

WORKDIR /home/devenv

