#!/bin/bash

if [[ -f ~/.currentmusicspotify ]]; then
	query="$(spotify-now -i '%title %artist')"
elif [[ -f ~/.currentmusicmoc ]]; then
	query="$(mocp -i | grep '^File:' | sed -e 's/^.*\/\([^\/]\+\)\.mp3$/\1/g')"
fi

query="$(echo "$query" | sed -e 's/ /+/g' | sed -e 's/Remastered\(+Version\)\?//g')"

url="http://search.azlyrics.com/search.php?q=$query"

curl -s -H 'User-Agent:' "$url" \
	| grep '<a href=' \
	| head -1 \
	| sed -e 's/^.*href="\([^"]\+\)".*$/\1/'
