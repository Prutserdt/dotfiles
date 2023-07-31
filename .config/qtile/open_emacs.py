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

    # Send a message to Emacs with the filename
    subprocess.run(["emacsclient", "-e", f'(message "Emacs opened file {FILENAME}")'])

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    FILENAME = sys.argv[1]
    open_file_with_emacs(FILENAME)
