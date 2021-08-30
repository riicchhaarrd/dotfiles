# Personal Debian single GPU passthrough configuration (Debian 11 QEMU/KVM VFIO AMD/RYZEN/NVIDIA)

## Why?
Mainly written to help my future self for future reference, if this helps anyone else with their installation then that's great too.

## Hardware specs
Ryzen 1st gen (without onboard graphics)

NVIDIA GeForce card

## Installation steps

1. Download the Debian 11 ISO file from https://debian.org and create a bootable CD/USB drive.
2. Install Debian 11 as you want and unselect everything from the tasksel menu (the menu which asks you which desktop environment and software you want to install).
3. Reboot and login

## Sources

Edit the sources file

```
sudo nano /etc/apt/sources.list
```

Edit the lines of the file to match the lines below.

```
deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free
```

Hit CTRL-X and press Y and ENTER to save the file.

Run the command below.

```
sudo apt update
```

## Firmware & Drivers

**You may or may not need to install extra additional firmware packages depending on your system.**

Run the command below.

```
sudo apt install -y firmware-linux firmware-linux-nonfree firmware-realtek nvidia-driver
```

## Graphical Interface

```
sudo apt install xinit xorg xinput xterm openbox policykit-1-gnome libnotify-bin lightdm
```

After it's done installing reboot your system.

```
/sbin/reboot
```

After the reboot you should see a black screen with a cursor. Right click anywhere on the screen to open up a menu and click on option "Terminal emulator" to open a terminal window.


### Webbrowser

*You may want to use a webbrowser and browse the web to consult this document or other websites for support. If so then enter the command below in the terminal window.*

```
sudo apt install firefox-esr
```
This will install a Extended Support Release version of Firefox, so you'll atleast be able to search for any issues that you may find during the installation process.

## Virtualization

Install these packages.

```
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager ovmf qemu-system
```

### Prerequisites
- Dumped VBIOS of your GPU. See [VBIOS Dumping Tutorial](https://www.youtube.com/watch?v=FWn6OCWl63o)
- ISO file of the OS you're planning to install on the virtual machine.

Run the command below in a terminal to open up virt-manager
```
virt-manager
```

In virt-manager create a VM of choice like you normally would and wait till the installation of said OS is done and then close the shutdown the VM.
**Make sure to use Q35 as BIOS and /usr/share/OVMF/OVMF_CODE_4M.fd as Firmware.**

### libvirtd configuration

Edit the file /etc/libvirt/libvirtd.conf using nano.

```
sudo nano /etc/libvirt/libvirtd.conf
```

*Tip: You can search for words in nano using CTRL-W*

Find the corresponding keys in the file like shown below and match the values to the values down here.

```
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"

log_filters="1:qemu"
log_outputs="1:file:/var/log/libvirt/libvirtd.log"
```

### QEMU configuration

Same applies to the qemu.conf file.

```
sudo nano /etc/libvirt/qemu.conf
```

```
user = "<YOUR USER>"
group = "<YOUR USER>"
```

### GRUB configuration

Edit the file /etc/default/grub.

```
sudo nano /etc/default/grub
```

*Your configuration may be different depending on whether you're using a different Linux distribution or another CPU (e.g Intel)*

```
GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on iommu=pt video=efifb:off,vesafb:off splash"
```

### Commandline

Enter these commands into the terminal.

```
sudo usermod -a -G kvm $USER 
sudo usermod -a -G libvirt $USER
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo virsh net-autostart default
sudo update-grub
```

Reboot your computer again.

*Whether you installed a display manager (e.g lightdm) or none your screen may stay black or not show up (even though you can login and type startx and eventually get a working graphical interface).*

*TIP: Install a ssh server (package: openssh-server) beforehand and ssh into your system from another computer.*

*TIP: Run `sudo watch -n 1 cat /dev/vcs` from the remote computer in a ssh session to see what's actually on the computer screen.*

### Hooks

**Make sure you edit the hook scripts so they match your specific hardware setup (IOMMU group, PCI-id)**
1. Copy the hooks folder into /etc/libvirt.
2. Edit your virtual machine and remove the SPICE display.
3. Add your USB mouse & keyboard to your VM.
4. Add your videocard PCI device (and all the other devices that are in the same IOMMU group) to the VM.
5. Edit the videocard PCI settings to use your dumped ROM. See *VM ROM XML*

### VM ROM XML

```
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source>
    <address domain='0x0000' bus='0x09' slot='0x00' function='0x0'/>
  </source>
  <rom file='/usr/share/vgabios/VBIOS.rom'/>
  <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
</hostdev>
```


## Optional Configuration

## ~/.config/openbox/autostart.sh
```
# monitor resolution & refresh rate
xrandr --output DP-0 --mode 1920x1080 --rate 144.00 --primary --output HDMI-0 --rotate normal --mode 2560x1080 --rate 60.00 --right-of DP-0 &

# personal config for mouse accel and sensitivity
mouse_id=$(xinput --list --id-only 'Kingsis Peripherals ZOWIE Gaming mouse')
xinput --set-prop $mouse_id 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop $mouse_id "libinput Accel Speed" -0.35

# prompts when sudo is needed
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# receive notifications
/usr/lib/notification-daemon/notification-daemon &

# bind caps lock to winkey
setxkbmap -option caps:super

# open virt-manager
virt-manager &
```

```
chmod +x ~/.config/openbox/autostart.sh
```

## /etc/lightdm/lightdm.conf

Automatically login using lightdm.

```
[SeatDefaults]
autologin-user=<YOUR USER>
```

## VM XML

### features
```
<kvm>
	<hidden state="on"/>
</kvm>
```

### cpu

```
<cpu mode='host-model' check='none'>
	<topology sockets='1' dies='1' cores='4' threads='1'/>
	<feature policy="disable" name="hypervisor"/>
	<feature policy='require' name='topoext'/>
	<feature policy='disable' name='amd-stibp'/>
</cpu>
```
    
### hyperv
```
<hyperv>
	<relaxed state='on'/>
	<vapic state='on'/>
	<spinlocks state='on' retries='8191'/>
	<vpindex state='on'/>
	<synic state='on'/>
	<stimer state='on'/>
	<reset state='on'/>
	<vendor_id state='on' value='1234567890ab'/>
	<frequencies state='on'/>
</hyperv>
```
