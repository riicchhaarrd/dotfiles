alias gitdiff='git diff | kompare -o -'
alias gitdiff3='git show | kompare -o -'
alias clip='xclip -sel clip'
alias cats='highlight -O ansi --force --syntax c'
alias gitdiff2='git diff HEAD | kompare -o -'
alias home='git --work-tree=$HOME --git-dir=$HOME/.home'
alias webm='ffmpeg -c:v vp8'
alias gsc='~/git/gsc/bin/gsc'
alias sst='scrot -o -s /tmp/image.png'
alias ec="emacsclient --create-frame"
alias nf='neofetch --disable cpu gpu resolution term memory packages uptime wm'
alias notepad++='wine "C:/Program Files/Notepad++/notepad++.exe"'
alias rasmtest='rasm2 -a x86 -b 32 "push esp"'
#https://superuser.com/questions/125376/how-do-i-compare-binary-files-in-linux
alias hexdiffexample='colordiff -y <(xxd foo1.bin) <(xxd foo2.bin)'
#alias vm='qemu-system-x86_64 -hda HEAD.img -machine type=q35,accel=kvm -m 8192M -vga virtio &'
#alias spicevm='qemu-system-x86_64 -hda HEAD.img -machine type=q35,accel=kvm -m 8192M -smp 3 -enable-kvm \
#-vga qxl -device virtio-serial-pci -spice unix,addr=/tmp/vm_spice.socket,disable-ticketing -device \
#virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev \
#spicevmc,id=spicechannel0,name=vdagent -device virtio-mouse-pci -device virtio-keyboard-pci &'
#alias rdp='remote-viewer --title=Win10 --spice-disable-effects=all --spice-color-depth=32
#--spice-disable-audio spice+unix:///tmp/vm_spice.socket &'
alias ed='emacsclient -c -n -a ""'
alias e='emacsclient --tty'
alias dis='rasm2 -a x86 -b 32 -d'
alias ras='rasm2 -a x86 -b 32'
alias lz='ls -trhl'
alias ke='emacsclient -e (save-buffers-kill-emacs)'
alias fix='xrandr --output DP-0 --mode 1920x1080 --rate 144.00 --primary --output HDMI-0 --rotate normal --mode 2560x1080 --rate 60.00 --right-of DP-0'
alias ducks='du -cks * | sort -rn | head'
