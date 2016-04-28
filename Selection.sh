#!/bin/sh

# pictures directory
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"

# take a screenshot using maim while pausing the screen
maim /tmp/sharexin_selection.png && eom -f /tmp/sharexin_selection.png & maim -s /tmp/sharexin_img.png --opengl && killall eom

# date and time for naming
date=$(date +%Y-%m-%d)
time=$(date +%T)

# copies to permanent location
cp /tmp/sharexin_img.png $XDG_PICTURES_DIR/ShareXin/twitter_clip-$date-$time.png

# launches ruby script
ruby ./Picture.rb

# cleans up
killall eom

# makes notification
notify-send "Sent" \
"To Twitter" -i /tmp/sharexin_img.png -t 2500
