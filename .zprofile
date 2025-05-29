# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$PATH:/Users/james/.dotnet/tools"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PATH="/opt/nvim-linux-x86_64/bin:/opt/fzf:$PATH"
fi
