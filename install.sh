#!/usr/bin/env bash

PROJECT_ROOT="$(dirname $(readlink -f "$0"))"

# install configuration files

cp -rT "$PROJECT_ROOT/terminfo" ~/.terminfo
cp "$PROJECT_ROOT/vimrc" ~/.vimrc
cat "$PROJECT_ROOT/Xdefaults" >> ~/.Xdefaults
cp "$PROJECT_ROOT/bashrc" ~/.bashrc

# install vim vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install vundle plugins
vim +PluginInstall +qall
