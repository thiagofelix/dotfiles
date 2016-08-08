. /usr/local/opt/nvm/nvm.sh > /dev/null 2>&1

if test "$(which brew)"; then

  NVM_INSTALL=$(brew --prefix nvm)

  if [ -d "$NVM_INSTALL" ]; then
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_INSTALL/nvm.sh"
  fi
fi
