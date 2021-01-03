## Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
        fpath=(/usr/local/share/zsh-completions $fpath)
fi

## always show current branch via RPROMPT
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

## aliases
alias g='git'
alias -g dev='development'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

function ipy() {
    cd ~/pj/ipython_env
    poetry run python -m IPython
    cd - > /dev/null
}

function jup() {
    cd ~/pj/ipython_env
    poetry run python -m jupyter notebook
    cd - > /dev/null
}