#!/bin/sh

# HTML-1 is the external monitor when connected to the HTML port
# DP-1 is the external monitor when connected to a display port through USB-C

export resolution=`xrandr | awk 'external == 1 && $0  ~ /[+]/ {print $1; exit } $2=="connected" { if ($1 == "DP-1" || $1 == "HDMI-1") external = 1} '`

# 3 column layout
if [ "$resolution" = "2560x1440" ]
then
	wmctrl -x -r Telegram       -e 0,1700,000,0861,700
	wmctrl -x -r Signal         -e 0,1700,790,0860,650
	wmctrl -x -r Firefox -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Firefox        -e 0,70,000,1245,1380
	wmctrl -x -r Firefox -b add,maximized_vert
	wmctrl -x -r Gnome-terminal -e 0,1290,000,0734,1370
	exit
fi

# 2 column layout
if [ "$resolution" = "1920x1080" -o "$resolution" = "1920x1200" ]
then
	wmctrl -x -r Telegram       -e 0,1094,000,0821,1000
	wmctrl -x -r Signal         -e 0,1094,000,0821,1020
	wmctrl -x -r Gnome-terminal -e 0,1068,000,0866,1025
	wmctrl -x -r Firefox -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Firefox        -e 0,0070,000,1024,1015
	wmctrl -x -r Firefox -b add,maximized_vert
	wmctrl -x -r Gnome-terminal -b add,maximized_vert
	exit
fi

if [ "$resolution" = "" ]
then
	echo "no external monitor."
else
	echo "no configuration for resolution $resolution"
fi

