export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export KEYTIMEOUT=1
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$PATH":"$HOME/.local/scripts/"
export PATH="$PATH":"$HOME/.local/bin"
export PATH="$PATH":"/opt/homebrew/bin/"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export DO_API_TOKEN="$(security find-generic-password -a $USER -s DO_API_TOKEN -w)"
export VERCEL_API_TOKEN="$(security find-generic-password -a $USER -s VERCEL_API_TOKEN -w)"
export GITHUB_API_TOKEN="$(security find-generic-password -a $USER -s GITHUB_API_TOKEN -w)"

