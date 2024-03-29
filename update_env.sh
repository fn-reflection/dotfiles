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

# git
force_update_sym_link .gitconfig

# nvim
force_update_sym_link .config/nvim/init.lua

# python
update_sym_link .ipython/profile_default/startup
update_sym_link .vim/colors
force_update_sym_link .jupyter/jupyter_notebook_config.py
force_update_sym_link .config/pep8
force_update_sym_link .config/pylintrc

# textlint
force_update_sym_link .textlintrc

# tmux
force_update_sym_link .tmux.conf

# ruby
force_update_sym_link .pryrc

# vim
force_update_sym_link .vimrc
update_sym_link .vim/colors

# wezterm
force_update_sym_link .wezterm.lua

# zsh
force_update_sym_link .zprofile
force_update_sym_link .zshrc
