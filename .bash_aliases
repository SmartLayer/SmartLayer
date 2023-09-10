#!/bin/sh

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

# manage media files
function re-encapsulate { ffmpeg -i "$1" -c:v copy -c:a copy "$2"; }
function video-contact-sheet { ffmpeg -i "$1"  -vf 'select=not(mod(n\,300)),tile=3x3'  "$2"; }
# ffmpeg -i /tmp/record_2020-06-30-15-56-34.mp4 -vf scale=360:720 -r 15 record.gif
function ffmpeg2gif {
	if [[ $2 == *.gif ]]
	then
		# https://tyhopp.com/notes/ffmpeg-crosshatch
		ffmpeg -i "$1" -vf palettegen /tmp/palette.png && \
		ffmpeg -i "$1" -i /tmp/palette.png -filter_complex "fps=15, scale=480:-1, paletteuse=dither=none" "$2"
		rm /tmp/palette.png
	else
		echo "need 2 parameters, the last must be something.gif"
	fi
}
function last_capture_to_gif {
	pushd '/run/user/1000/gvfs/mtp:host=SAMSUNG_SAMSUNG_Android_R3CR90CYSDV/Memoria interna/DCIM/Screen Recordings'
	ffmpeg2gif `ls | tail -n 1` /tmp/`ls | tail -n 1`.gif
	popd
}
function insane-dedup {
	du -ab "$1" | sort -n | awk -F $'\t' '{printf("%16s\t%s\n", $1, $2)}' | uniq -w 16 -D
}
function vcs-ffmpeg {
	ffmpeg -i "$1" -f image2 -vf 'scale=320:-1,drawtext=fontfile=/usr/share/fonts/truetype/ubuntu/Ubuntu-R.ttf: text=%{pts:hms}: x=(w-tw)/2: y=h-(2*lh): fontcolor=white: box=1: boxcolor=0x00000000@1, select=not(mod(n\,$((frames/9+1)))),tile=3x3' "$2"
}

function cclockwise-ffmpeg {
	ffmpeg -i "$1" -c copy -metadata:s:v:0 rotate=90 "$2"
}
function  clockwise-ffmpeg {
	ffmpeg -i "$1" -c copy -metadata:s:v:0 rotate=-90 "$2"
}
function context_grep {
	grep -o "[a-zA-Z, .;]*$1[a-zA-Z, .;]*" $2
}

# if the Logitech Master 2S Mouse fail to connect, restore connection with this
# alias masterup="echo connect DA:8E:70:A2:34:F1 | bluetoothctl"

# encode video files to HEVC (h265). Note that not all videos can be encoded
# this way to mp4, better use .mkv format first argument is the source; second
# the target.

# It's not possible to do this in parallel fashion with xargs -P -i, because
# the x265_2pass.log file name is fixed in ffmpeg. To convert all mp4 files
# in a folder one-by-one, use this:
# $ for i in *.mp4; do ffmpeg2h265 "$i" `basename "$i" .mp4`.mkv; done
function ffmpeg2hevc4k {
        ffmpeg -y -i "$1" -c:v libx265 -b:v 2600k -x265-params pass=1 -an -f null /dev/null
        ffmpeg    -i "$1" -c:v libx265 -b:v 2600k -x265-params pass=2 -c:a copy  "$2"
	# ffmpeg -y -i "$1" -c:v libx265 -b:v 2600k -x265-params pass=2 -c:a aac -b:a 128k "$2"
	rm x265_2pass.log x265_2pass.log.cutree
}
function ffmpeg2hevc1080p {
        ffmpeg -y -i "$1" -c:v libx265 -b:v 1200k -x265-params pass=1 -an -f null /dev/null
        ffmpeg    -i "$1" -c:v libx265 -b:v 1200k -x265-params pass=2 -c:a copy  "$2"
	rm x265_2pass.log x265_2pass.log.cutree
}
function ffmpeg2hevc720p {
        ffmpeg -y -i "$1" -c:v libx265 -b:v  600k -x265-params pass=1 -an -f null /dev/null
        ffmpeg    -i "$1" -c:v libx265 -b:v  600k -x265-params pass=2 -c:a copy  "$2"
	rm x265_2pass.log x265_2pass.log.cutree
}
function ffmpeg2hevc360p {
        ffmpeg -y -i "$1" -c:v libx265 -b:v  150k -x265-params pass=1 -an -f null /dev/null
        ffmpeg    -i "$1" -c:v libx265 -b:v  150k -x265-params pass=2 -c:a copy  "$2"
	rm x265_2pass.log x265_2pass.log.cutree
}
function ffmpegcat {
	# or with printf
	printf "file '%s'\n" $* > mylist.txt
	echo ffmpeg -f concat -safe 0 -i mylist.txt
	}
