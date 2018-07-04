#!/bin/bash

# Usage ./set_streams_volume <sink id> <volume 0-1>
FP=$(dirname "$0")
#for STREAM in `pactl list sink-inputs | grep 'Sink Input' | awk -F"#" '{ print $NF }'`
for STREAM in `pactl list short sink-inputs | awk '{print $1}'`
do
	for SINK in `pactl list short sink-inputs | awk '{print $2}'`
	do
	if [ $SINK -eq $1 ];then
		echo "Stream: $STREAM, Sink: $SINK"
		pactl set-sink-input-volume $STREAM $(echo $2 | $FP/65k -int)
		break
	fi
	done
done
