#!/bin/bash

# run in the directory containing the tex and pdf files
# pass in the filename with no extension

file="$1"

tmux split-window -v -c '#{pane_current_path}' -p 30
tmux send-keys '~/dotfiles/bin/watch-latex.sh' Enter
zathura "$file.pdf" >/dev/null 2>&1 &
vim "$file.tex"
