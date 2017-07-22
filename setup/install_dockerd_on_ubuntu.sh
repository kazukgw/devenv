#!/bin/bash
echo ""
echo ">> apt-get update"
echo ""
sudo apt-get update

echo ""
echo ">> sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common"
echo ""
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

echo ""
echo ">> curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
echo ""
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo ""
echo ">> sudo add-apt-repository \
 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable'"
echo ""
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo ""
echo ">> sudo apt-get update"
echo ""
sudo apt-get update

echo ""
echo ">> sudo apt-get install docker-ce"
echo ""
sudo apt-get install docker-ce
