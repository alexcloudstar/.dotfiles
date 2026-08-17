# Setup fzf
# ---------
FZF_PREFIX="$(brew --prefix fzf 2>/dev/null)"

if [[ -n "$FZF_PREFIX" ]] && [[ ! "$PATH" == *"${FZF_PREFIX}/bin"* ]]; then
  PATH="${PATH:+${PATH}:}${FZF_PREFIX}/bin"
fi

# Auto-completion
# ---------------
[[ -n "$FZF_PREFIX" ]] && source "${FZF_PREFIX}/shell/completion.zsh"

# Key bindings
# ------------
[[ -n "$FZF_PREFIX" ]] && source "${FZF_PREFIX}/shell/key-bindings.zsh"

unset FZF_PREFIX
