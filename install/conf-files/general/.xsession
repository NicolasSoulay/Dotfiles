#!/bin/sh

[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

nitrogen --restore &
nm-applet &
blueman-applet &

exec awesome
