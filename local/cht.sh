#!/usr/bin/env bash

languages=$(echo "golang c cpp typescript javascript rust" | tr " " "\n")
core_utils=$(echo "find xargs sed awk git-worktree grep" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)
[[ -z $selected ]] && exit 0

read -r -p "GIMME YOUR QUERY: " query
encoded_query=$(echo "$query" | tr " " "+")

if echo "$languages" | grep -qsx "$selected"; then
    tmux neww -n "$selected - $query" bash -c "curl -s 'cht.sh/$selected/$encoded_query' | less"
else
    tmux neww -n "$selected - $query" bash -c "curl -s 'cht.sh/$selected~$encoded_query' | less"
fi