function gify {
	convert "$1" +dither "$1.gif"; 
	convert "$1.gif" "$1"; 
	rm "$1.gif";
}

alias md-table="echo '|   |   |'; echo '|---|---|'; echo '|   |   |'"
alias xmlsectool="java -classpath /home/a/IdeaProjects/xmlsectool/target/classes:/home/a/.m2/repository/org/slf4j/slf4j-api/1.7.30/slf4j-api-1.7.30.jar:/home/a/.m2/repository/net/shibboleth/utilities/java-support/8.0.0/java-support-8.0.0.jar:/home/a/.m2/repository/com/google/guava/guava/29.0-jre/guava-29.0-jre.jar:/home/a/.m2/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar:/home/a/.m2/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:/home/a/.m2/repository/org/checkerframework/checker-qual/2.11.1/checker-qual-2.11.1.jar:/home/a/.m2/repository/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar:/home/a/.m2/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar:/home/a/.m2/repository/org/opensaml/opensaml-core/4.0.1/opensaml-core-4.0.1.jar:/home/a/.m2/repository/io/dropwizard/metrics/metrics-core/4.1.4/metrics-core-4.1.4.jar:/home/a/.m2/repository/org/opensaml/opensaml-security-api/4.0.1/opensaml-security-api-4.0.1.jar:/home/a/.m2/repository/org/opensaml/opensaml-messaging-api/4.0.1/opensaml-messaging-api-4.0.1.jar:/home/a/.m2/repository/org/cryptacular/cryptacular/1.2.4/cryptacular-1.2.4.jar:/home/a/.m2/repository/org/bouncycastle/bcpkix-jdk15on/1.64/bcpkix-jdk15on-1.64.jar:/home/a/.m2/repository/org/springframework/spring-core/5.2.9.RELEASE/spring-core-5.2.9.RELEASE.jar:/home/a/.m2/repository/org/springframework/spring-jcl/5.2.9.RELEASE/spring-jcl-5.2.9.RELEASE.jar:/home/a/.m2/repository/org/opensaml/opensaml-xmlsec-api/4.0.1/opensaml-xmlsec-api-4.0.1.jar:/home/a/.m2/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar:/home/a/.m2/repository/org/apache/santuario/xmlsec/2.0.6/xmlsec-2.0.6.jar:/home/a/.m2/repository/org/codehaus/woodstox/woodstox-core-asl/4.4.1/woodstox-core-asl-4.4.1.jar:/home/a/.m2/repository/javax/xml/stream/stax-api/1.0-2/stax-api-1.0-2.jar:/home/a/.m2/repository/org/codehaus/woodstox/stax2-api/3.1.4/stax2-api-3.1.4.jar:/home/a/.m2/repository/org/bouncycastle/bcprov-jdk15on/1.64/bcprov-jdk15on-1.64.jar:/home/a/.m2/repository/com/beust/jcommander/1.78/jcommander-1.78.jar:/home/a/.m2/repository/org/apache/httpcomponents/httpclient/4.5.12/httpclient-4.5.12.jar:/home/a/.m2/repository/org/apache/httpcomponents/httpcore/4.4.13/httpcore-4.4.13.jar:/home/a/.m2/repository/commons-codec/commons-codec/1.14/commons-codec-1.14.jar:/home/a/.m2/repository/org/opensaml/opensaml-xmlsec-impl/4.0.1/opensaml-xmlsec-impl-4.0.1.jar:/home/a/.m2/repository/org/opensaml/opensaml-security-impl/4.0.1/opensaml-security-impl-4.0.1.jar:/home/a/.m2/repository/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar:/home/a/.m2/repository/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar:/home/a/.m2/repository/org/slf4j/jcl-over-slf4j/1.7.30/jcl-over-slf4j-1.7.30.jar net.shibboleth.tool.xmlsectool.XMLSecTool"
alias ts-validate="LANG=en_US java -classpath $HOME/IdeaProjects/TokenScript/libs/XMLValidator.jar:$HOME/IdeaProjects/TokenScript/libs/xpath2-1.2.0.jar:$HOME/IdeaProjects/TokenScript/libs/xercesImpl.jar:$HOME/IdeaProjects/TokenScript/libs/xercesSamples.jar:xml-apis.jar XMLValidator $HOME/DitaProjects/TokenScript/schema/tokenscript.xsd"
alias jq-functions="jq -r '.[] | select(.type == \"function\") | [.type, .name] | @tsv' "
alias new-schema-is-good-for-old-tokenscripts='pushd ~/IdeaProjects/TokenScript-Examples/examples;  TOKENSCRIPT_SCHEMA=/home/weiwu/IdeaProjects/TokenScript/schema/tokenscript.xsd ./validate.sh  */*.xml */*/*.xml; popd'
alias sleep_adb="sleep 10 ; adb tcpip 5555"
alias 2x="_JAVA_OPTIONS=-Dsun.java2d.uiScale=2.0"
#alias onedrive_sync="rclone sync -P OneDrive:Team/ ~/Team/"
alias team_sync="onedrive --synchronize --download-only --single-directory Team"
alias onedrive_mount="rclone --vfs-cache-mode writes mount OneDrive: ~/OneDrive/"
alias dropbox_mount="rclone --vfs-cache-mode writes mount Dropbox: ~/Dropbox/"
alias gdrive_mount="rclone mount --drive-shared-with-me GDrive: ~/GDrive/"
# echo 3067 1651 60 106
alias RiverMill='cd ~/"OneDrive/🇦🇺 Colourful.land Pty Ltd/"'
alias CGCT.gnucash="LANG=en_AU.UTF-8 LANGUAGE=en gnucash ~/'OneDrive/Team/🇪🇪 Computer Graphic and Cryptographic Technology OÜ/Accounting/CGCT.gnucash'"
alias CGCT="cd ~/'OneDrive/🇪🇪 Computer Graphic and Cryptographic Technology OÜ/'"
alias Palacio="cd ~/'OneDrive/🇪🇸 Palacio Bizcocheros SL'"
alias qq="rm -r ~/.local/homes/qq/.config/tencent-qq/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]; bwrap --dev-bind / / --bind $HOME/.local/homes/qq $HOME --ro-bind $HOME/.Xauthority $HOME/.Xauthority --ro-bind /var/local/trove $HOME/Videos /usr/local/bin/qq"
alias gnucash_CGCT="LANG=en_AU.UTF-8 LANGUAGE=en gnucash ~/OneDrive/Businesses/Computer\ Graphic\ and\ Cryptographic\ Technology\ OÜ/Accounting/CGCT.gnucash"
alias rclone="rclone --vfs-cache-mode writes"
alias pcloudsync='rclone sync --exclude Favourite --delete-after pCloud: /media/weiwu/Seagate\ Expansion\ Drive/pCloud/'

