#!/bin/bash

hashrecursivehelper() {
	root="$1"
	path="$2"
	hashcmd="$3"
	nameonly="$4"
	echo "$path"
	if [[ -f "$root$path" ]]; then
		echo 'file'
		if [[ ! "$nameonly" ]]; then
			cat "$root$path" | $hashcmd
		fi
	elif [[ -d "$root$path" ]]; then
		echo 'directory'
		combined=''
		IFS=$'\n'
		for file in $(ls -a "$root$path" | grep -v '\(^\.$\)\|\(^\.\.$\)'); do
			combined="${combined}$(hashrecursivehelper "$root" "$path/$file" "$hashcmd" "$nameonly")"
		done
		echo "$combined" | $hashcmd
	elif [[ -L "$file" ]]; then
		echo 'symlink'
		readlink "$root$path"
	fi
}

usage() {
	>&2 echo 'Usage: hashrecursive [--nameonly] PATH'
	exit 1
}
nameonly=''
file=''
if [[ "$#" == 0 ]]; then
	usage
elif [[ "$#" == 1 ]]; then
	file="$1"
elif [[ "$1" == '--nameonly' ]]; then
	nameonly='yes'
	file="$2"
else
	usage
fi
if [[ ! -e "$file" ]]; then
	>&2 echo "$file not found"
	exit 1
fi

hashrecursivehelper "$file" '' sha1sum "$nameonly" | sha1sum
