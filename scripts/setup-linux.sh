#!/bin/bash

set -e

LSB_RELEASE=$(lsb_release -cs)
ARCHITECTURE=$(dpkg --print-architecture)
SCRIPT_FOLDER=$(dirname -- "$0")

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
    software-properties-common unzip
 
echo "== Installers =="

# docker, azure cli, terraform, zsh, gh
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
    docker-compose-plugin azure-cli terraform zsh gh

# pipx, poetry
sudo apt-get install -y pipx
pipx install poetry

# nvm nodejs & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# neovim
echo "== App - neovim =="
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
if [[ -d /opt/nvim-linux-x86_64 ]]; then
    sudo rm -rf /opt/nvim-linux-x86_64
fi
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# fzf - Ubuntu APT versions of this are always way out of date
echo "== App - fzf =="
curl -LO https://github.com/junegunn/fzf/releases/download/v0.62.0/fzf-0.62.0-linux_amd64.tar.gz
if [[ -d /opt/fzf/ ]]; then
    sudo rm -rf /opt/fzf/
fi
sudo mkdir /opt/fzf/
sudo tar -C /opt/fzf/ -xzf fzf-0.62.0-linux_amd64.tar.gz
rm fzf-0.62.0-linux_amd64.tar.gz

# oh my zsh - Dont reinstall if it's here.
if [[ ! -d $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sudo chsh -s $(which zsh) $(whoami)
    
    # powerline10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Moving towards using symlinks now. Keep the old ones just in case.
if [[ ! -L $HOME/.zshrc ]]; then
    if [[ -f $HOME/.zshrc ]]; then
        echo "== Backing up old configs =="
        mv $HOME/.zshrc $HOME/.zshrc.old
        mv $HOME/.zprofile $HOME/.zprofile.old
        mv $HOME/.p10k.zsh $HOME/.p10k.zsh.old
        mv $HOME/.config/nvim $HOME/.config/nvm.old
    fi

    echo "== Symlink configs =="
    ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
    ln -s $HOME/dotfiles/.zprofile $HOME/.zprofile
    ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh 
    ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim
fi

echo "== Done =="
