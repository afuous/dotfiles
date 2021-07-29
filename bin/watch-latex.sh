#!/bin/bash

# run in the directory containing the latex files

# can optionally add parameters for pdflatex options

# loop probably not necessary anymore
while true; do
	inotifywait -m -e close_write,moved_to,create . | \
	while read -r directory events filename; do
		if [[ "$events" == "CLOSE_WRITE,CLOSE" || "$events" == "CREATE" ]]; then
			if [[ "$filename" == *".tex" ]]; then
				pdflatex -interaction nonstopmode $* "$filename"
			fi
		fi
	done
done