# deduplicate files by comparing size (only for greater than 100MB)
# 
# $1: source (directory with files to keep)
# $2: target (directoryy with files to discard)
# Only the files in target will be returned, which can be piped to xargs rm
function dedup {
	du -ab "$1" | awk -F $"\t" '$1 > 10485760 {print;}' | sort -k1,1 -t $'\t'   > /tmp/keep
	du -ab "$2" | awk -F $"\t" '$1 > 10485760 {print;}' | sort -k1,1 -t $'\t'   > /tmp/dup
	join -j 1 -t $'\t' /tmp/keep /tmp/dup | awk -F $"\t" '{print $3;}'
}

# a version that shows which file is duplicating which file
# to show only the duplicates with same filename, use a different join:
# join -j 1 -t $'\t' /tmp/keep /tmp/dup | awk -F $"\t" '{fn1 = $2; fn2 = $3; sub(/.*\//, "", fn1);sub(/.*\//, "", fn2); if (fn1 == fn2) print $3;}'
function lsdup {
	du -ab "$1" | awk -F $"\t" '$1 > 10485760 {print;}' | sort -k1,1 -t $'\t'  > /tmp/keep
	du -ab "$2" | awk -F $"\t" '$1 > 10485760 {print;}' | sort -k1,1 -t $'\t'  > /tmp/dup
	join -j 1 -t $'\t' /tmp/keep /tmp/dup | column -t -s $'\t'
}

