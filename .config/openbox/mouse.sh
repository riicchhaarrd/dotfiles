#!/bin/bash
mouse_id=$(xinput --list --id-only 'Kingsis Peripherals ZOWIE Gaming mouse')
xinput --set-prop $mouse_id 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop $mouse_id "libinput Accel Speed" $1

#xinput --set-prop 8 'libinput Accel Profile Enabled' 0, 1
#xinput --set-prop 8 "libinput Accel Speed" -0.35

#xinput --set-prop 8 libinput Accel Profile Enabled 1, 0
#xinput --set-prop 8 "libinput Accel Speed" -0.75
