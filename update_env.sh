#!/bin/bash

function force_update_sym_link() {
    SCRIPT_DIR=$(pwd)
    path=$1
    ln -sf $SCRIPT_DIR/$path ~/$path
}

function update_sym_link() {
    SCRIPT_DIR=$(pwd)
    path=$1
    if [ ! -e ~/$path ]; then
      force_update_sym_link $path
    fi
}

cd $(dirname $0)
git submodule update --init --recursive #initlize external repository

##prezto
update_sym_link .zprezto
force_update_sym_link .zpreztorc

##zsh
force_update_sym_link .zlogin
force_update_sym_link .zlogout
force_update_sym_link .zprofile
force_update_sym_link .zshenv
force_update_sym_link .zshrc

#others
force_update_sym_link .vimrc
update_sym_link .vim/colors
force_update_sym_link .tmux.conf
update_sym_link .ipython/profile_default/startup
force_update_sym_link .jupyter/jupyter_notebook_config.py