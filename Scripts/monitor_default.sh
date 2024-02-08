#!/bin/bash 

# Some useful shit.
prcmd="--primary"
mode11="--auto --above eDP-1"
mode12="--auto --right-of DP-1-1"

# Get lid state.
lid=$( cat /proc/acpi/button/lid/LID0/state | tr -s ' ' | cut -d ' ' -f 2 )

# Lid opened -> turn the primary display on.
if [[ $lid == "open" ]]; then
	mode="--mode 1920x1200 --primary"
# Lid closed -> turn the primary display off.
else
	mode="--off"
fi

primary=0
left="--output DP-1-1 --off"
right="--output DP-1-2 --off"

# Turn on each other output.
for monitor in $( DISPLAY=:0 sudo -u nomad xrandr | awk '/\<connected\>/ {print $1}' )
do
	# DP-1-1: docked, left.
	if [[ $monitor -eq "DP-1-1" ]]; then
		left="--output $monitor $mode11"
	# DP-1-2: docked, right.
	elif [[ $monitor -eq "DP-1-2" ]]; then
		right="--output $monitor $mode12 --primary"
		primary=1
	# Anything else.
	elif [[ $monitor -ne "eDP-1" ]]; then
		"DISPLAY=:0 sudo -u nomad xrandr --output $monitor $mode11"
	fi
done

# Is right connected?
if ! [ -z ${right+x} ]; then
	$mode="$mode --primary"
fi

# Set default as well.
DISPLAY=:0 sudo -u nomad xrandr --output eDP-1 $mode
DISPLAY=:0 sudo -u nomad xrandr $left
DISPLAY=:0 sudo -u nomad xrandr $right
