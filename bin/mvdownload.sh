#!/bin/sh

# move latest download to $1

downloads=~/Downloads

if ! [ "$(ls "$downloads")" ]; then
	>&2 echo "Downloads is empty"
	exit 1
fi

if [ $# -eq 0 ]; then
	>&2 echo "Needs argument for destination"
	exit 1
fi

output="$1"

line=$(ls $downloads | while read file; do
	echo "$( \
		stat "$downloads/$file" \
		| grep Modify \
		| sed 's/^\S*\s\(\S\+\)\s\(\S\+\).*$/\1 \2/g' \
		| tr ':.-' '  ' \
	) |$file"
done | sort -nr | head -1)
mv "$downloads/${line#*|}" "$output"
