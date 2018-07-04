#!/bin/bash

FP=$(dirname "$0")

SINK=$1
VOLUME=$2
CUR=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
	
CUR_FIXED=$(echo $CUR | $FP/arithmetic / 100)
NV=$(echo $VOLUME | $FP/arithmetic + $CUR_FIXED | $FP/65k)
pacmd set-sink-volume $SINK $NV
# uncomment this if u just want the base
$FP/set_streams_volume.sh $SINK $(echo $NV | $FP/65k)
#echo "Sink: $SINK: current: $CUR_FIXED New: $NV"
echo "Sink: $SINK: current: $CUR_FIXED New: $(echo $NV | $FP/65k)"
