#!/bin/bash

query="$(spotify-now -i '%title %artist' | sed -e 's/ /+/')"

url="http://search.azlyrics.com/search.php?q=$query"

curl -s -H 'User-Agent:' "$url" \
	| grep '<a href=' \
	| head -1 \
	| sed -e 's/^.*href="\([^"]\+\)".*$/\1/'
