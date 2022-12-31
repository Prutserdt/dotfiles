#!/bin/sh
cat ~/.cache/dmenu_run | dmenu -i -c -l 65 | ${SHELL:-"/bin/sh"}
