# Setup homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Put gnu utilities on the PATH
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
