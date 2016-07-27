#!/bin/bash

# set keyboard layout
setxkbmap -layout si

# merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# MPD daemon start
[ ! -s ~/.config/mpd/pid ] && mpd

# set cursor
xsetroot -cursor_name left_ptr

# stlarch fonts
xset +fp /usr/share/fonts/local
xset fp rehash

# start compton
compton -b --config ~/.config/compton.conf &

# start dunst
dunst &

# set wallpaper
feh --bg-scale ~/Pictures/wallpapers/btemple.png
udiskie --tray &

sxhkd &
urxvt &
exec bspwm
