#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)

# Use dmenu to select the directory containing your images
selected_directory=$(find "$HOME/Stack/Afbeeldingen/Vakantie" -maxdepth 2 -type d | dmenu -c -bw 2 -l 40 -p "Select a directory for pictures to select in google maps:")

# Check if a directory was selected
if [ -n "$selected_directory" ]; then
    while true; do
        # Give the user information how to select the image in nsxiv
        zenity --question --title="Reminder" --text="Please select a single picture in nsxiv by pressing 'm' or exit by pressing 'q'.\n\nDo you want to continue?"

        # Check the user's response to the question dialog
        response=$?

        if [ $response -eq 1 ]; then
            # User clicked "No," exit the loop
            break
        fi

        # Use find to locate image files in the selected directory
        image_files=$(find "$selected_directory" -maxdepth 1 -type f \( -iname '*.jpeg' -o -iname '*.jpg' \) | sort)

        # Use nsxiv to display the images in the selected directory and allow you to choose one
        selected_image=$(echo "$image_files" | nsxiv -ftio)

        # Check if an image was selected
        if [ -n "$selected_image" ]; then
            # Run exiftool and get the GPS Position
            exif_info=$(exiftool "$selected_image" | grep "GPS Position")

            if [ -n "$exif_info" ]; then
                # Extract and process the GPS Position to the format for google maps.
                # First select data at the right after the : sign.', then remove all spaces
                # and change 'deg' to °.
                gps_position=$(echo "$exif_info" | awk -F ': ' '{print $2}' | tr -d ' ' | sed 's/deg/°/g')

                maps_url="https://www.google.com/maps/place/$gps_position"

                # Open the URL in the default web browser
                xdg-open "$maps_url"

                notify-send -t 60000 "Google maps opened with GPS location: $gps_position"
            else
                # No GPS information found
                zenity --info --title="No GPS Information" --text="The selected picture does not contain GPS information."
            fi
        else
            # No image selected, exit the loop
            break
        fi
    done
fi
