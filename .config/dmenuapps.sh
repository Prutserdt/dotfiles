#!/bin/sh
#~/.config/dmenuapps.sh
#     _                                                        _
#  __| |_ __ ___   ___ _ __  _   _  __ _ _ __  _ __  ___   ___| |__
# / _` | '_ ` _ \ / _ \ '_ \| | | |/ _` | '_ \| '_ \/ __| / __| '_ \
#| (_| | | | | | |  __/ | | | |_| | (_| | |_) | |_) \__ \_\__ \ | | |
# \__,_|_| |_| |_|\___|_| |_|\__,_|\__,_| .__/| .__/|___(_)___/_| |_|
#                                       |_|   |_|
#                                                Created by Prutserdt
#
# Script to open applications (~/.cache/dmenu_run) by dmenu.
# It opens: ~/.cache/dmenu_run.
# This requires the dmenu patch: center, which gives the dmenu -c option.
cat ~/.cache/dmenu_run | dmenu -i -c -l 30 | ${SHELL:-"/bin/sh"}
