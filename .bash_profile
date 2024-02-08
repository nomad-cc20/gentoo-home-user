# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -le 3 ]]; then
	exec startx > /dev/null 2>&1
fi
