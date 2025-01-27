# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"

# Download zinit if it doesn't exist
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::asdf

# Load completions
autoload -U compinit && compinit

# run all the compdef's saved before
zinit cdreplay -q


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings (vi mode)
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
HISTDUP=erase
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# Functions

findandkill() {
  $(lsof -ti:3000 | xargs kill)
}

change_kitty_profile() {
  sh ~/dotfiles/.config/kitty/change-profile.sh
}

toggle_kitty_transparency() {
  sh ~/dotfiles/.config/kitty/toggle-transparency.sh
}


# Aliases

alias vim=nvim
alias python="/opt/homebrew/bin/python3"
alias pip="/opt/homebrew/bin/pip3"
alias kill_port=findandkill
alias ls='ls --color'


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insentive autocomplete
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # add colors to autocomplete
zstyle ':completion:*' menu no # disable default autocomplete menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Defaults
export TERM='xterm-256color'
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="/opt/homebrew/bin/nvim"
export VISUAL="/opt/homebrew/bin/nvim"
export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

# PATH environment
export PATH="$(brew --prefix postgresql@16)/bin:$PATH"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix mysql@8.0)/bin:$PATH"
export PATH="/usr/local/bin/:$PATH"
export PATH="$PNPM_HOME:$PATH"

# Term
export TERM=xterm-256color

