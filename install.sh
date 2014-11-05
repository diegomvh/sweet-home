#!/bin/bash

NOW=$(date +%s)

run () {
  echo $@
  $@
}

install () {
  SRC="$PWD/$1"
  DEST="$HOME/$1"
  if [ -h "$DEST" ]; then      # if $DEST is a symlink, we can probably delete it.
    run rm "$DEST"
  elif [ -e "$DEST" ]; then
    run mv "$DEST" "$DEST.orig-$NOW"
  fi
  run ln -s "$SRC" "$DEST"
}

shopt -s dotglob extglob

# Oh My Zsh
if [ -h "$HOME/.oh-my-zsh" ]; then
    run rm "$HOME/.oh-my-zsh"
fi
ln -s "$PWD/oh-my-zsh" "$HOME/.oh-my-zsh"

# Fisa Vim
if [ -h "$HOME/.vimrc" ]; then
    run rm "$HOME/.vimrc"
fi
ln -s "$PWD/fisa-vim-config/.vimrc" "$HOME/.vimrc"

# Yesmeck Tmux
if [ -h "$HOME/.tmux" ]; then
    run rm "$HOME/.tmux"
fi
ln -s "$PWD/tmuxrc" "$HOME/.tmux"
if [ -h "$HOME/.tmux.conf" ]; then
    run rm "$HOME/.tmux.conf"
fi
ln -s "$HOME/.tmux/tmux.conf" "$HOME/.tmux.conf"

for F in !(.|..|README.md|install.sh|.git|.gitmodules|.gitignore|fisa-vim-config|oh-my-zsh|tmuxrc); do
  install ${F}
done
