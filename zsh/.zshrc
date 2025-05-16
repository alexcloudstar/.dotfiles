# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Q pre block. Keep at the top of this file.
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME=$HOME/.config


# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"
function clear-screen-widget() {
  clear
}
zle -N clear-screen-widget
bindkey '^K' clear-screen-widget # For Ctrl+K
bindkey '^k' clear-screen-widget # For Ctrl+k


ZSH_THEME="robbyrussell"


plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(/usr/local/bin/brew shellenv)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias python=/usr/bin/python3

# bun completions
[ -s "/Users/stefanalexandruromila/.bun/_bun" ] && source "/Users/stefanalexandruromila/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.local/bin:$PATH"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

alias vim="nvim"

export PATH="/usr/local/opt/postgresql@16/bin:$PATH"

export PATH="/usr/local/opt/llvm/bin:$PATH"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/stefanalexandruromila/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# pnpm
export PNPM_HOME="/Users/stefanalexandruromila/Library/pnpm:/usr/local/opt/llvm/bin:/usr/local/opt/postgresql@16/bin:/Users/stefanalexandruromila/.local/bin:/Users/stefanalexandruromila/.bun/bin:/Users/stefanalexandruromila/.yarn/bin:/Users/stefanalexandruromila/.config/yarn/global/node_modules/.bin:/usr/local/bin:/usr/local/sbin:/Users/stefanalexandruromila/.nvm/versions/node/v22.5.1/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/usr/local/go/bin:/Users/stefanalexandruromila/.cargo/bin:/Applications/Ghostty.app/Contents/MacOS:/usr/local/opt/fzf/bin"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
