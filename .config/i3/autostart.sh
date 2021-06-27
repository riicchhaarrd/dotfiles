# for vertical monitor
#xrandr --output HDMI-0 --mode 2560x1080 --pos 1920x0 --rotate left --rate 60.00 --output DP-0 --primary --mode 1920x1080 --pos 0x740 --rotate normal --rate 144.00 &

# non-vertical monitor
xrandr --output HDMI-0 --mode 2560x1080 --rotate normal --rate 60.00 --right-of DP-0 --output DP-0 --primary --mode 1920x1080 --rotate normal --rate 144.00 &

nitrogen --restore &
mouse_id=$(xinput --list --id-only 'Kingsis Peripherals ZOWIE Gaming mouse')
xinput --set-prop $mouse_id 'libinput Accel Profile Enabled' 0, 1 &
xinput --set-prop $mouse_id "libinput Accel Speed" -0.35 &
#xmodmap -e "pointer = 3 2 1"
compton &
diodon &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/notification-daemon/notification-daemon &
setxkbmap -option caps:super &
#pasystray &
#tint2 &
#alttab &
blueman-applet &
redshift -l 52.3676:4.9041 &
xfsettingsd &
xrdb ~/.Xresources
