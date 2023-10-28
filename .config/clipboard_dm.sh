#!/bin/bash
# NOTE: This file is generated from ~/.config/README.org
#       Please only edit that file and org-babel-tangle (emacs)
# Define the clipboard directory, in the ram
clipboard_dir="/dev/shm/temp/clipboard"

# Create the directory if it doesn't exist
mkdir -p "$clipboard_dir"

notify-send -t 60000 "Clipboard management opened"

# Go to a RAM directory, is dit wel nodig:
cd /dev/shm

while true; do
    # Use dmenu to choose an action from a list
    selected_action=$(echo -e "1. Show Current Clipboard\n2. Show List of Saved Clipboards\n3. Save Current Clipboard to List\n4. Select Clipboard from List. This will become new clipboard\n5. Modify Clipboard from List in Emacs\n6. Modify Current Clipboard in Emacs and save as 00_temp_clipboard.txt\n7. Delete Single Entry from List\n8. Exit" | dmenu -c -bw 2 -l 40 -p "Clipboard options: ")

    # Check if Escape was pressed or dmenu was closed
    if [[ -z "$selected_action" ]]; then
        notify-send -t 60000 "Exiting clipboard menu"
        exit 0
    fi

    case "$selected_action" in
        "1. Show Current Clipboard")
            # Get the current clipboard content
            current_clipboard=$(xclip -o -selection clipboard)

            # Show the current clipboard content using dmenu
            echo -n "$current_clipboard" | dmenu -c -bw 2 -l 60 -p "Current Clipboard:"
            ;;

       "2. Show List of Saved Clipboards")
            # List saved clipboard files using dmenu and choose a file
            selected_file=$(ls "$clipboard_dir" | dmenu -c -bw 2 -l 30 -p "Choose a file to show:")

            notify-send -t 60000 "Viewing $selected_file"
            # Check if the selected file exists
            if [[ -f "$clipboard_dir/$selected_file" ]]; then
                # Read the content of the selected file
                clipboard_content=$(cat "$clipboard_dir/$selected_file")

                # Extract the number from the filename
                filename_number="${selected_file%%_*}"

                # Show the content in dmenu with the number
                echo -n "$clipboard_content" | dmenu -c -bw 2 -l 60 -p "Clipboard Content (File $filename_number):"
                notify-send -t 60000 "Back to clipboard menu"
            else
                notify-send "File Not Found" "The selected file does not exist."
            fi
            ;;

        "3. Save Current Clipboard to List")
            # Get the highest number used in existing filenames
            highest_number=0
            for file in "$clipboard_dir"/*; do
                if [[ -f "$file" ]]; then
                    filename=$(basename "$file")
                    number="${filename%%_*}"
                    if [[ $number =~ ^0*([1-9][0-9]*)$ ]]; then
                        current_number="${BASH_REMATCH[1]}"
                        if ((current_number > highest_number)); then
                            highest_number=$current_number
                        fi
                    fi
                fi
            done

            # Calculate the next filename number with two digits
            next_number=$(printf "%02d" $((highest_number + 1)))

            # Use dmenu to get additional text for the filename
            additional_text=$(echo "" | dmenu -c -bw 2 -p "Enter additional text for the filename (without spaces):")

            # Generate the filename
            filename="${next_number}_${additional_text}.txt"

            # Get clipboard content
            clipboard_content=$(xclip -o -selection clipboard)

            # Save clipboard content to a file
            echo "$clipboard_content" > "$clipboard_dir/$filename"

            # Display a notification
            notify-send "Clipboard Saved" "Clipboard content saved to $clipboard_dir/$filename"
            ;;

        "4. Select Clipboard from List. This will become new clipboard")
            # List saved clipboard files using dmenu and choose a file
            selected_file=$(ls "$clipboard_dir" | dmenu -c -bw 2 -l 30 -p "Choose a clipboard file to copy to clipboard:")

            # Check if the selected file exists
            if [[ -f "$clipboard_dir/$selected_file" ]]; then
                # Read the content of the selected file
                clipboard_content=$(cat "$clipboard_dir/$selected_file")

                # Copy the content to clipboard
                echo -n "$clipboard_content" | xclip -i -selection clipboard
                notify-send "Clipboard Content Copied" "Clipboard content from $selected_file copied to clipboard."
            else
                notify-send "File Not Found" "The selected file does not exist."
            fi
            ;;

        "5. Modify Clipboard from List in Emacs")
            # List saved clipboard files using dmenu and choose a file to edit
            selected_file=$(ls "$clipboard_dir" | dmenu -c -bw 2 -l 30 -p "Choose a file to edit:")

            # Check if the selected file exists
            if [[ -f "$clipboard_dir/$selected_file" ]]; then
                # Open the selected file in Emacs for editing in the background
                emacsclient -n "$clipboard_dir/$selected_file" &
                exit 0
            else
                notify-send "File Not Found" "The selected file does not exist."
            fi
            ;;

        "6. Modify Current Clipboard in Emacs and save as 00_temp_clipboard.txt")
            # Get the current clipboard content
            current_clipboard=$(xclip -o -selection clipboard)

            # Save the current clipboard content to a temporary file in the clipboard_dir
            temp_file="$clipboard_dir/00_temp_clipboard.txt"
            echo "$current_clipboard" > "$temp_file"

            # Open the temporary file in Emacs for editing
            emacsclient -n "$temp_file" &

            # Exit the script to close dmenu
            exit 0
            ;;

        "7. Delete Single Entry from List")
            # List saved clipboard files using dmenu and choose a file to delete
            selected_file=$(ls "$clipboard_dir" | dmenu -c -bw 2 -l 30 -p "Choose a file to delete:")

            # Check if the selected file exists
            if [[ -f "$clipboard_dir/$selected_file" ]]; then
                # Use dmenu to confirm deletion
                confirm_delete=$(echo -e "No\nYes" | dmenu -c -bw 2 -p "Are you sure you want to delete '$selected_file'?")

                if [[ "$confirm_delete" == "Yes" ]]; then
                    # Delete the selected clipboard file
                    rm "$clipboard_dir/$selected_file"
                    notify-send "Clipboard Entry Deleted" "Clipboard entry '$selected_file' has been deleted."
                else
                    notify-send "Deletion Canceled" "Clipboard entry '$selected_file' was not deleted."
                fi
            else
                notify-send "File Not Found" "The selected file does not exist."
            fi
            ;;

        "8. Exit")
            exit 0
            ;;
    esac
done
