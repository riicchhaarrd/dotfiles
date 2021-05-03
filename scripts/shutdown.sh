#!/bin/bash

if zenity --question --title="" --text "Are you sure you want to shutdown this computer?" --ok-label="Yes" --cancel-label="No"
then
	/sbin/poweroff
fi
