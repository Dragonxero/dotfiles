#!/bin/bash

# set trayer for applet icons
trayer --edge top  --align right --SetDockType true --SetPartialStrut true \
--expand false --width 4 --transparent true --alpha 0 --tint 0x010D11 --height 13 &

# set keyboard layout
setxkbmap -layout si

# start composite manager
#xcompmgr -C &
compton -b --config ~/.config/compton.conf &

# merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# stlarch font
xset +fp /usr/share/fonts/local
xset fp rehash

# Uncomment the lines bellow for swm
#sxhkd -c ~/.config/sxhkd/sxhkdrc >/dev/null 2>&1 &
# start lemonbar
#./.statusbar
# set wallpaper
#feh --bg-tile ~/Pictures/wallpapers/bo_play_pattern.png
#hsetroot -full ~/Pictures/wallpapers/casette4.jpg

# set cursor
xsetroot -cursor_name left_ptr
#xsetroot -cursor_name Breeze_Hacked

# Here i3 is kept as default
# For this to work you need to
#cp /etc/X11/xinit/xserverrc ~/.xserverrc
session=${1:-i3}
case $session in
    i3|i3wm           ) exec i3;;
    swm               ) exec swm;;
    xmonad            ) exec xmonad;;
    enlightenment     ) exec enlightenment_start;;
    *) exec $1;;
esac
