xrandr --dpi 91
xrandr --output HDMI-0 --mode 2560x1080 --pos 1920x0 --rotate left --rate 60.00 --output DP-0 --primary --mode 1920x1080 --pos 0x740 --rotate normal --rate 144.00
xrdb ~/.Xresources
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
exec i3
