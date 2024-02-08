#!/bin/bash

# Resolution
sh ~/Scripts/monitor_default.sh

# Wallpaper
feh --bg-scale Pictures/wllppr3.jpg

# Dwmblocks bar.
PATH="$PATH:/home/nomad/dwmblocks-async/statusbar" dwmblocks &

# Automatic session lock.
#xautolock -time 5 -locker slock &

