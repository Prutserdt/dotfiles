#!/bin/sh
#cat ~/.cache/dmenu_run | dmenu -i -c -l 65 | ${SHELL:-"/bin/sh"}
# -a 50 moet 50% doorzichtigheid geven....
cat ~/.cache/dmenu_run | dmenu -i -c -l 65 | ${SHELL:-"/bin/sh"}
