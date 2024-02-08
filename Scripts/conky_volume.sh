#!/bin/sh

#pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'

vol=$(amixer get Master -M | grep -oE -m1 "[[:digit:]]*%")
status=$(amixer get Master | grep "Front Left:" | cut -d " " -f 8)
if [ $status == "[off]" ]
then
vol="$vol M"
fi
echo $vol
