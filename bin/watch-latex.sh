#!/bin/bash

# run in the directory containing the latex files

while true; do
	inotifywait -e close_write,moved_to,create . | \
	while read -r directory events filename; do
		if [[ "$events" == "CLOSE_WRITE,CLOSE" || "$events" == "CREATE" ]]; then
			if [[ "$filename" == *".tex" ]]; then
				pdflatex "$filename"
			fi
		fi
	done
done
