#!/bin/bash

# Rosetta 2
softwareupdate --install-rosetta --agree-to-license

# Xcode tools
# TODO: Not headless
# xcode-select --install
xcode_check=$(xcode-select -p 1>/dev/null;echo $?)
if [ xcode_check == "2" ]; then
    xcode-select --install
fi

# Install Brew
which -s brew
if [[ $? != 0 ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install --cask eloston-chromium firefox iterm2 raycast rectangle visual-studio-code xcodes

brew install mtr neovim nvm pipx fzf 

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Defaults pls
defaults write -g ApplePressAndHoldEnabled -bool false

echo "== Copying Configs =="
cp ./.zshrc ~
cp ./.zprofile ~
cp ./.p10k.zsh ~
cp -r ./.config ~

