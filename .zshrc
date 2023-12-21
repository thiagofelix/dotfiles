# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# Homebrew 
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable Vi mode
bindkey -v

# Exports
export EDITOR='nvim'
export VISUAL='nvim'
export N_PREFIX="$HOME/.n"
export PATH="$PATH:$N_PREFIX/bin"

# Aliases
alias g='git'
alias k='kubectl'

# Keychain Secrets
# Supertab lpmachineuser NPM_TOKEN
export NPM_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "GitHub Package Registry (read): PAT lpmachineuser")

