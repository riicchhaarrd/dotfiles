# Configuration & Setup for new installation
--------------------------------------------------------------------------------

# Disable mouse acceleration on xorg
SRC
.setup/50-mouse-acceleration.conf
DST
/etc/X11/xorg.conf.d/50-mouse-acceleration.conf

# Enable folder thumbnailer

[Thumbnailer Entry]
Version=1.0
Encoding=UTF-8
Type=X-Thumbnailer
Name=Folder Thumbnailer
MimeType=inode/directory;
Exec=/home/user/scripts/thumbnail/folder-thumbnailer.sh %s %i %o %u

/usr/share/thumbnailers/folder.thumbnailer

# Copy all files including *
shopt -s dotglob

# Enable wifi

/sbin/iwconfig
nano /etc/network/interfaces

iface <iface> inet dhcp
	wpa-ssid <ssid>
	wpa-psk <pass>

/sbin/ifup <interface>

# Enable touchpad tapping

apt remove xserver-xorg-input-synaptics
apt install xserver-xorg-input-libinput
mkdir /etc/X11/xorg.conf.d/


Section "InputClass"
Identifier "libinput touchpad catchall"
MatchIsTouchpad "on"
MatchDevicePath "/dev/input/event*"
Driver "libinput"
Option "Tapping" "on"
EndSection

> /etc/X11/xorg.conf.d/40-libinput.conf

systemctl restart lightdm


* To enable better performance with QEMU & Spice
sudo systemctl status spice-vdagent

# i3 firefox right click fix

about:config
ui.context_menus.after_mouseup to true

# applying xfce-panel4 theme without running xfwm and using openbox or e.g i3
xfsettingsd
