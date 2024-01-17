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
export CIVO_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Civo Token")
export GITHUB_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Github Token")
export DO_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Digital Ocean Token")
export DIGITAL_OCEAN_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Digital Ocean Token")
export EOMF="/Volumes/Workspace/ehr/EOMF"
export EIFFEL_HUB="/Volumes/Workspace/ehr/EiffelHub"
export SDKMAN_DIR="$HOME/.sdkman"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

function light_mode() {
  kitty @ set-colors -a ~/.config/kitty/themes/Solarized_Light.conf
  defaults write -g AppleInterfaceStyle Light
}

function dark_mode() {
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

local mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

if [[ $mode == "Dark" ]]; then
  dark_mode
else
  light_mode
fi


