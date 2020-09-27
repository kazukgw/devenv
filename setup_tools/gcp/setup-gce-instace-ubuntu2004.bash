#!/bin/bash

# Cloud NAT や Firewall の設定(IAPの Range を Allow しておくなど) は事前に設定済みとする

sudo apt update
sudo apt install git vim docker.io docker-compose -y

sudo usermod -aG docker $(whoami)

mkdir -p devenv/src
mkdir -p devenv/bin
mkdir -p devenv/pkg
mkdir -p devenv/tmp

git clone https://github.com/kazukgw/devenv.git $HOME/devenv/devenv

cp -r $HOME/devenv/devenv/setup_tools $HOME/devenv/

vim $HOME/devenv/setup_tools/build_devenv_container.bash

gcloud auth login

gcloud auth configure-docker

(cd $HOME/devenv/setup_tools/ && bash $HOME/devenv/setup_tools/build_devenv_container.bash)

cp $HOME/devenv/setup_tools/docker-compose.yaml.example $HOME/devenv/setup_tools/docker-compose.yaml

vim $HOME/devenv/setup_tools/docker-compose.yaml

# owner を build_devenv_container.bash で指定した user に変更
sudo chown -R 501:501 $HOME/devenv

(cd $HOME/devenv/setup_tools/ && docker-compose up -d)
