#!/bin/sh

scrot 'Pictures/Screenshots/%F_%T.png' -s -e 'xclip -selection clipboard -target image/png -in $f'

