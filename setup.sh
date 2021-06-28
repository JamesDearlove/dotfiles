#!/bin/bash

set -e

LSB_RELEASE=$(lsb_release -cs)

echo "=== Jimmy Dev Environment Setup ==="

echo "== APT Sources =="

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$LSB_RELEASE stable" | sudo tee /etc/apt/sources.list.d/docker.list

# azure cli
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ \
$LSB_RELEASE main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com \
$LSB_RELEASE main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "== Dependencies =="

sudo apt-get update

# python build, docker & azure cli, terraform

sudo apt-get install -y \
make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
apt-transport-https ca-certificates gnupg lsb-release \
software-properties-common

echo "== Installers =="

# docker
sudo apt-get install docker-ce docker-ce-cli containerd.io

# azure cli
sudo apt-get install azure-cli

# terraform cli
sudo apt-get install terraform

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# nvm nodejs & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install node

# zsh
sudo apt-get install -y zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# -- Config Files --
echo "== Copying Configs =="
cp ./.zshrc ~
cp ./.zprofile ~

echo "== Done =="
