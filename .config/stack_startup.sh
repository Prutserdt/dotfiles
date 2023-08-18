#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
dir="$HOME/Applications" # directory
appimage=$(find "$dir" -name "*stack*.AppImage" -print -quit)

if [ -n "$appimage" ]; then
    notify-send -t 6000 "Starting the Stack .AppImage..." && #send notification
    "$appimage"  # Execute the file
else
    notify-send -t 6000 "No .AppImage file containing 'stack' in its name was found in $dir"
fi
#!/bin/sh
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
dir="$HOME/Applications" # directory
appimage=$(find "$dir" -name "*stack*.AppImage" -print -quit)

if [ -n "$appimage" ]; then
    notify-send -t 6000 "Starting the Stack .AppImage..." && #send notification
    "$appimage"  # Execute the file
else
    notify-send -t 6000 "No .AppImage file containing 'stack' in its name was found in $dir"
fi
