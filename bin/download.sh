#!/bin/bash

# apparently this is covered by wget -c, should look more into it
# also curl -C

if [ $# -eq 0 ] || [ $# -gt 2 ]; then
	>&2 echo "Usage: $0 url [file]"
	exit 1
fi

url="$1"
file="$2"

if [ -z "$file" ]; then
	file="$(basename "$url")"
fi

touch "$file"
size="$(cat "$file" | wc -c)"

curl "$url" -H "Range: bytes=$size-" >> "$file"
