#! /bin/bash

PRIMARY="eDP1"
EXT2="VGA1"
EXT1="HDMI1"

if ((xrandr | grep "$EXT1 connected") && (xrandr | grep "$EXT2 connected")); then
	#xrandr --output $PRIMARY --off
	xrandr --output $EXT1 --primary --auto --output $EXT2 --auto --right-of $EXT1 --output $PRIMARY --auto --left-of $EXT1
	#xrandr --output $EXT1 --primary --auto --output $EXT2 --mode 1920x1080 --right-of $EXT1 --output $PRIMARY --auto --left-of $EXT1
  echo "EXT1 & EXT2 enabled"
elif (xrandr | grep "$EXT2 disconnected" && xrandr | grep "$EXT1 connected"); then
	xrandr --output $EXT2 --off
	xrandr --output $EXT1 --primary --auto --output $PRIMARY --auto --left-of $EXT1
	echo "$EXT1 & $PRIMARY enabled"
elif (xrandr | grep "$EXT1 disconnected" && xrandr | grep "$EXT2 connected"); then
	xrandr --output $EXT1 --off
	xrandr --output $EXT2 --primary --auto --output $PRIMARY --auto --left-of $EXT2
	echo "$EXT2 && $PRIMARY enabled"
else
	xrandr --output $EXT1 --off
	xrandr --output $EXT2 --off
	xrandr --output $PRIMARY --primary --auto
	echo "$PRIMARY enabled"
fi
