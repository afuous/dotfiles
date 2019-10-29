#!/bin/bash

# automatically renumber tmux sessions in the same way as windows

# ignores sessions with non-numerical names

num=0

tmux list-sessions \
	| grep '^[0-9]\+:' \
	| sed -e 's/\([0-9]\+\):.*/\1/' \
	| sort -n \
	| while read sess; do
	tmux rename-session -t "$sess" "$num"
	((num++))
done
