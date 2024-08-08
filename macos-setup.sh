#!/bin/bash

# Rosetta 2
softwareupdate --install-rosetta --agree-to-license

# Xcode tools
# TODO: Not headless
# xcode-select --install

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask iterm2 visual-studio-code raycast

brew install nvm displayplacer

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k



# Defaults pls
defaults write -g ApplePressAndHoldEnabled -bool false
