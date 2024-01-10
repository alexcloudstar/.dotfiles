#!/usr/bin/env bash

languages=$(echo "golang c cpp typescript javascript rust" | tr " " "\n")
core_utils=$(echo "find xargs sed awk git-worktree grep" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "GIMME YOUR QUERY: " query

if echo "$languages" | grep -qs $selected; then
    tmux neww -n "$(echo $selected - $query)" bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
else
    tmux neww -n "$(echo $selected - $query)" bash -c "curl cht.sh/$selected~$query | less"
fi
