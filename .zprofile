# Homebrew 
eval "$(/opt/homebrew/bin/brew shellenv)"

# Set up the prompt
PROMPT='%n@%m %1~ %# '

# Aliases
alias g='git'
alias k='kubectl'

# Set Zsh options
setopt EXTENDED_GLOB

# History file configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Enable autocompletion
autoload -Uz compinit
compinit

# Correct minor spelling errors in commands
setopt CORRECT

# Custom PATH (if needed)
# export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# Source any additional scripts
# source ~/path/to/other/script.zsh
