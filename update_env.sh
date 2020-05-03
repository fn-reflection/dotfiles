#!/bin/bash

function force_update_sym_link() {
    SCRIPT_DIR=$(pwd)
    path=$1
    ln -sf $SCRIPT_DIR/$path ~/$path
}

cd $(dirname $0)
git submodule update --init --recursive #initlize external repository

##prezto
#force_update_sym_link .zprezto
force_update_sym_link .zpreztorc
##zsh
force_update_sym_link .zprofile
force_update_sym_link .zshrc

force_update_sym_link .vimrc
force_update_sym_link .tmux.conf