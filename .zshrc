# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(brew git vi-mode z kubectl terraform)

source $ZSH/oh-my-zsh.sh

# Keychain Secrets
# Supertab lpmachineuser NPM_TOKEN
export NPM_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "GitHub Package Registry (read): PAT lpmachineuser")

# NeoVim Configs
alias v='nvchad' # default Neovim config
alias nvchad='NVIM_APPNAME=nvim-nvchad nvim' # NvChad

vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim
}

# Exports
export EDITOR='nvchad'
export VISUAL='nvchad'
export N_PREFIX="$HOME/.n"
export PATH="$PATH:$N_PREFIX/bin"
