#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some macOS tools.
brew install vim
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
# brew install homebrew/php/php56 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install ripgrep
brew install fd
brew install graphviz
brew install plantuml
brew install ack
brew install dark-mode
brew install git
brew install git-lfs
brew install imagemagick
brew install rename
brew install ssh-copy-id
brew install tree
brew install the_silver_searcher
brew install jenv
brew install nvm
brew install tmux
brew install fasd
brew install gh
brew install jq
brew install google-cloud-sdk
brew install ngrok
brew install rbenv
brew install ruby-build
brew install postgresql@13
brew install awscli

# Install cask applications
brew install --cask bettertouchtool
brew install --cask slack
brew install --cask transmission
brew install --cask spectacle
brew install --cask iterm2
brew install --cask colorsnapper


# Remove outdated versions from the cellar.
brew cleanup
