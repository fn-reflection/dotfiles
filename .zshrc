## USE STARSHIP
eval "$(starship init zsh)"

## AUTO COMPLETION
autoload -U compinit; compinit;
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
if [ -e "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ];then
    source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -e "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ];then
    source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## ALIASES
alias g='git'

## PATHES
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

## LANGUAGE ENVS
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

## CUSTOM FUNCTIONS
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