#!/bin/bash

set -e

LSB_RELEASE=$(lsb_release -cs)
STARTING_FOLDER=$(pwd)
ARCHITECTURE=$(dpkg --print-architecture)

echo "=== Jimmy Linux dev setup ==="

echo "== APT Sources =="

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$ARCHITECTURE signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$LSB_RELEASE stable" | sudo tee /etc/apt/sources.list.d/docker.list

# microsoft
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --yes -o /usr/share/keyrings/microsoft.gpg

echo "deb [arch=$ARCHITECTURE signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-$LSB_RELEASE-prod \
$LSB_RELEASE main" | sudo tee /etc/apt/sources.list.d/microsoft.list

# azure cli (uses microsoft gpg)
echo "deb [arch=$ARCHITECTURE signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ \
$LSB_RELEASE main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/hashicorp.gpg

echo "deb [arch=$ARCHITECTURE signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com \
$LSB_RELEASE main" | sudo tee /etc/apt/sources.list.d/hashicorp.list 

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/github-cli.gpg

echo "deb [arch=$ARCHITECTURE signed-by=/usr/share/keyrings/github-cli.gpg] https://cli.github.com/packages stable main" \
| sudo tee /etc/apt/sources.list.d/github-cli.list


echo "== Dependencies =="

sudo apt-get update
sudo apt-get upgrade -y

# combined deps for: python build, docker, azure cli, terraform

sudo apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    apt-transport-https ca-certificates gnupg lsb-release \
    software-properties-common unzip glib-networking
 
echo "== Installers =="

# docker, azure cli, terraform, zsh, gh
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
    docker-compose-plugin azure-cli terraform zsh gh

# pipx, poetry
sudo apt-get install -y pipx
pipx install poetry

# nvm nodejs & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# neovim 
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo chsh -s $(which zsh) $(whoami)

# powerline10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "== Copying Configs =="
cp ./.zshrc ~
cp ./.zprofile ~
cp ./.p10k.zsh ~
cp -r ./.config ~

echo "== Done =="
