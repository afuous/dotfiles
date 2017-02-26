#!/bin/sh

# only one of these necessary
pgrep check-music.sh | grep -v "^${$}$" | xargs kill

rm ~/.currentmusicmoc
rm ~/.currentmusicspotify

while true; do
	if mocp -i | grep '^State: PLAY$'; then
		touch ~/.currentmusicmoc
		rm ~/.currentmusicspotify
	elif [[ -z $(spotify-now -p a) ]]; then
		rm ~/.currentmusicmoc
		touch ~/.currentmusicspotify
	fi
	sleep 5
done
