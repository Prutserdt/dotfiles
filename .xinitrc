#!/bin/sh
#
# ~/.xinitrc
#__  ___       _ _            
#\ \/ (_)_ __ (_) |_ _ __ ___ 
# \  /| | '_ \| | __| '__/ __|
# /  \| | | | | | |_| | | (__ 
#/_/\_\_|_| |_|_|\__|_|  \___|
# Modified by Prutserdt
### Executed by startx. Starts i3wm and write the log:
#
exec i3 -V >> ~/i3_log/i3log-$(date +'%F-%k-%M-%S') 2>&1
