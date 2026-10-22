export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME=$HOME/.config

[[ -z $HOMEBREW_PREFIX && -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

bindkey -s ^f "tmux-sessionizer\n"
function clear-screen-widget() {
  clear
}
zle -N clear-screen-widget
bindkey '^K' clear-screen-widget

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

fpath=($HOME/.docker/completions $fpath)

source $ZSH/oh-my-zsh.sh

export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
nvm_default_node_dirs=("$NVM_DIR"/versions/node/*(N/nOn[1]))
[[ -n $nvm_default_node_dirs ]] && export PATH="$nvm_default_node_dirs[1]/bin:$PATH"
unset nvm_default_node_dirs
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.local/bin:$PATH"

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

alias ls="eza --icons=always"

alias vim="nvim"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/ffmpeg-full/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"

export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

export PATH="$HOME/.opencode/bin:$PATH"
