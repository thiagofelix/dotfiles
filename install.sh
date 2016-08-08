#!/bin/bash

curr_dir=`pwd`

linking() {
  rm -r $2 2>/dev/null || true
  ln -s $1 $2
}

install.vim() {
  linking $curr_dir/vim/ $HOME/.vim
  linking $curr_dir/vim/vimrc $HOME/.vimrc
}

install.emacs() {
  [[ -d $HOME/.cask ]] || git clone https://github.com/cask/cask.git $HOME/.cask
  linking $curr_dir/emacs.d $HOME/.emacs.d
}

install.mutt() {
  linking $curr_dir/mutt $HOME/.mutt
  linking $curr_dir/muttrc $HOME/.muttrc
}

install.confs() {
  linking $curr_dir/gitignore_global $HOME/.gitignore_global
  linking $curr_dir/gitconfig $HOME/.gitconfig
}

install.zsh() {
  [[ -d $HOME/.oh-my-zsh ]] || git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  curl -fLo $HOME/.git_prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
  linking $curr_dir/zsh $HOME/.zsh
  linking $curr_dir/zsh/zshrc $HOME/.zshrc
}

install.bins() {
  mkdir -p $HOME/bin
  for b in $curr_dir/bin/*; do
    linking $b $HOME/bin/`basename $b`
  done
}

install.all() {
  install.bins
  install.emacs
  install.vim
  install.confs
  install.zsh
  install.mutt
}

options=("bins" "emacs" "vim" "confs" "zsh" "mutt" "all")
help() {
  echo "install.sh [option]"
  echo "[options] - one of the following:"
  for option in ${options[*]}; do
    echo " - $option"
  done
}

command=$1; shift
if [[ "${options[*]}" =~ "${command:-not-found}" ]]; then
 install.$command "$@"
else
 help
fi
