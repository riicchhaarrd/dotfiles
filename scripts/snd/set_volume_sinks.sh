#VOLUME='+5%'
VOLUME=$(echo $1 | ./65k)
for SINK in `pacmd list-sinks | grep 'index:' | cut -b12-`
do
./set_volume_sink.sh $SINK $VOLUME
done
