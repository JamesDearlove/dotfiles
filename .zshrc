# Turn off all beeps
# unsetopt BEEP
# Turn off autocomplete beeps
unsetopt LIST_BEEP

# oh my zsh config

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

# oh my zsh plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# pyenv autocomplete
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# terraform tab completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
eval "$(pyenv init -)"
