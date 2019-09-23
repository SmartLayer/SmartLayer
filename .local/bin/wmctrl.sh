#!/bin/sh

export resolution=`xrandr | awk 'external == 1 && $0  ~ /[+]/ {print $1; } /HDMI-1/ { external = 1}'`

if [ "$resolution" = "" ]
then
	# user is on built-in monitor (travelling with laptop). tell timezone
	date
fi

if [ "$resolution" = "2560x1440" ]
then
	wmctrl -x -r Navigator      -e 0,70,000,1200,1380
	wmctrl -x -r Gnome-terminal -e 0,1267,000,0734,1370
	wmctrl -x -r Telegram       -e 0,1700,000,0861,700
	wmctrl -x -r Signal         -e 0,1700,790,0860,650
fi

if [ "$resolution" = "1920x1080" ]
then
	wmctrl -x -r Firefox        -e 0,70,000,1024,1015
	wmctrl -x -r Telegram       -e 0,1094,000,0821,1100
	wmctrl -x -r Signal         -e 0,1094,000,0821,1100
	wmctrl -x -r Gnome-terminal -e 0,1068,000,0866,1100
fi
