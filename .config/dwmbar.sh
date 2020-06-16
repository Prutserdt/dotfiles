#!/bin/sh
#~/.config/dwmbar.sh
#     _                    _                    _
#  __| |_      ___ __ ___ | |__   __ _ _ __ ___| |__
# / _` \ \ /\ / / '_ ` _ \| '_ \ / _` | '__/ __| '_ \
#| (_| |\ V  V /| | | | | | |_) | (_| | | _\__ \ | | |
# \__,_| \_/\_/ |_| |_| |_|_.__/ \__,_|_|(_)___/_| |_|
#                                 Created by Prutserdt
#
# Update dwm status bar every minute and give as output
# updatebar.sh
while true
do
/home/icefly/.config/updatebar.sh
  sleep 60
done
