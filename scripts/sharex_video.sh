#!/bin/bash

PROC="ffmpeg"
ps cax | grep $PROC
if [ $? -eq 0 ]; then
echo "Process is running."
killall $PROC
exit 1
fi

TYPE="mp4"
FILE="$HOME/screenshots/screenshot-`date '+%Y-%m-%d-%N'`.${TYPE}"

# actual recording with ffmpeg / avconv
read -r X Y W H G ID < <(slop -f "%x %y %w %h %g %i")
#avconv -y -f x11grab -video_size "$W"x"$H" -show_region 1 -framerate 30 -i :0.0+$X,$Y -f pulse -ac 2 -i default $FILE
$PROC -y -f pulse -i default -f x11grab -show_region 1 -framerate 30 -video_size "$W"x"$H" -i :0.0+$X,$Y -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -b:a 128k -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" $FILE
# needs this bs otherwise can't play in firefox removed audio codec meh should be fine atm
if [ ! -f $FILE ]; then
notify-send --hint=int:transient:1 -t 1500 "Aborted!"
exit 1
fi

# dependencies jq curl xclip and scrot notify-send
DOMAIN="https://example.org"

LINK=$(curl -F "k=API_KEY" \
-F "d"=@"${FILE}" \
-X POST "$DOMAIN/upload.php?up" \
| jq -r '.filename' );
URL="$DOMAIN/ss/$LINK"

echo "$URL" | xclip -selection clipboard
notify-send --hint=int:transient:1 -t 1000 "Link copied to clipboard $URL"
