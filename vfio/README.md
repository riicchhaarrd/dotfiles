# Personal single GPU passthrough configuration


## packages
```
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager ovmf
```

## libvirt config

### /etc/libvirt/libvirtd.conf

```
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"

log_filters="1:qemu"
log_outputs="1:file:/var/log/libvirt/libvirtd.log"
```

### /etc/libvirt/qemu.conf

```
user = "username"
group = "username"
```

```
sudo usermod -a -G kvm $USER 
sudo usermod -a -G libvirt $USER
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```

## grub config

GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on iommu=pt video=efifb:off,vesafb:off splash"

# vm xml settings

### ovmf

bios UEFI
q35
/usr/share/OVMF/OVMF_CODE_4M.fd

### cpu

```
<cpu mode='host-model' check='none'>
  <topology sockets='1' dies='1' cores='4' threads='1'/>
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

### gpu

```
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source>
    <address domain='0x0000' bus='0x09' slot='0x00' function='0x0'/>
  </source>
  <rom file='/usr/share/vgabios/VBIOS.rom'/>
  <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
</hostdev>
```
