#
# These things are run when an Openbox X Session is started.
# You may place a similar script in $HOME/.config/openbox/autostart
# to run user-specific things.
#

# If you want to use GNOME config tools...
#
#if test -x /usr/lib/x86_64-linux-gnu/gnome-settings-daemon >/dev/null; then
#  /usr/lib/x86_64-linux-gnu/gnome-settings-daemon &
#elif which gnome-settings-daemon >/dev/null 2>&1; then
#  gnome-settings-daemon &
#fi

# If you want to use XFCE config tools...
#
#xfce-mcs-manager &
xrandr --output DP-0 --mode 1920x1080 --rate 144.00 --primary --output HDMI-0 --rotate normal --mode 2560x1080 --rate 60.00 --right-of DP-0 &
#xrandr --output DP-0 --pos 0x740 --mode 1920x1080 --rate 144.00 --primary --output HDMI-0 --pos 1920x0 --mode 2560x1080 --rate 60.00 --right-of DP-0 &
#xrandr --output HDMI-0 --mode 2560x1080 --pos 1920x0 --rotate left --rate 60.00 --output DP-0 --primary --mode 1920x1080 --pos 0x740 --rotate normal --rate 144.00
#xrandr --output HDMI-0 --mode 2560x1080 --pos 1920x0 --rotate left --rate 60.00 --output DP-0 --primary --mode 1920x1080 --pos 0x740 --rotate normal --rate 144.00
#xfce4-panel &
tint2 &
#xcompmgr &
#compton &
#redshift -l 52.3676:4.9041 &

##compton --blur-background --fading --refresh-rate 144 --blur-kern 7x7box --clear-shadow --shadow --no-dock-shadow &
##compton --blur-background --fading --refresh-rate 144 --blur-kern 3x3box --clear-shadow --shadow --no-dock-shadow --fade-in-step=0.07 --fade-out-step=0.07 --frame-opacity=0.5 &
nitrogen --restore &
##xinput set-prop 10 "libinput Accel Speed" 0
##xinput set-prop 8 "libinput Accel Speed" -0.35

##xinput set-prop 8 "libinput Accel Speed" -0.1
##xinput --set-prop 8 'libinput Accel Profile Enabled' 0, 1
mouse_id=$(xinput --list --id-only 'Kingsis Peripherals ZOWIE Gaming mouse')
xinput --set-prop $mouse_id 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop $mouse_id "libinput Accel Speed" -0.35
# reverse left and right button of mouse
#xmodmap -e "pointer = 3 2 1"
#bash ~/.config/openbox/mouse.sh -0.75
#pnmixer &
#pasystray&
# amsterdam latitude & longitude
diodon &
#lxpolkit
#xfdesktop&
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/notification-daemon/notification-daemon &
wineserver --persistent &
pcmanfm --desktop &
# map wacom table to single display
# just the stylus device is good enough
# xsetwacom --list devices
#xsetwacom --set 13 MapToOutput HEAD-0
# set capslock to super (windows key)
setxkbmap -option caps:super
