#!/bin/bash

function current_os() {
  local os='Unknown'
  if [ "$(uname)" == 'Darwin' ]; then
    os='Mac'
  elif [ "$(uname -s | cut -b 1-5)" == 'Linux' ]; then
    os='Linux'
  elif [ "$(uname -s | cut -b 1-10)" == 'MINGW32_NT' ]; then
    os='Cygwin'
  fi
  echo "$os"
}

function setting_json_dir() {
  local os=$1
  local dir_name=''
  if [ "$os" == 'Mac' ]; then
    dir_name="$HOME/Library/Application Support/Code/User"
  elif [ "$os" == 'Linux' ]; then
    dir_name="$HOME/.config/Code/User"
  else
    dir_name="C:\Users\(ユーザー名)\AppData\Roaming\Code\User" # useless
  fi
  echo "$dir_name"
}

cd "$(dirname "$0")" || return

for path in settings.json keybindings.json snippets
do
  ln -sf "$(pwd)"/.vscode/"$path" "$(setting_json_dir $(current_os))"/"$path"
done
