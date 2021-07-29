#!/bin/bash

# argument is the amount to increase volume by, can be negative
amount="$1"

if [[ "$amount" == -* ]]; then
	pactl set-sink-volume @DEFAULT_SINK@ "+$amount%"
	killall -USR1 i3status
	exit
fi

headphonesin="$(pactl list sinks | grep 'Headphones' | grep -v 'not available')"
bluetooth="$(pactl info | grep 'Default Sink' | grep 'bluez')"

if [[ "$bluetooth" ]]; then
	# maxvolume=150
	# maxvolume=200
	maxvolume=300
elif [[ "$headphonesin" ]]; then
	# maxvolume=90
	maxvolume=200
else
	maxvolume=300
fi

isbelowmaxvolume="$(echo "$(pamixer --get-volume)<$maxvolume" | bc | grep 1)"

if [[ "$isbelowmaxvolume" ]]; then
	pactl set-sink-volume @DEFAULT_SINK@ "+$amount%"
	killall -USR1 i3status
fi
