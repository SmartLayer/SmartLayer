#!/bin/sh
# manage media files
function re-encapsulate { ffmpeg -i "$1" -c:v copy -c:a copy "$2"; }

# manage library
alias wordbank='vi ~/wordbank/p; strfile ~/wordbank/p'
function biblioteca { cd ~/Dropbox/wordbank/library; grep -i "[^a-z]$1" *; }

alias xerces='java -classpath /usr/share/java/xercesImpl.jar:/usr/share/java/xmlParserAPIs.jar:/usr/share/java/xercesSamples.jar sax.Counter'
# vi which can format email text and comments
alias vim-text='vim "+set tw=76" "+set fo+=wtcma"'

# shortcuts for mc
#alias musicman='mc -d /mnt/laputa/Music/cache/ ~/Music/'
#alias fetchman='mc -d /misc/laputa/Downloads/incoming/ /misc/laputa'
#alias mp4mc='mc -d /media/tristan/8CA5-5A3B/ /media/tristan/D934-B74D/'
#alias mtpmc='mc -d /run/user/1005/gvfs/*/*'
#alias musicsync="rsync --exclude 'Fallout: New Vegas OST.mp3' --exclude iTunes --delete -rv pocahontas:'/var/run/media/yuliansu/Windows/Users/Yu\ Liansu/Music/' Music/"


# shortcut to control xrandr to rotate vertically, useful for having 2 monitors
#alias 1280='xrandr --output DFP4 --mode 1280x768xrandr --output DFP4 --mode 1280x768'
#alias XRANDR="xrandr --output LVDS --off; xrandr --output DFP1 --mode 1920x1080"
#alias rot='  xinput set-prop 9 --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1 ; xrandr -o left'
#alias unrot='xinput set-prop 9 --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1 ; xrandr -o normal'

# shortcut to control router
#alias router_reboot='wget -O - --user=guest --password=guest 192.168.1.1/reboot.cgi'

# backup
#alias backup="rsync -rav --exclude-from=.exclude.lst ~/ eoa.cn:/var/local/backups/private/zhangweiwu"
# alias ffmpeg='ffmpeg -fflags +genpts'

# quick setup of ANT
# iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o pppoe-PPPoE -j SNAT --to 118.181.168.217
# ifconfig eth0.2 down; ifconfig eth0.2 hw ether 00:1C:25:16:BE:3E ; ifconfig eth0.2 up

# control ARM based asus laptop
# sudo chmod 666 /sys/devices/platform/asus_laptop/ls_switch 
# sudo echo 0 > /sys/devices/platform/asus_laptop/ls_switch 

