#!/bin/bash

# periodically takes screenshot and saves them to desktopscr/
# the filename contains unix time

# wait time in seconds
waittime="60"
# directory to save screenshots to
saveprefix="/home/cuky/Devel/ulogme/desktopscr/scr"
mkdir -p saveprefix

#------------------------------

while true
do
	islocked=true; if [[ $(gnome-screensaver-command -q) =~ .*not running!* ]]; then islocked=false; fi

	if ! $islocked
	then
		# take screenshot into file
		T="$(date +%s)"
		fname="$saveprefix_$T.jpg"
		# q is quality. Higher is higher quality
		scrot -q 50 "$fname"
		echo "screen shot taken..."
	else
		echo "screen is locked, waiting..."
	fi

	sleep $waittime
done


