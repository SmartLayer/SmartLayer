#!/bin/sh

# optimise the files sent by Remarkable2
 
# remove grid

scour "$1" /tmp/new.svg

sed -e '/<image.*\/>/d' -e 's/<path /<path transform="rotate (90)" /' \
    -e 's/<svg width="1404" height="1872" baseProfile="tiny" version="1.2" viewBox="0 0 1404 1872"/<svg width="1872" height="1404" baseProfile="tiny" version="1.2" viewBox="-1872 0 1872 1404"/'\
    /tmp/new.svg > "$1"

# optimise the file (remarkable 2 produces too many points in Bézier curve)


