#!/bin/bash
set -x

virsh nodedev-reattach pci_0000_09_00_0
virsh nodedev-reattach pci_0000_09_00_1
#virsh nodedev-reattach pci_0000_0b_00_3

modprobe -r vfio_pci
modprobe -r vfio

# Reload the kernel modules
modprobe nvidia
modprobe nvidia_modeset
modprobe nvidia_uvm
modprobe nvidia_drm
modprobe snd_hda_intel

## Reload the framebuffer and console
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

#su -s /bin/bash -c "/usr/bin/startx" -g $USER $USER