# upload to a ftp server then return the HTTP address to access that file
function upload_ann {
    for file in "$@"; do
        filename=`basename "$file"`
        lftp -c "connect server2.obble.com.au; put '$file'" && echo -n https://computer.graphic.and.cryptographic.technology/ann/ && echo -n "$filename" | jq -sRr @uri
    done
}

# this function takes 2 parameters, the pdf file and the page range. It replaces the file with a newer smaller one with only specified pages
function pdf_select_pages {
	qpdf "$1" --pages . "$2" -- "$1".new && mv "$1.new" "$1"
}
alias 2560x1440='xrandr --newmode  "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync ; xrandr --addmode HDMI1 2560x1440_60.00"'
alias oxygen='JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64 /opt/oxygen/oxygen.sh '

alias styleless-paste="xclip -o -selection clipboard | pandoc -s --no-highlight --self-contained -f markdown -t html | sed 's/<table/<table width=100% border=1/' | tr '\n' '\r' | sed -e 's/<style[^>]*>.*<\/style>//g'| tr '\r' '\n' | tee /dev/stderr | xclip -selection clipboard -t text/html"
alias youtube-dl="python3 ~/Projects/youtube-dl/youtube_dl/__main__.py"
alias "reinstall_firefox"='sudo apt-get purge firefox=1:1snap1-0ubuntu3 ; sudo apt-get install firefox=116.0+build2-0ubuntu0.23.04.1~mt1'
alias "path2emoji"='sed -e "s|/\$||" -e "s|/|→ |g" -e "s|\.\.|⬆️|g"'
alias "unicode-monospace"="sed -E -e s/A/𝙰/g -e s/B/𝙱/g -e s/C/𝙲/g -e s/D/𝙳/g -e s/E/𝙴/g -e s/F/𝙵/g -e s/G/𝙶/g -e s/H/𝙷/g -e s/I/𝙸/g -e s/J/𝙹/g -e s/K/𝙺/g -e s/L/𝙻/g -e s/M/𝙼/g -e s/N/𝙽/g -e s/O/𝙾/g -e s/P/𝙿/g -e s/Q/𝚀/g -e s/R/𝚁/g -e s/S/𝚂/g -e s/T/𝚃/g -e s/U/𝚄/g -e s/V/𝚅/g -e s/W/𝚆/g -e s/X/𝚇/g -e s/Y/𝚈/g -e s/Z/𝚉/g -e s/a/𝚊/g -e s/b/𝚋/g -e s/c/𝚌/g -e s/d/𝚍/g -e s/e/𝚎/g -e s/f/𝚏/g -e s/g/𝚐/g -e s/h/𝚑/g -e s/i/𝚒/g -e s/j/𝚓/g -e s/k/𝚔/g -e s/l/𝚕/g -e s/m/𝚖/g -e s/n/𝚗/g -e s/o/𝚘/g -e s/p/𝚙/g -e s/q/𝚚/g -e s/r/𝚛/g -e s/s/𝚜/g -e s/t/𝚝/g -e s/u/𝚞/g -e s/v/𝚟/g -e s/w/𝚠/g -e s/x/𝚡/g -e s/y/𝚢/g -e s/z/𝚣/g -E -e s/0/𝟶/g -e s/1/𝟷/g -e s/2/𝟸/g -e s/3/𝟹/g -e s/4/𝟺/g -e s/5/𝟻/g -e s/6/𝟼/g -e s/7/𝟽/g -e s/8/𝟾/g -e s/9/𝟿/g"
