#!/bin/bash

# HTML-1 is the external monitor when connected to the HTML port
# DP-1 is the external monitor when connected to a display port through USB-C

#export resolution=`xrandr | awk 'external == 1 && $0  ~ /[+]/ {print $1; exit } $2=="connected" { if ($1 ~ "^DP-" || $1 ~ "^HDMI-" || $1 ~ "Virtual1") external = 1} '`
export `xdpyinfo | grep dimension | awk  '{print $1 $2;}' | tr : =`

wmctrl -x -r Signal -b remove,maximized_vert,maximized_horz

# 3 column layout
if [[ ${dimensions} = 2560* ]]
then
	wmctrl -x -r Discord -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Discord        -e 0,0,0,800,800

	wmctrl -x -r Signal         -e 0,1700,000,0861,700
	wmctrl -x -r Discord        -e 0,0,000,0861,1700
	wmctrl -x -r Firefox -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Firefox        -e 0,780,0,1281,1000
	wmctrl -x -r jetbrains-idea -b remove,maximized_vert,maximized_horz
	wmctrl -x -r jetbrains-idea        -e 0,600,0,1440,1440
	wmctrl -x -r Gnome-terminal -e 0,800,800,1256,800
	exit;
fi

# a "centralised" layout, where the windows most focused on stay in the centre
if [[ ${dimensions} = 3840* ]]
then
	wmctrl -x -r Discord -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Discord        -e 0,2600,000,1280,1280
	wmctrl -x -r Telegram -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Telegram       -e 0,0,000,0890,2000
	wmctrl -x -r Signal         -e 0,2600,1380,1280,800
	wmctrl -x -r Firefox -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Firefox        -e 0,900,1250,2096,1374
	wmctrl -x -r Code -b remove,maximized_vert,maximized_horz
	wmctrl -x -r Code           -e 0,1000,0,2000,1374
	# so that the height can still be mouse-adjusted
	#wmctrl -x -r Firefox -b add,maximized_vert

	# this would allow Gnome-terminal to be of 80 columns
	#wmctrl -x -r Gnome-terminal -e 0,618,000,0790,1370
	wmctrl -x -r Gnome-terminal -e 0,1280,0,1256,820
	exit;
fi


if [ "$dimensions" = "" ]
then
	echo "no external monitor."
else
	echo "no configuration for resolution $dimensions"
fi

