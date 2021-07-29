#!/bin/bash

# run in the directory containing the tex and pdf files
# pass in the filename with no extension

file="$1"

# servername="$file-$(date +%s)"
servername="$file"

tmux split-window -v -c '#{pane_current_path}' -p 25
tmux send-keys '~/dotfiles/bin/synctex-watch-latex.sh' Enter
tmux select-pane -U
zathura -x "vim --servername $servername --remote-send 'let g:syncpdf=\"$file\"<cr>' --remote +%{line} %{input}" "$file.pdf" >/dev/null 2>&1 &
vim --servername "$servername" "$file.tex"
