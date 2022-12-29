#!/bin/bash
echo -n "Do you wish to exit qtile right now? (y/n) "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
   killall qtile
else
    echo No
fi
