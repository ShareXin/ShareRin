#!/bin/sh

# pictures directory
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"

# date and time for naming
date=$(date +%Y-%m-%d)
time=$(date +%T)

# box selection
eval $(slop --opengl)

# launches ffmpeg and python script
xfce4-terminal -e "ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse /tmp/sharexin_gif.gif"

# launches ruby script
ruby ./Gif.rb

# copies gif to permanent location
sleep 5 && cp /tmp/sharexin_gif.gif "${XDG_PICTURES_DIR}/ShareXin/twitter-$date-$time.gif"

# makes notification
notify-send "Sent" \
"To Twitter" -i /tmp/sharexin_gif.gif -t 2500
