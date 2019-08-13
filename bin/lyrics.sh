#!/bin/bash

# first, figure out which player is playing
for p in $(playerctl -l); do
	if [ "$(playerctl status -p $p)" == 'Playing' ]; then
		player=$p
		break
	fi
done
if [ ! $player ]; then
	exit 1
fi

# remove .mp3 from the end of the title
# remove "remastered version" nonsense
title="$(playerctl metadata title -p $player | sed \
	-e 's/\(.*\)\.mp3/\1/' \
	-e 's/Remastered\(+Version\)\?//' \
)"
artist="$(playerctl metadata artist -p $player)"

query="$(echo "$title $artist" | sed -e 's/ /+/g')"

url="https://search.azlyrics.com/search.php?q=$query"

curl -s -H 'User-Agent:' "$url" \
	| grep '<a href=' \
	| head -1 \
	| sed -e 's/^.*href="\([^"]\+\)".*$/\1/'
