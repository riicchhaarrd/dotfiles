# opens up kompare and gives a gui overview of changes
# alternative use magit & emacs
alias gitdiff='git diff | kompare -o -'
alias gitdiff2='git diff HEAD | kompare -o -'
alias gitdiff3='git show | kompare -o -'

# copy output from terminal to clipboard
# e.g echo 1 | clip
alias clip='xclip -sel clip'

# syntax highlight output in terminal
# e.g cat program.c | cats
alias cats='highlight -O ansi --force --syntax c'

# use home dir as git repo
alias home='git --work-tree=$HOME --git-dir=$HOME/.home'

# convert file to webm
alias webm='ffmpeg -c:v vp8'

# alias for script language
alias gsc='~/git/gsc/bin/gsc'

# take screenshot and store it at /tmp/image
alias sst='scrot -o -s /tmp/image.png'

# displays neofetch with some information disabled
alias nf='neofetch --disable cpu gpu resolution term memory packages uptime wm'

# opens up notepad++ with wine incase it's installed (handy for opening files from terminal)
# it's quite slow, so using emacs instead now
alias notepad++='wine "C:/Program Files/Notepad++/notepad++.exe"'

# open emacs from within terminal to quickly edit file without blocking use [-n]
alias ec="emacsclient --create-frame"
# run emacs --daemon first
alias ed='emacsclient -c -n -a ""'
alias e='emacsclient --tty'

# reminder of how to dissassemble some instructions for quick reference
alias rasmtest='rasm2 -a x86 -b 32 "push esp"'

# comparing binary files with nice color view of what changed
#https://superuser.com/questions/125376/how-do-i-compare-binary-files-in-linux
alias hexdiffexample='colordiff -y <(xxd foo1.bin) <(xxd foo2.bin)'

# vm run reminders of how to quickly start a vm
#alias vm='qemu-system-x86_64 -hda HEAD.img -machine type=q35,accel=kvm -m 8192M -vga virtio &'
#alias spicevm='qemu-system-x86_64 -hda HEAD.img -machine type=q35,accel=kvm -m 8192M -smp 3 -enable-kvm \
#-vga qxl -device virtio-serial-pci -spice unix,addr=/tmp/vm_spice.socket,disable-ticketing -device \
#virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev \
#spicevmc,id=spicechannel0,name=vdagent -device virtio-mouse-pci -device virtio-keyboard-pci &'
#alias rdp='remote-viewer --title=Win10 --spice-disable-effects=all --spice-color-depth=32
#--spice-disable-audio spice+unix:///tmp/vm_spice.socket &'
