#!/bin/bash

# http://manpages.ubuntu.com/manpages/precise/man1/zathura.1.html
# search for "bookmark"
# ~/.local/share/zathura/bookmarks
# blist, bmark, bdelete
# WARNING: the linked manpage is wrong, it is bdelete not delbmark

# TODO: send keys to window instead of typing directly
# holding down control for too long causes issues (OPENS INFINITE ZATHURAS DO NOT DO THIS)

temp=gjafsdnksahfasf

pause() {
	sleep 0.2
}

cmd() {
	xdotool key colon
	pause
	xdotool type "$1"
	xdotool key Return
	xdotool key Escape
}

echo hello
pause
cmd "bmark $temp"
pause
zathura "$1" &
pause
cmd "blist $temp"
pause
cmd "bdelete $temp"
