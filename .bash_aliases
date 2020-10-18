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
# ffmpeg -i /tmp/record_2020-06-30-15-56-34.mp4 -vf scale=360:720 -r 15 record.gif
function vid2gif {
	# https://tyhopp.com/notes/ffmpeg-crosshatch
	ffmpeg -i "$1" -vf palettegen /tmp/palette.png && \
	ffmpeg -i "$1" -i /tmp/palette.png -filter_complex "fps=15, scale=640:-1, paletteuse=dither=none" "$1.gif"
}

alias masterup="git checkout master && git pull origin master"
alias vk-dl="youtube-dl \`awk '\$2 == \"vk.com\" { print \"-u \" \$4 \" -p \" \$6 ;}' ~/.netrc \`"
alias md-table="echo '|   |   |'; echo '|---|---|'; echo '|   |   |'"
alias xmlsectool="java -classpath /home/a/IdeaProjects/xmlsectool/target/classes:/home/a/.m2/repository/org/slf4j/slf4j-api/1.7.30/slf4j-api-1.7.30.jar:/home/a/.m2/repository/net/shibboleth/utilities/java-support/8.0.0/java-support-8.0.0.jar:/home/a/.m2/repository/com/google/guava/guava/29.0-jre/guava-29.0-jre.jar:/home/a/.m2/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar:/home/a/.m2/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:/home/a/.m2/repository/org/checkerframework/checker-qual/2.11.1/checker-qual-2.11.1.jar:/home/a/.m2/repository/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar:/home/a/.m2/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar:/home/a/.m2/repository/org/opensaml/opensaml-core/4.0.1/opensaml-core-4.0.1.jar:/home/a/.m2/repository/io/dropwizard/metrics/metrics-core/4.1.4/metrics-core-4.1.4.jar:/home/a/.m2/repository/org/opensaml/opensaml-security-api/4.0.1/opensaml-security-api-4.0.1.jar:/home/a/.m2/repository/org/opensaml/opensaml-messaging-api/4.0.1/opensaml-messaging-api-4.0.1.jar:/home/a/.m2/repository/org/cryptacular/cryptacular/1.2.4/cryptacular-1.2.4.jar:/home/a/.m2/repository/org/bouncycastle/bcpkix-jdk15on/1.64/bcpkix-jdk15on-1.64.jar:/home/a/.m2/repository/org/springframework/spring-core/5.2.9.RELEASE/spring-core-5.2.9.RELEASE.jar:/home/a/.m2/repository/org/springframework/spring-jcl/5.2.9.RELEASE/spring-jcl-5.2.9.RELEASE.jar:/home/a/.m2/repository/org/opensaml/opensaml-xmlsec-api/4.0.1/opensaml-xmlsec-api-4.0.1.jar:/home/a/.m2/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar:/home/a/.m2/repository/org/apache/santuario/xmlsec/2.0.6/xmlsec-2.0.6.jar:/home/a/.m2/repository/org/codehaus/woodstox/woodstox-core-asl/4.4.1/woodstox-core-asl-4.4.1.jar:/home/a/.m2/repository/javax/xml/stream/stax-api/1.0-2/stax-api-1.0-2.jar:/home/a/.m2/repository/org/codehaus/woodstox/stax2-api/3.1.4/stax2-api-3.1.4.jar:/home/a/.m2/repository/org/bouncycastle/bcprov-jdk15on/1.64/bcprov-jdk15on-1.64.jar:/home/a/.m2/repository/com/beust/jcommander/1.78/jcommander-1.78.jar:/home/a/.m2/repository/org/apache/httpcomponents/httpclient/4.5.12/httpclient-4.5.12.jar:/home/a/.m2/repository/org/apache/httpcomponents/httpcore/4.4.13/httpcore-4.4.13.jar:/home/a/.m2/repository/commons-codec/commons-codec/1.14/commons-codec-1.14.jar:/home/a/.m2/repository/org/opensaml/opensaml-xmlsec-impl/4.0.1/opensaml-xmlsec-impl-4.0.1.jar:/home/a/.m2/repository/org/opensaml/opensaml-security-impl/4.0.1/opensaml-security-impl-4.0.1.jar:/home/a/.m2/repository/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar:/home/a/.m2/repository/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar:/home/a/.m2/repository/org/slf4j/jcl-over-slf4j/1.7.30/jcl-over-slf4j-1.7.30.jar net.shibboleth.tool.xmlsectool.XMLSecTool"
