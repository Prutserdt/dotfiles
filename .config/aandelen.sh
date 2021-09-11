#!/bin/sh
#~/.config/aandelen.sh
#                       _      _                  _
#  __ _  __ _ _ __   __| | ___| | ___ _ __    ___| |__
# / _` |/ _` | '_ \ / _` |/ _ \ |/ _ \ '_ \  / __| '_ \
#| (_| | (_| | | | | (_| |  __/ |  __/ | | |_\__ \ | | |
# \__,_|\__,_|_| |_|\__,_|\___|_|\___|_| |_(_)___/_| |_|
#
# Automating some routines :-)
# Opens up a mark down file and places data to clipboard.
# This clipboard data consists of my current stock portfolio, which is taken 
# from ~/Downloads/Portfolio.csv, which is sorted by stock size, then the
# percentage is calculated and some other stuff.
#
# Open markdown file in the terminal
alacritty -e vim $HOME/Stack/Documenten/Aandelen/aandelen_log.md & 
# make directory in ram memory of user
# df -T # to see the ram memory usage
mkdir $XDG_RUNTIME_DIR/temp &
# Fetch data from the .csv: two columns, stock name and size and sorth them by
# size and write to TempSorted
cat $HOME/Downloads/Portfolio.csv | sed "1,2 d" | cut -d , -f 1,7 | sed 's/"//'| sort -r -t ',' --key=6 > $XDG_RUNTIME_DIR/temp/TempSorted &&
# Take only the size of stocks and calculate percentage and add this in brackets to a temp file
cat $XDG_RUNTIME_DIR/temp/TempSorted | cut -d , -f 2 | awk '{a[NR] = $1; sum+= $1 } END {for (i = 1; i <= NR; i++) printf "%s %1.1f %\n", a[i],(100 * a[i])/sum}' > $XDG_RUNTIME_DIR/temp/TempPerc &&
# Write only the stockname to temp file
cat $XDG_RUNTIME_DIR/temp/TempSorted | cut -d , -f 1  > $XDG_RUNTIME_DIR/temp/TempName && 
# Combine TempPerc and TempName
paste $XDG_RUNTIME_DIR/temp/TempPerc $XDG_RUNTIME_DIR/temp/TempName > $XDG_RUNTIME_DIR/temp/TempMerged &&
# Add a line for markdown formatting
echo '================================================================================' > $XDG_RUNTIME_DIR/temp/TempLine1 &&
# Fetch the date of the portfolio.csv file and write to TempDate
date +%d%h%y -r $HOME/Downloads/Portfolio.csv >> $XDG_RUNTIME_DIR/temp/TempDate && # find date of .csv file and write to temp file
# Write text to TempLine2a
echo ', portfolio:' > $XDG_RUNTIME_DIR/temp/TempLine2a &&
# Calculate the sum of all stocks and write in TempTotal
cat $XDG_RUNTIME_DIR/temp/TempPerc | cut -d , -f 1 | awk '{n += $1}; END{print n}' > $XDG_RUNTIME_DIR/temp/TempTotal &&
# Again some text is written, this time to TempLine2b
echo 'euro, winst:  euro.' > $XDG_RUNTIME_DIR/temp/TempLine2b &&
# Text of three temp files are combined in one single line: TempLine2New
paste $XDG_RUNTIME_DIR/temp/TempDate $XDG_RUNTIME_DIR/temp/TempLine2a $XDG_RUNTIME_DIR/temp/TempTotal $XDG_RUNTIME_DIR/temp/TempLine2b > $XDG_RUNTIME_DIR/temp/TempLine2New &&
# Text of four temp files are combined to the final temp file: TempNieuw
cat $XDG_RUNTIME_DIR/temp/TempLine1 $XDG_RUNTIME_DIR/temp/TempLine2New $XDG_RUNTIME_DIR/temp/TempLine1 $XDG_RUNTIME_DIR/temp/TempMerged > $XDG_RUNTIME_DIR/temp/TempNieuw &&
# Placing the TempNieuw data in the clipboard memory
cat $XDG_RUNTIME_DIR/temp/TempNieuw | xclip -sel clip &&
# Remove the created temp files
rm $XDG_RUNTIME_DIR/temp/Temp*
