#!/bin/sh

# Update dwm status bar every minute
while true
do
/home/icefly/.config/updatebar.sh
  sleep 60
done
