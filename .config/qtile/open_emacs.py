# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)

#!/usr/bin/env python3
import subprocess
import sys

def is_emacsclient_running():
    try:
        subprocess.check_output(["pgrep", "-f", "emacsclient -c -a emacs*"])
        return True
    except subprocess.CalledProcessError:
        return False

def open_file_with_emacs(FILENAME):
    if is_emacsclient_running():
        subprocess.run(["emacsclient", "-n", FILENAME])
    else:
        subprocess.run(["emacsclient", "-c", "-a", "emacs", FILENAME])
    # Send a message to Emacs and notify-send what was done
    subprocess.run(["emacsclient", "-e", f'(message "Emacs opened {FILENAME}")'])
    subprocess.run(["notify-send", f"Opening of '{FILENAME}' in Emacs"])

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    FILENAME = sys.argv[1]
    open_file_with_emacs(FILENAME)
