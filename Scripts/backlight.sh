#!/bin/sh

backlight_sys_dir="/sys/class/backlight/intel_backlight"

min_brightness=40
read -r max_brightness < "${backlight_sys_dir}/max_brightness"
read -r curr_brightness < "${backlight_sys_dir}/brightness"

case "$1" in
	up) increment="+ 40" ;;
	down) increment="- 40" ;;
	*) exit 1 ;;
esac

new_brightness=$(($curr_brightness $increment))

if ((new_brightness < min_brightness)); then
	if ((curr_brightness == min_brightness)); then
		exit 1
	else
		new_brightness=1
	fi
fi

if ((new_brightness > max_brightness)); then
	if ((curr_brightness == max_brightness)); then
		exit 1
	else
		new_brightness=$max_brightness;
	fi
fi

echo "$new_brightness" > ${backlight_sys_dir}/brightness
exit 0

