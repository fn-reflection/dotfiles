#!bin/zsh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

setopt EXTENDED_GLOB
for rcfile in $SCRIPT_DIR/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "$SCRIPT_DIR/.${rcfile:t}"
done