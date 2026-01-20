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

# Mandatory apps
brew install --cask eloston-chromium firefox iterm2 visual-studio-code xcodes

# Less needed
brew install --cask jordanbaird-ice rectangle alt-tab raycast

# And then command line things
brew install mtr neovim nvm pipx fzf ripgrep 

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# System Tweaks (most need a reboot)
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -float 15.0
defaults write -g KeyRepeat -float 1.0
defaults write com.apple.Dock showAppExposeGestureEnabled -bool true

# And kill the Dock (for those that don't need a reboot)
killall Dock

# Moving towards using symlinks now. Keep the old ones just in case.
if [[ -f $HOME/.zshrc ]]; then
    echo "== Backing up old configs =="
    mv $HOME/.zshrc $HOME/.zshrc.old
    mv $HOME/.zprofile $HOME/.zprofile.old
    mv $HOME/.p10k.zsh $HOME/.p10k.zsh.old
    mv $HOME/.config/nvim $HOME/.config/nvm.old
fi

if [[ ! -s $HOME/.zshrc ]]; then
    echo "== Symlink Configs =="
    ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
    ln -s $HOME/dotfiles/.zprofile $HOME/.zprofile
    ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh 
    ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim
fi
