#!/bin/bash
#watch -n 1 cat /dev/vcs
set -x
#You can just unbind your NVIDIA's HDMI device from it instead unloading the whole driver.
#1- Check devices bound to it:
#ls /sys/bus/pci/drivers/snd_hda_intel/
#2- Unbind it:
#echo -n "0000:01:00.1" > /sys/bus/pci/drivers/snd_hda_intel/unbind  
#You can check if there is any process still using the audio device with:
#sudo fuser -v /dev/snd/by-path/pci-0000\:01\:00.1

## Kill the Display Manager
#systemctl stop lightdm
#killall -u $USER
killall openbox
systemctl stop nvidia-persistenced

## Remove the framebuffer and console
echo 0 > /sys/class/vtconsole/vtcon0/bind
#echo 0 > /sys/class/vtconsole/vtcon1/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

sleep 2

echo -n "0000:09:00.0" > /sys/bus/pci/devices/0000:09:00.0/driver/unbind #gpu
echo -n "0000:09:00.1" > /sys/bus/pci/devices/0000:09:00.1/driver/unbind #audio
#echo -n "0000:0b:00.3" > /sys/bus/pci/devices/0000:0b:00.3/driver/unbind #audio 2

# Unload the Kernel Modules that use the GPU
virsh nodedev-detach pci_0000_09_00_0
virsh nodedev-detach pci_0000_09_00_1
#virsh nodedev-detach pci_0000_0b_00_3

modprobe -r nvidia_drm
modprobe -r nvidia_modeset
modprobe -r nvidia
modprobe -r snd_hda_intel

modprobe vfio
modprobe vfio-pci

echo 10de 1c82 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id # gpu
echo 10de 0fb9 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id # audio
#echo 1022 1457 | /sys/bus/pci/drivers/vfio-pci/new_id # audio 2
