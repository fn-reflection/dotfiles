#!/bin/bash

function force_update_sym_link() {
    SCRIPT_DIR=$(pwd)
    path=$1
    ln -sf $SCRIPT_DIR/$path ~/$path
}

cd $(dirname $0)
git submodule update --init --recursive #initlize external repository

##prezto
if [ ! -e ~/.zprezto ]; then
  force_update_sym_link .zprezto
fi
force_update_sym_link .zpreztorc
##zsh
force_update_sym_link .zlogin
force_update_sym_link .zlogout
force_update_sym_link .zprofile
force_update_sym_link .zshenv
force_update_sym_link .zshrc

force_update_sym_link .vimrc
force_update_sym_link .tmux.conf

if [ ! -e ~/.ipython/profile_default/startup ]; then
  force_update_sym_link .ipython/profile_default/startup
fi
if [ ! -e ~/.vim/colors ]; then
  force_update_sym_link .vim/colors
fi
if [ ! -e ~/.vim/vim-hybrid ]; then
  force_update_sym_link .vim/vim-hybrid
fi