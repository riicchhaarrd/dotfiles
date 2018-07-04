#!/bin/bash

# Script to switch all programs to a specific sink. Why this isn't easy, i
# don't know.

# This script takes a single argument, the sink name, index, or alias (defined
# below).

# To make this work, you will need to:
#   - In /etc/pulse/default.pa:
#       change "load-module module-stream-restore"
#       to     "load-module module-stream-restore restore_device=false"
#     This makes all streams use the default device when they start, rather
#     than the last device.
#   - Set up the sink_names array below.
#     PulseAudio sink names are usually rather obtuse, and the indices can
#     change, so you can declare short names for sinks in the array below.
#     
#     The format is '[alias]=device_name'. The sink names can be found with:
#       $ pacmd list-sinks | grep '^\s*name'
#     , and are the monstrosities between the angle brackets.

declare -A sink_names=(
	[speakers]=alsa_output.pci-0000_27_00.1.hdmi-stereo-extra1
	[headphones]=alsa_output.pci-0000_29_00.3.analog-stereo
)

FP=$(dirname "$0")
sink=${sink_names[$1]:-$1}
SINK_ID=$(pactl list sinks short | grep $sink | awk '{print $1}')
#echo "New sink is $SINK_ID"
echo $SINK_ID > $FP/.current
#cat $FP/.current
(
	echo set-default-sink $sink
	
	pacmd list-sink-inputs |
		grep -E '^\s*index:' |
		grep -oE '[0-9]+' |
		while read input
	do
		echo move-sink-input $input $sink
	done
) | pacmd > /dev/null
