# Homebrew 
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable Vi mode
bindkey -v

# Exports
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias g='git'
alias k='kubectl'

# History file configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Keychain Secrets
# Supertab lpmachineuser NPM_TOKEN
export NPM_TOKEN=$(security find-generic-password -w -a $LOGNAME -s "GitHub Package Registry (read): PAT lpmachineuser")

