#!/bin/bash
FP=$(dirname "$0")
#echo "full path: $FP"

MAX=$(pacmd list-sinks | grep 'index:' | cut -b12- | tail -n1)
echo "Max: $MAX"

CUR=".current"
echo $(cat $FP/$CUR | $FP/arithmetic + 1 -int | $FP/cf min $MAX -int | $FP/cf max 0 -int) > $CUR