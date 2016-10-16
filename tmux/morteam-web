#!/bin/sh

if tmux has-session -t morteam 2>/dev/null; then
	read -r -p "Already exists. Kill? [y/N] " response
	case $response in
		[yY][eE][sS]|[yY])
			tmux kill-session -t morteam
			;;
		*)
			exit 1
			;;
	esac
fi

tmux start-server
tmux new-session -d -s morteam
tmux split-window -v -p 30
tmux split-window -h -p 66
tmux split-window -h -p 50
tmux send-keys -t morteam:0.0 'cd ~/morteam-web' Enter vim Enter :NERDTreeTabsToggle Enter /src Enter o
tmux send-keys -t morteam:0.1 'cd ~/morteam-web; clear' Enter clear Enter
tmux send-keys -t morteam:0.2 'cd ~/mornetwork; clear' Enter 'npm start' Enter
tmux send-keys -t morteam:0.3 'cd ~/morteam-web; clear' Enter 'npm run watch' Enter
tmux select-pane -t 0
