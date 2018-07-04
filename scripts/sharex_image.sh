#!/bin/bash

TYPE=jpg #png, jpg, gif, etc. | if you change this, be sure to change the quality
QUALITY=90 #image quality
FILE="$HOME/screenshots/screenshot-`date '+%Y-%m-%d-%N'`.${TYPE}"

case "$1" in
	-s|--selection)
		OPTIONS="-s -b -q ${QUALITY}"
		;;
	-a|--all)
		OPTIONS="-q ${QUALITY}"
		;;
	*)
		echo "Usage: ${0} <-a/--all|-s/--selection> [-n/--noupload]"
		exit 1
esac

ret=$(scrot ${OPTIONS} "${FILE}")
#if [ $ret -eq 0 ];
#then
#exit 1
#fi

if [ ! -f $FILE ]; then
notify-send --hint=int:transient:1 -t 1500 "Aborted!"
exit 1
fi

# dependencies jq curl xclip and scrot notify-send
DOMAIN="https://example.org"

LINK=$(curl -F "k=API_KEY_HERE" \
-F "d"=@"${FILE}" \
-X POST "$DOMAIN/upload.php?up" \
| jq -r '.filename' );
URL="$DOMAIN/ss/$LINK"

echo "$URL" | xclip -selection clipboard
notify-send --hint=int:transient:1 -t 1000 "Link copied to clipboard $URL"
