# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(brew git vi-mode z kubectl terraform)

source $ZSH/oh-my-zsh.sh

# Exports
export EDITOR='nvim'
export VISUAL='nvim'
export N_PREFIX="$HOME/.n"
export PATH="$PATH:$N_PREFIX/bin"
export PATH="/opt/homebrew/bin:$PATH:"
export PATH="/Volumes/Workspace/ehr/nedap/archetype-languageserver/build/image/archie-lsp-macos-arm64/bin:$PATH" 

# Keychain Secrets
export OPENAI_API_KEY=$(security find-generic-password -w -a $LOGNAME -s "OpenAI Token")
export NPM_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "GitHub Package Registry (read): PAT lpmachineuser")
export NPM_TOKEN_SUPERTAB_REGISTRY=$(security find-generic-password -w -a $LOGNAME -s "lpmachineuser package manager token")
export CIVO_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Civo Token")
export DO_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Digital Ocean Token")
export DIGITAL_OCEAN_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Digital Ocean Token")
export LOKALISE_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Lokalise Token")
export CIRCLECI_CLI_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "CircleCI Token")
export RESEND_API_KEY=$(security find-generic-password -w -a $LOGNAME -s "Resend Token")

export SDKMAN_DIR="$HOME/.sdkman"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

function light_mode() {
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
  kitty @ set-colors -a ~/.config/kitty/themes/Solarized_Light.conf
  defaults write -g AppleInterfaceStyle Light
}

function dark_mode() {
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
  kitty @ set-colors -a ~/.config/kitty/themes/nord.conf
  defaults write -g AppleInterfaceStyle Dark
}

function toggle_mode() {
  local mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

  if [[ $mode == "Dark" ]]; then
    echo "$mode -> Light"
    light_mode
  else
    echo "$mode -> Dark"
    dark_mode
  fi
}

vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim
}
