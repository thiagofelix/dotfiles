# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="apple"
plugins=(brew git vi-mode z kubectl terraform poetry)

source $ZSH/oh-my-zsh.sh

# Exports
export EDITOR='nvim'
export VISUAL='nvim'
export N_PREFIX="$HOME/.n"
export PATH="$PATH:$N_PREFIX/bin"
export PATH="/opt/homebrew/bin:$PATH:"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="./.fnm:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Keychain Secrets
export ANTHROPIC_API_KEY=$(security find-generic-password -w -a $LOGNAME -s "ANTHROPIC_API_KEY")
export OPENAI_API_KEY=$(security find-generic-password -w -a $LOGNAME -s "OpenAI Token")
export VERCEL_API_KEY=$(security find-generic-password -w -a $LOGNAME -s "Vercel Token")
export NPM_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Supertab NPM_TOKEN")
# export NPM_TOKEN_SUPERTAB_REGISTRY=$(security find-generic-password -w -a $LOGNAME -s "lpmachineuser package manager token")
# export CIVO_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Civo Token")
# export DO_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Digital Ocean Token")
# export DIGITAL_OCEAN_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Digital Ocean Token")
# export LOKALISE_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "Lokalise Token")
# export CIRCLECI_CLI_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "CircleCI Token")
# export RESEND_API_KEY=$(security find-generic-password -w -a $LOGNAME -s "Resend Token")

# fnm
eval "$(fnm env --use-on-cd)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
