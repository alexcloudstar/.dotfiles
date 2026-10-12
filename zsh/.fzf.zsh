# Setup fzf
# ---------
# `brew --prefix fzf` answers from whichever brew comes first on PATH, which here
# is the arm64 one, while fzf is installed in the Intel prefix. It happily prints
# /opt/homebrew/opt/fzf for a formula that isn't there, so the sourced paths
# dangled. Ask the fzf binary we'd actually run to emit its own zsh integration
# (completion + key bindings) instead of guessing at a prefix.
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh 2>/dev/null)"
fi
