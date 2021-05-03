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
xrandr --output DP-0 --mode 1920x1080 --rate 144.00 --primary --output HDMI-0 --mode 2560x1080 --rate 60.00 --right-of DP-0 &
#xfce4-panel &
tint2 &
#xcompmgr &
#compton &
#compton --blur-background --fading --refresh-rate 144 --blur-kern 7x7box --clear-shadow --shadow --no-dock-shadow &
compton --blur-background --fading --refresh-rate 144 --blur-kern 7x7box --clear-shadow --shadow --no-dock-shadow --fade-in-step=0.07 --fade-out-step=0.07 --frame-opacity=0.5 &
nitrogen --restore &
#xinput set-prop 10 "libinput Accel Speed" 0
xinput set-prop 10 "libinput Accel Speed" -0.35
#pnmixer &
#pasystray&
# amsterdam latitude & longitude
redshift -l 52.3676:4.9041 &
diodon &
#lxpolkit
xfdesktop&
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/notification-daemon/notification-daemon &
