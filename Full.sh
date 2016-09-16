#!/bin/sh

# sets pictures directory
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"

# take a screenshot using gnome-screenshot
gnome-screenshot -f /tmp/sharexin_img.png

# launches ruby script
ruby ./Picture.rb

# date and time for naming
date=$(date +%Y-%m-%d)
time=$(date +%T)

# copies tmo file to permanent location
cp /tmp/sharexin_img.png $XDG_PICTURES_DIR/ShareXin/twitter-$date-$time.png

# makes notification
notify-send "Sent" \
"To Twitter" -i /tmp/sharexin_img.png -t 2500
