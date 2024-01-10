## CUSTOMIZE PROMPT
autoload -Uz vcs_info # use vcs_info
setopt prompt_subst # allow $ expansion in prompt
zstyle ':vcs_info:git:*' formats '%r %b'
precmd () { vcs_info } # call vcs_info every showing prompt
PS1='%F{red}%n%f %F{048}%/%f$ '
RPROMPT='%F{blue}${vcs_info_msg_0_}%f'

## AUTO COMPLETION
autoload -U compinit
compinit
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
bindkey ';3A' history-search-backward    # linux
bindkey '^[\e[A' history-search-backward # mac
bindkey ';3B' history-search-forward     # linux
bindkey '^[\e[B' history-search-forward  # mac
if [ -e "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -e "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -e "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -e "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [ -e "$HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
    source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
elif [ -e "/usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
    source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## ALIASES
alias g='git'
alias vi='nvim'
alias vim='nvim'

## PATHES
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

## LANGUAGE ENVS
if [ -e "$HOME/.nodenv" ]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    if command -v nodenv 1>/dev/null 2>&1; then
        eval "$(nodenv init -)"
    fi
fi

if [ -e "$HOME/.pyenv" ]; then
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
fi

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

## CUSTOM FUNCTIONS
function ipy() {
    env_dir=$1
    if [ -z "$env_dir" ]; then
        env_dir=~/pj/ipython_env
    fi
    cd $env_dir >/dev/null
    poetry run python -m IPython
    cd - >/dev/null
}

function jup() {
    env_dir=$1
    if [ -z "$env_dir" ]; then
        env_dir=~/pj/ipython_env
    fi
    cd $env_dir >/dev/null
    poetry run python -m jupyter notebook
    cd - >/dev/null
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/lb/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
