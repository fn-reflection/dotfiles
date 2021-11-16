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

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

function ipy() {
    env_dir=$1
    if [ -z "$env_dir" ]; then
      env_dir=~/pj/ipython_env
    fi
    cd $env_dir > /dev/null
    poetry run python -m IPython
    cd - > /dev/null
}

function jup() {
    env_dir=$1
    if [ -z "$env_dir" ]; then
      env_dir=~/pj/ipython_env
    fi
    cd $env_dir > /dev/null
    poetry run python -m jupyter notebook
    cd - > /dev/null
}

if [ -e "$HOME/.nodenv" ]
then
    export PATH="$HOME/.nodenv/bin:$PATH"
    if command -v nodenv 1>/dev/null 2>&1
    then
        eval "$(nodenv init -)"
    fi
fi

if [ -e "$HOME/.pyenv" ]
then
    if command -v pyenv 1>/dev/null 2>&1
    then
        eval "$(pyenv init -)"
    fi
fi


if command -v rbenv 1>/dev/null 2>&1
then
      eval "$(rbenv init -)"
fi