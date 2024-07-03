# Setup homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Put gnu utilities on the PATH
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
