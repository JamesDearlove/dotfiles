#!/bin/bash

# Rosetta 2
softwareupdate --install-rosetta --agree-to-license

# Xcode tools
# TODO: Not headless
# xcode-select --install

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask iterm2 visual-studio-code

brew install nvm


