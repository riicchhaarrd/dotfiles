sleep 1
xrandr --output DP-0 --mode 1920x1080 --rate 144 &
#xcompmgr -cfF -t-9 -l-11 -r9 -o.95 -D6 &
#enable above for transparency and stuff
pulseaudio -D &
nitrogen --restore &
tilda -h &
#xcompmgr -cfF -t-9 -l-11 -r9 -o.95 -D6 &
redshift &
tint2 &
#pnmixer &
#pasystray &
xset mouse 0 0 &
#steam &
#discord --disable-smooth-scrolling &
/usr/lib/notification-daemon/notification-daemon &
#pcmanfm --desktop &
xfdesktop &
sleep 2
wbar &
# mount devices
~/scripts/mount_pi.sh
sleep 10
conky &
