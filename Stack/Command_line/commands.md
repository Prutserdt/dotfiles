 /!Modified by Prutserdt, ~/Stack/Command_line/commands.md>
          _     _                    _        _      _        
         | |   (_)_ __  _   ___  __ | |_ _ __(_) ___| | _____ 
         | |   | | '_ \| | | \ \/ / | __| '__| |/ __| |/ / __|
         | |___| | | | | |_| |>  <  | |_| |  | | (__|   <\__ \
         |_____|_|_| |_|\__,_/_/\_\  \__|_|  |_|\___|_|\_\___/
---
## Content
#### Command line tricks
* Allerlei
* Rechten bestanden
* Grafische problemen
* Logging
* Wissen van regels in meerdere bestanden die een bepaald woord bevatten.
* Linux keyboard shortcuts
* Batch rename image files
* PACMAN/YAOURT/YAY
* WIFI
* VNC (controle van desktop van buitenaf, oa android phone)
* Manipuleren van GE UNICORN files
* Bluetooth instellen
* VPN
* Corona script
* Video card information
* Create superfast ramdisk
* C programming tricks
* Allerlei
#### Applications (Command line and GUIs)
* Vim
* Nano
* Octave
* Git (en dotfiles procedure)
* Tox
* SXIV
* Neomutt
* Steam
* Stack (transip)
* Copy pictures of mac to linux
* VPN
* Virtualbox and Whonix
#### Distros
* XFCE tricks
* i3 window manager
* Install SSD Arch install
* Install on persistent USB
* Ubuntu: 16.10 server en networking
* Ubuntu: Mate op GPD pocket
* Arch linux op GPD pocket
* Kali linux op GPD pocket
* Parrot linux op GPD pocket
#### Keebs
* Ducky one mechanical keyboard.
* Vortex 90M mechanical keyboard
* Gergo mechanical ortholinear keyboard
#### dwm
#### st
---
### Command line tricks
#### Allerlei

**Problemen met legen van trash in KDE.**
Open a terminal and go to ~/.local/share and type:
`rm -r -f Trash`. This will remove the Trash directory and everything in it.
Open Dolphin go to *Settings>Configure Dolphin>Trash*.
De-select and Re-select the "Limit to maximum size" check box and press 
Apply.  This will re-create a new trash can. 

**Checksum.** Voor het vinden, checken en vergelijken van sha256 van een iso
file. Bijvoorbeeld: md5, sha-1 of sh256. Dit doe je met: `md5sum`, `sha1sum` en
`sha256sum`.

kali-linux-rolling-pocket+20180207-1_oud.iso

Which command. Vind locatie van applicatie.
which firefox

**cat** command. Laat txt files zien: `cat /etc/fstab`

**less** command. Laat groot bestand zien in emulator, met pijltjes kun je 
erdoor lopen.
less longfile.txt
cat /etc/fstab |less

Vind router adres, bijv 1923169.2.245, router adres, internet:
ip link show

**more** command. Een ander manier om grote files te laten zien

more longfile.txt
cat longfile.txt | more

Op systemen waar **root user disabled** is, bijv. Ubuntu. Dan kun je 
toch inloggen door gebruik te maken van: `sudo -s`.

**Start gnome** programma (wireshark, gparted, unetbootin); `gksu gparted WIFI`

**Switch user**. Ga naar juiste home directory: `su username`.

Vindt alle **system users**: `compgen -u`.

Herstart het systeem: `sudo reboot`.

Midnight Commander als super user gebruiken, bijvoorbeeld voor het 
wegschrijven op de 1 Terabyte drive: `su` en daarna `mc`.

Vind de **beeldscherm resolution**: `xdpyinfo | grep dimensions`

Open applicatie in command line en ga daarna door met command line, dat gaat
via '&'. Zie als voorbeeld:
/home/icefly/Downloads ; ./stack-2.6.5-20200909-x86_64.AppImage &

Afsluiten systeem, direct:`sudo shutdown -h now`
Afsluiten systeem over 15 minuten:`sudo shutdown -h 15`
Stel je wilt toch afsluiten terwijl je de afsluit timer hebt gezet: `sudo shutdown -c`

**bleachbit**. Schoonmaken van het systeem. Je kunt kiezen welke files van 
welke apps je  wilt wissen: `bleachbit`

Probleem: te weinig capaciteit tmp dir, en virtueel geheugen. Check verdeling van geheugen:`df -H`

Vergroten tmp directory: sudo mount -t tmpfs tmpfs /tmp -o size=2000M,mode=1777,remount

Bekijk routers naar adres met: mtr: `mtr --report-wide --curses www.google.com`

geeft usb devices weer
lsusb

History bashrc. Dit staat in ~/.bash_history. Verwijder duplicates met het
volgende commando:

sort .bash_history | uniq > .bash_history_shortened

Voeg het volgende toe aan .bashrc om een grotere en meer cleane history file te
krijgen:
```
# Change the size of the bash history to 5000 in memory (500 is default) 
# and the total amount of maximally saved lines
HISTSIZE=5000
HISTFILESIZE=10000
# Do not add duplicate entries and no spaces; erase duplicates
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
```

#### Weergave hard drive, formatting, dd, etc
```
sudo fdisk -l
sudo parted -l
lsblk
```

Clonen van harde schijf naar andere partitie: `sudo dd if=/dev/sda1 of=/dev/sda5 bs=4096 conv=notrunc,noerror`. 
Maak een backup/clone in twee stappen (is veiliger dan direct).
bijvoorbeeld een usb stick. Door status=progres zie je wat er gebeurd:
`sudo dd if=/dev/sdd of=Backup_USBstick_arch_30DEC18.img status=progress`

Daarna "brand" je de image naar een usb stick met:
```
sudo dd if=Backup_USBstick_arch_20JUL17.img of=/dev/sdd status=progress
sudo dd if=//home/archie/Downloads/clonezilla-live-20170626-zesty-amd64.iso of=/dev/sdd status=progress
sudo dd if=//home/archie/Downloads/linuxmint-18.2-xfce-64bit.iso of=/dev/sdd status=progress
sudo dd if=/dev/sdd of=Backup_USBstick_arch_21AUG19.img status=progress
```

#### Memory stick niet zichtbaar met lsblk
Achterhaal eerst met lsusb voor en na het inpluggen van de stick welk ID het
heeft, bijvoorbeeld:
'Bus 001 Device 016: ID 058f:6387 Alcor Micro Corp. Flash Drive'
Zoek met dmesg naar meer informatie (058f:6387 zoeken):
'dmesg | less | fzf'
De output is bijvoorbeeld:
'[2664293.306101] usb 1-1.1: New USB device found, idVendor=058f, idProduct=6387, bcdDevice= 1.01'

Alternatief voor lsusb:
'sudo fdisk -l'
'usb-devices'
Output voorbeeld van 'usb-devices':

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#= 17 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=058f ProdID=6387 Rev=01.01
S:  Manufacturer=Generic
S:  Product=Mass Storage
S:  SerialNumber=4D55D1EC
C:  #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#=0x0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)

Ander alternatief voor meer info:
'sudo blkid'
Output daarvan (gedeelte):
'1Bus 001 Device 016: ID 058f:6387 Alcor Micro Corp. Flash Drive'
'sudo fdisk -l'

#### Multiple linux distros on one USB:
Hiermee kun je meerdere USB  distros op een enkele pendrive zetten. :-)
```
yay multibootusb-git
sudo multibootusb
```
Het lukt me niet in i3 om multibootusb te gebruiken (ook niet met gksu, niet
als super user).


Overschrijf hard disk door random data:`dd if=/dev/urandom of=/dev/sdb status=progress`

Vind de naam van harddrives UUID door: `sudo blkid`

dvd: `/dev/sr0`

Formatteren sdb vanuit commandline met cfdisk: `sudo cfdisk /dev/sdb`

Mount partitie:` sudo mount /dev/sda5 /media/data`

Maak een directory: `sudo mkdir /media/data`

cpu information: `lscpu`

`sudo mount /dev/sda2 /mnt`

Maak iso van cd/DVD. Het is niet perse nodig om de size te bepalen, want ook een te 
grote iso werkt gewoon.
Eerst de size van iso file system bepalen met isosize (util-linux), telt aantal blocks
vast:
blocks=$(isosize -d 2048 /dev/sr0)
Voor de grap: kijken hoe groot het bestand is dmv berekenen aantal blocks gedeeld door 
512.

Schrijf de iso weg:
```
echo "That would be $(expr $blocks / 512) MB"
dd if=/dev/sr0 of=isoimage.iso bs=2048 count=$blocks  status=progress
```

Eenvoudiger (externe harde schijf iso)
```
sudo dd if=/dev/sdc of=MacCindy.iso status=progress
```

alternatief formateren (fat32)
```
dmesg | tail
sudo umount /dev/sdb
sudo mkdosfs -F 32 -n 'Label' -I /dev/sdb
```

Mount iso bestand: 
```
sudo mkdir /mnt/iso
sudo mount -o loop /home/archie/akta_docs.iso /mnt/iso
```


Nieuw bestand aanmaken in commandline, inclusief inhoud: `echo dhcpcd > /home/icefly/info`.
Nieuw welkom scherm voor terminal toevoegen aan bashrc: `nano ~/.bashrc`.
Voeg de volgende twee lijnen toe: 

Welkomstekst nieuwe terminal:

echo "Welcome back commander"

Geeft arch logo in asci art plus wat extra info: `screenfetch`. Je kunt ook
neofetch gebruiken. Beide opties zijn bloat. Daarom is pfetch beter. Meer
minimalistich. Deze heb ik ingesteld in mijn .bashrc.


Welkom tekst voor login venster instellen in: `sudo nano etc/issue`
Voeg toe:
```
|--------------------------|
|  Welcome Back Commander  |
|--------------------------|
|    User      : icefly    |
|                          |
|     Modify .xinitrc      |
|     to choose window     |
|     manager and run      |
|     startx               |
|--------------------------|
Arch Linux \r (\l)
```

Roteren van het scherm (0,1,2,3 zijn de richtingen, of left/right/normal)
```
xrandr -o 1
xrandr -o right
```

Zoeken connected displays
```
xrandr --query
```

Specifieke setup op werk, twee monitoren, breedbeeld in A4 en extra beeldscherm,
gecorrigeerd voor hoogte
```
xrandr --output VGA-1 --mode 1280x1024 --pos 1050x195 --output DP-1 --mode 1680x1050 --rotate left --pos 0x0
```

Jan 12 22:23:32 archPC kernel: [Firmware Bug]: TSC_DEADLINE disabled due to Errata; 
please update microcode to version: 0x22 (or later). Opgelost door een
intel-ucode installatie en aanpassing aan syslinux:
`yaourt -S intel-ucode`
onderstaande INITRD aangepast in /boot/syslinux/syslinux.cfg:
```
LABEL arch
MENU LABEL Arch Linux
LINUX ../vmlinuz-linux
INITRD ../intel-ucode.img,../initramfs-linux.img
APPEND root=/dev/sda1 rw
INITRD ../initramfs-linux.img
```

Firefox customization: verander skins per website met Stylish.

Change system time: `timedatectl set-time "2017-01-06 22:27:49"`.

Check time: `sudo hwclock --debug`.

Probleem gehad met een uur tijdsverschil, opgelost met: `timedatectl set-ntp true`.

View all the groups: `cat /etc/group`.
Bekijken groups van enkele user: `groups icefly`.

add group (audio) to user (icefly): `sudo gpasswd -a icefly audio`.

Check running programs/close programs.
See processes: `ps waux`
Find PID of program:
```
pidof firefox
ps aux | grep  firefox

```
*(tweede kolom is PID, je kunt trouwens zoeken met wildcards)*
```
sudo kill -9 <ur process id> 
sudo killall firefox
```

MD5: `md5sum file.txt`.

Video fragment cutting. T: begin in seconden. D: lengte van clip in sec:
```
ffmpeg -i input -ss T -t D -c copy -fflags +genpts output
ffmpeg -i Film.mp4 -ss 309 -t 105 -c copy -fflags +genpts Filmpje.mp4
```

Frame by frame (Duurt wel langer. Als het bovenstaande niet goed werkt.):
```
ffmpeg -i Film.mp4 -ss 308 -t 111 -fflags +genpts Filmpje.mp4
```

Vind de code van keys van keyboard (toetsenbord): `xev`.
   
Zet de key repeat snelheid hoger, increase key repeat rate,
modify .xinitrc:
xset r rate 300 80

#### Converteren van pdf naar een tekstfile en verwijderen van bagger en
veranderen van komma naar punt. 
Vier stappen: 
1: Via command line utililty poppler (pdftotext)
2: maak subdir, verplaats txt files en ga naar subdir
3: Alleen de regels 'br' (afkorting voor bar) wegschrijven.
4: Verwijder overtollige spaties (meer dan 1)
5: Verander komma's naar punten
```
for file in *.pdf; do pdftotext -layout "$file"; done
mkdir test && mv *.txt test && cd test
for file in *; do grep br "$file" > "$file"_tmp && mv "$file"_tmp "$file"; done
for file in *; do cat "$file"| tr -s ' ' > "$file"_tmp && mv "$file"_tmp "$file"; done
for file in *; do sed 's/,/./g' "$file" > "$file"_tmp && mv "$file"_tmp "$file"; done
```
sed 's/,/./g' '

#### Calender
Show Calender this month:
cal 
Show Calender whole year:
cal -y
Show Calender year:
cal 1999

#### Rechten bestanden

Bekijk rechten: `ls -l` `ls -a -l` `ls -al` `ls la`
Bekijk hidden directories
`ls -a`
Uitleg output:
r: read, w: file can be modified, x: file can be executed, s:setUID bit, t: sticky
voorbeeld:
-rw-r--r-- 1 root   root    426 Feb 13 14:21 info
- : een file, want directory geeft de letter: d
rw: owners permission: read and write
r: groups permission: read
r: all the other users
root: gebruiker
root: groep

Verander rechten directory naar:
```
chmod u=rwx filename
chmod go=rx filename
chmod 755 Afbeeldingen
chmod 755 test.py nu is het executable
```

Verander ownership file met chown: `chown archie filename`.
Bulk verander rechten, incl. subdirectories :-):
```
find Afbeeldingen -type d -exec chmod 755 {} +
```

Aanmaken directory voor meerdere users (in dit geval, DATA in /home):
```
sudo groupadd project
sudo usermod -a -G project icefly
sudo usermod -a -G project werk
sudo chgrp -R project /home/DATA/
sudo chmod -R 2775 /home/DATA/
```

Veranderen van rechten, van root root naar icefly users.
(username groupname)
chown icefly:users *.*


**Grafische problemen**

Check grafische kaart, video card
```
lspci
lspci -v
lspci -v | less
lspci | grep -i --color 'vga'
lshw -class display
find /dev -group video
glxinfo | grep -i vendor
egrep -i " connected|card detect|primary dev|Setting driver"
/var/log/Xorg.0.log
/var/log/Xorg.0.log
/etc/X11/xorg.conf
```

Find motherboard information:
sudo dmidecode -t 2

Mijn AOC beeldscherm werkt niet met mijn LInux pc
Er zit wel een hdmi connector op maar deze werk toch niet.
Mijn monitor:           AOC CU34G2/BK
Mijn grafische kaart:   [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 / Radeon 520 OEM]
Mijn moederbord:        
	Manufacturer: LENOVO
	Product Name: SHARKBAY
	Version: 31900058 STD or WIN
	Serial Number: ES13354825
	Chassis Handle: 0x0003

#### Logging
journalctl
Zoeken in tijd
```
journalctl -b  #current boot
journalctl --since "2017-02-11 17:00:00"
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since yesterday
journalctl --since 09:00 --until "1 hour ago"
```

Zoeken op unit
```
journalctl -u nginx.service
journalctl -u nginx.service --since today
journalctl -u nginx.service -u php-fpm.service --since today
```
Zoeken op process, users, groupID
```
journalctl _PID=8088
journalctl _UID=33 --since today
```


Kernel messages
```
journalctl -k #from the current boot
journalctl -k -b -5 #messages from 5 boots ago
```
Zoeken naar fouten -p=sort by priority
```
journalctl -p err -b #Gives all error, critical, alert, or emergency. 
```

Log live volgen:
```
journalctl -f
```

Grootte log:
```
journalctl --disk-usage
```

De command line history staat hier: `/home/icefly/.bash_history`.
Zoeken in de history naar bijv. ssh gaat alsvolgt (zie ook fzf en aliases .bashrc):
```
ctrl R
history | grep ssh
cat
```


Maak text bestand aan, daarna typ je text en sluit je met CTR+z om te saven:
`cat > text.txt`.

Zoeken in i3_log directory onderstaande werkt niet....!!!! nog optimaliseren
Wat ik wil: selecteer meest recente log en gooi deze in fzf
exec "urxvt +sb -e find  ~/i3_log/ -type f -mmin -10 -exec tail -f {} +"
~/i3_log | fzf

ls -Art | tail -n 1
dit geeft de meest recente file
onderstaande werkt niet
ls -Art ~/i3_log | tail -n 1|fzf

dit wil ik:
 cat ~/i3_log/i3log-2020-01-12-22-14-41|fzf 
maar dan dynamisch door te zoeken met
ls -Art | tail -n 1
iets als dit, maar dan werkend:
cat ~/i3_log/{ls -Art ~/i3_log | tail -n 1}|fzf


#### Wissen van regels in meerdere bestanden die een bepaald woord bevatten.

Je kunt natuurlijk handmatig zoeken met fuzzyfind (bijv "wismij"):
cat i3log-2020-02-16-22-09-48 |fzf
Voorbeeld van het verwijderen van een single file:
grep -v "wismij" i3log-2020-02-16-22-09-48 > i3log_tmp ; mv i3log_tmp i3log-2020-02-16-22-09-48
Voorbeeld van verwijderen van regels van alle bestanden i3log* in directory
for thefile in i3log* ; do grep -v "wismij" $thefile > $thefile.$$.tmp; mv $thefile.$$.tmp $thefile; done

Bovenstaande commando werkt niet voor de eerste negen uren van de dag dat het
logfile is aangemaaakt, want dan komt er een spatie in de naam en  volgt er een
"ambiguous redirect" foutmelding. Dit is handmatig te herstellen in vifm: ga
naar de directory en hernoem deze files met cw.


#### Linux keyboard shortcuts
Lijstje met allerlei keyboard shortcuts.
```
Grafische omgeving shortcuts:
F10				Shows menubar/Switch to menubar
Ctrl Fx (F1-F9)			Switch naar desktop x
Ctrl Alt left/right cursor	Switch workspaces
Ctrl Alt Backspace		Log uit X en terug naar login scherm
Ctrl Alt Delete			Reboot
Ctrl Alt D			Toggles "show desktop"
Ctrl Alt Fx (F1-F9)		Switch naar virtual terminal. Goed voor debugging als je X niet wilt afsluiten (Ctrl Alt Delete). Default terminal is 6.
Alt				Opent het menu bovenin de applicatie
Alt F1				Opent het application menu (niet als Win is ingesteld)
Alt F2				Zoek een applicatie
Alt F3				Zoek een applicatie (uitgebreid)
Alt F4				Closes window
Alt F5				Returns window to "normal" or previous size
Alt F7				Move the window
Alt F8				Resize the window
Alt F9				Minimizes current window
Alt F10				Maximizes current window
Alt Tab				Cycle through open windows
Alt Space			Brings up window menu with with 'Always on Top' and 'Minimise' and 'Maximise' etc. 
Ctrl c				Copy
Ctrl v				Paste
Ctrl f				Search
Ctrl x				Cut the selected 
Ctrl a				Select all text
Ctrl b				Make the selected text bold
Ctrl i				Make the selected text italic
Ctrl u				Underline the selected text
Ctrl n				Open a new document or window
Ctrl s				Save the current document
Ctrl o				Open another document
Ctrl p				Print the current document
Ctrl z				Undo the last change you made
Ctrl Shift Z        Redo a change that you just undid 

Terminal shortcuts:
Ctrl a				Ga na begin van de line (in bijv. Nano)
Ctrl e				Ga na het einde van de line (in bijv. Nano)
Ctrl c				Kill process in terminal
Ctrl z				Zombie an application in a terminal, dit geeft de terminal terug en de applicatie is niet afgesloten. Het proces komt terug door het typen van "fg".
Ctrl r				Zoek in de command line. Type een woord dat je zoekt.

Firefox shortcuts
Ctrl                uOpen a new tab
Ctrl Tab            Rotate through each tab
Ctrl Shift          TabRotate backwards through each tab
Alt Left            Page Back
Alt right           Page Forward
Ctrl b				Show a list of your bookis
Ctrl h				Show your browsing history
Ctrl k				Enter a new web search in the search bar
Ctrl y				Show a list of downloaded files
Ctrl r				Reload the current page 
Ctrl p				Open a private window
F11				Display the current page full-screen
Esc				Stop loading the current page
```

#### Batch rename image files

Imagemagick, simpel verkleinen, comprimeren en renamen van files in directory.
resize: pixel size, quality: compression, en daarachter naamverandering
```
for f in *.JPG
  do
  echo "Converting $f."
  convert "$f" -resize 3000x2000 -quality 60% "${f/.JPG/-resized.JPG}"
done
```
-------
Batch rename. Verander de naam van bestanden. Zet eerst de foto's in 
directories met nummer van dag v.d. vakantie en locatie. Ga in de main 
directory. Dit scriptje VERPLAATST alleen bestanden uit de directory naar
de main directory met als begin de naam van de directory waar het in stond
```
start=$PWD
for directory in *; do
  cd "$directory"
  for filename in *; do
mv "$filename" ../"$directory$filename"
  done
  cd "$start"
done
```
In command line:
```
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do mv "$filename" ../"$directory $filename"; done; cd "$start"; done
```

Batch rename. Verander de naam van bestanden. Zet foto's in directories met nummer van 
dag v.d. vakantie en locatie. Ga in de main directory. Dit scriptje KOPIEERT alle 
bestanden uit de directory naar de main directory met als begin de naam van de 
directory waar het in stond.
PWD = print working directory
```
start=$PWD
for directory in *; do
  cd "$directory"
  for filename in *; do
    cp "$filename" ../"$directory$filename"
  done
  cd "$start"
done
```

In command line:
```
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do cp "$filename" ../"$directory $filename"; done; cd "$start"; done
```

rename all files in all directories....
```
start=$PWD
for directory in *; do
  cd "$directory"
  for filename in *; do
 for i in $(ls *.*); do exiv2 -r '%Y%m%d-%H%M-:basename:' rename $i; done
  done
  cd "$start"
done
```

In command line:
```
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do exiv2 -r'%Y%m%d_%H%M_:basename:' rename $(ls); done; cd "$start"; done
```
```
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do exiv2 -r'%Y%m%d_:basename:' rename $(ls); done; cd "$start"; done
```

```
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do for i in $(ls *.*); do for i in $(ls *.*); do exiv2 -r '%Y%m%d-%H%M-:basename:' rename $i; done; done; cd "$start"; done
```

werkt redelijk, maar niet super want de tijd wordt 3 keer herhaald (original+digitized+modified) Haakjes in naam werkt niet. .mov --> no exif data found in the file. 
```
for i in $(ls *.*); do exiv2 -r '%Y%m%d-%H%M-:basename:' rename $i; done
```

Find datum van foto metadata:
```
identify -format %[EXIF:DateTimeOrginal]
```
IMG_1923.JPG

Kopieer bestand in dezelfde directory met andere naam:
```
cp IMG_1923.JPG test.JPG
```

Vind datum van foto en gebruik dit voor het hernamen van de foto (test.jpg
--> 20150516-1935_test.jpg)
werkt goed. metadat blijft intact.
```
exiv2 -r'%Y%m%d-%H%M_:basename:' rename $(ls)
```

29MAR20: Rename pictures
Step 1, rename files by metadata in directory:
```
exiv2 -r'%Y%m%d-%H%M_:basename:' rename $(ls)
```
Step 2: Change *.jpeg to *.jpg in directory
```
find -name '*.JPG' -exec rename .JPG .jpg {} \;
find -name '*.jpeg' -exec rename .jpeg .jpg {} \;
```
Step 3: rename with location info
rename 20190511 20190511_Schiphol *.jpg
```

make a list:
```
rename 20190511 20190511_Schiphol *.jpg
rename 20190512 20190512_Bangkok *.jpg
rename 20190513 20190513_Bangkok *.jpg
rename 20190514 20190514_Bangkok *.jpg
rename 20190515 20190515_Chiang_Mai *.jpg
rename 20190516 20190516_Chiang_Mai *.jpg
rename 20190517 20190517_Chiang_Mai *.jpg
rename 20190518 20190518_Chiang_Mai *.jpg
rename 20190519 20190519_Chiang_Mai *.jpg
rename 20190520 20190520_Koh_Yao_Noi *.jpg
rename 20190521 20190521_Koh_Yao_Noi *.jpg
rename 20190522 20190522_Koh_Yao_Noi *.jpg
rename 20190523 20190523_Kao_Sok *.jpg
rename 20190524 20190524_Kao_Sok *.jpg
rename 20190525 20190525_Kao_Sok *.jpg
rename 20190526 20190526_Koh_Tao *.jpg
rename 20190527 20190527_Koh_Tao *.jpg
rename 20190528 20190528_Koh_Tao *.jpg
rename 20190529 20190529_Koh_Samui *.jpg
rename 20190530 20190530_Ang_Thong *.jpg
rename 20190531 20190531_Koh_Samui *.jpg
rename 20190601 20190601_Bangkok *.jpg
rename 20190602 20190602_Schiphol *.jpg
rename 20190603 20190603_Schiphol *.jpg
```

Combine to one line:
```
rename 20190511 20190511_Schiphol *.jpg; rename 20190512 20190512_Bangkok*.jpg; rename 20190513 20190513_Bangkok *.jpg; rename 20190514 20190514_Bangkok *.jpg; rename 20190515 20190515_Chiang_Mai *.jpg; rename 20190516 20190516_Chiang_Mai *.jpg; rename 20190517 20190517_Chiang_Mai *.jpg; rename 20190518 20190518_Chiang_Mai *.jpg; rename 20190519 20190519_Chiang_Mai *.jpg; rename 20190520 20190520_Koh_Yao_Noi *.jpg; rename 20190521 20190521_Koh_Yao_Noi *.jpg; rename 20190522 20190522_Koh_Yao_Noi *.jpg; rename 20190523 20190523_Kao_Sok *.jpg; rename 20190524 20190524_Kao_Sok *.jpg; rename 20190525 20190525_Kao_Sok *.jpg; rename 20190526 20190526_Koh_Tao *.jpg; rename 20190527 20190527_Koh_Tao *.jpg; rename 20190528 20190528_Koh_Tao *.jpg; rename 20190529 20190529_Koh_Samui *.jpg; rename 20190530 20190530_Ang_Thong *.jpg; rename 20190531 20190531_Koh_Samui *.jpg; rename 20190601 20190601_Bangkok *.jpg
```

Helaas lukte het niet om .mov .gif en .mp4 te hernoemen met de exiv2 data.
Daarom heb ik exiftool gedownload
```
exiftool -time:all VID_20190513_113545.mp4
Creation Date                   : 2019:06:01 14:09:27+07:00
gif: geen creation date 
mov: Creation Date
mp4: Creation Data
```
```
exiftool -time:all IMG_4074.mov
Create Date                     : 2020:02:16 15:39:55
Creation Date                   : 2019:06:01 14:09:27+07:00
```
--------------------------------------------------------------
November 2020, wederom vakantiefotos sorteren.
Een van de devices lag 66 minuten achter. Daardoor werkte dit niet:
```
exiv2 -r'%Y%m%d-%H%M_:basename:' rename $(ls)
```
De fotos stonden daarna namelijk niet goed chronologisch. Dit is opgelost door 
de fotos van het device in een directory te zetten (pro tip: mount het geheugen
om extra snel te kunnen werken) en het volgende:
```
exifftool -DateTimeOriginal+='0:00:0 1:06:0' *.*
rm *original

```
en daarna alle foto's bij elkaar te zetten en in te voeren:
```
exiv2 -r'%Y%m%d-%H%M_:basename:' rename $(ls) ``` Nu wil ik nog de .jpeg en .JPG files omzetten naar .jpg.  Doe dit met: ```
find -name '*.JPG' -exec rename .JPG .jpg {} \;
find -name '*.jpeg' -exec rename .jpeg .jpg {} \;
```
Nu wil ik nog de locatie toevoegen voor elke foto. 
Dat doen we per dag en daar zetten we een locatie bij.
Dat gaat handig via vim.
creer eerst een lijst met de dagen:
```
20201008
20201009
20201010
20201011
20201012
20201013
20201014
20201015
20201016
```
En verander dit in vim in de volgende lijst:
```
rename 20201007 20201007_Roma *.jpg;
rename 20201008 20201008_Roma *.jpg;
rename 20201009 20201009_Roma *.jpg;
rename 20201010 20201010_Roma *.jpg;
rename 20201011 20201011_Napoli *.jpg;
rename 20201012 20201012_Napoli *.jpg;
rename 20201013 20201013_Napoli *.jpg;
rename 20201014 20201014_Napoli *.jpg;
rename 20201015 20201015_Positano *.jpg;
rename 20201016 20201016_Schiphol *.jpg;


rename 20201007 20201007_Roma *.jpg; rename 20201008 20201008_Roma *.jpg; rename 20201009 20201009_Roma *.jpg; rename 20201010 20201010_Roma *.jpg; rename 20201011 20201011_Napoli *.jpg; rename 20201012 20201012_Napoli *.jpg; rename 20201013 20201013_Napoli *.jpg; rename 20201014 20201014_Napoli *.jpg; rename 20201015 20201015_Positano *.jpg; rename 20201016 20201016_Schiphol *.jpg;
```
En samenvoegen in vim tot de volgend commandline die je laat lopen
Opmerking: het gaf foutmeldingen, omdat het te snel gaat ofzo, onduidelijk, het
is wss beter om de bovenstaande commandos afzonderlijk te laten lopen, of er
een microbreak tussen zetten ofzo:
```
rename 20201007 20201007_Roma *.jpg; rename 20201008 20201008_Roma *.jpg; rename 20201009 20201009_Roma *.jpg; rename 20201010 20201010_Roma *.jpg; rename 20201011 20201011_Napoli *.jpg; rename 20201012 20201012_Napoli *.jpg; rename 20201013 20201013_Napoli *.jpg; rename 20201014 20201014_Napoli *.jpg; rename 20201015 20201015_Positano *.jpg; rename 20201016 20201016_Schiphol *.jpg;

```
Mac image format heic conversion
Conversion of .heic to jpg:
```
for file in *.heic; do heif-convert $file ${file/%.heic/.jpg}; done
```
Roteren van afbeeldingen dmv exif informatie
Correct rotation image by exif data:
het volgende werkt NIET:
```
jhead -autorot *.jpg
```
andere optie: exiftran
WERKT OOK NIET:
```
exiftran -ai *.jpg
```
Geef exif informatie:
```
identify -verbose 20201008_Roma-1022_IMG_6383.jpg | grep "exif:"""
```
Informatie is te zien via:
```
exiftool -Orientation -S IMG_0049.heic
exiftool -Orientation -S -n a IMG_0049.heic #(output als getal)

```
WAT EEN GEDOE! DAN MAAR IN VIM VERWERKEN!!!!!!
Eerst orientatie zoeken via:
exiftool -Orientation -S *
Daarna deze output gecopieerd naar vim en de verschillende orientaties in
apparte dirs gezet (dmv commandline cp files.jpg file2.jpg dirnaam).
Daarna in deze dirs de bestanden gedraaid met de volgende commandos:





--------------------------------------------------------------
### PACMAN/YAOURT/YAY    

Je kunt downgraden naar een andere datum (terug in de tijd!) door 
replacing your /etc/pacman.d/mirrorlist with the following content:
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch
Then update the database and force downgrade:
# pacman -Syyuu

Info staat in /etc/pacman.conf en /etc/pacman.d/mirrorlist
Yaourt --> pas pacman.conf aan, toelaten van franse server:
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
==> Pacman is currently in use, please wait.
```
sudo rm /var/lib/pacman/db.lck
update
yaourt -Syu
sudo pacman -Syu
yaourt -Syyu --debug
```
To remove a package, which is required by another package, without 
removing the  dependent package:
```
yaourt -Rdd
```
Als een file corrupted is, dan forceer het opnieuw installeren:
```
yaourt -S --force
```

Ignore package, stel dat een package een probleem geeft, dan kun je dit
ignoren...
```
sudo pacman -Syu --ignore fontconfig
```

Forcefull install package (liever niet forceren, alleen bij uitzondering)
```
sudo pacman -S --force packagename 
```
Installeer alles geforceerd, alleen bij uitzondering, zorg voor een 
volledige backup van het systeem voor de zekerheid
```
sudo pacman -Syu --force 
```

For recursively removing orphans and their configuration files
```
sudo pacman -Rns $(pacman -Qtdq)
```

number of applications
```
sudo pacman -Q | wc -l
sudo pacman -Qet | wc -l
```
List number of applications by size
```
sudo pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less 
```
all apps:
```
sudo pacman -Qe
```
check orphan packages
```
sudo pacman -Qdt  
```
Remove the application + orphan packages
```
sudo pacman -Rns packagename  
```
combineren van bovenstaande 2 commands, verwijderd automatisch de orphan 
packages
```
sudo pacman -Rns $(pacman -Qdtq)
```

opschonen cache en outdated packages
```
sudo pacman -Scc
```
pacman.conf instellen
/etc/pacman.conf
Zet in misc. gedeelte:
```
Color        # commenting out
CheckSpace   # commenting out
ILoveCandy   # Toegevoegd voor pacman animatie tijdens download
```
grafische info over pacman
```
sudo pacman --version
```
Display clever insults when an incorrect password is entered instead of
printing the default "wrong password" message. Find /etc/sudoers and 
append "insults"
```
sudo nano /etc/sudoers
Defaults specification
Defaults insults
Cleaning package cache
```

26JUN19: overgestapt van Yaourt naar YAY, omdat yaourt niet meer 
onderhouden wordt. Installatie:
```
sudo git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
Update het hele systeem
```
yay -Pw #print nieuws, als het er is
yay -Syu #Hetzelfde als alleen yay gebruiken! Dus -Syu hoef je niet te
gebruiken
```
De help functie
```
yay --help
man yay
```
Zoeken beschikbare packages
```
yay -Ss spotify Geeft een lijst van AUR plus officiele
        packages
```
Installeren van bekende package
```
yay -S spotify
packages
yay spotify
```

#### WIFI            

Find names of network devices
```
sudo ip link
ip addr show laat ip addres zien (en andere
        info)
```
Discovery of access points
```
iwlist wlan0 scanning | less
```
Check current mac adress
```
ip link show eth0
```
Bring network interface down
```
ip link set dev eth0 down
```
Change mac adress
```
ip link set dev eth0 address XX:XX:XX:XX:XX:XX
```
Bring network interface back up
```
ip link set dev eth0 up
```

mac adress vast internet desktop pc
eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT qlen 1000
link/ether 00:1a:4d:5d:fe:4c brd ff:ff:ff:ff:ff:ff
Mijn ip address 82.174.98.248
```
sudo ip link set dev eth0 down
sudo ip link set dev eth0 address 00:23:4E:00:00:00
sudo ip link set dev eth0 up
```
Verander mac address wlan0 en wlan1 via onderstaande shell script
```
#!/bin/sh\
machack.sh: deze shell veranderd mac address van wlan0 en wlan1
            naar 00:23:4E:00:00:00 en 00:23:4E:11:11:11
----------------------------------------------------------------
Dit stuk tekst zijn simpele tools voor gebruik van Bash

testen of de file exec is: sudo ls -l bestandsnaam.sh
script executable maken:   sudo chmod +x bestandsnaam.sh
scrip runnen:              ./bestandsnaam.sh

----------------------------------------------------------------
sudo ip link set dev wlan0 down
sudo ip link set dev wlan0 address 00:23:4E:00:00:00
sudo ip link set dev wlan0 up
sudo ip link set dev wlan1 down
sudo ip link set dev wlan1 address 00:23:4E:11:11:11
sudo ip link set dev wlan1 up
```
Verander mac address wlan0 en wlan1 via onderstaande shell script terug
```
#!/bin/sh
macback.sh: deze shell veranderd mac address van wlan0 en wlan1
            naar android device en alfa USB wifi
            dan worden beide wlans geaccepteerd door mijn
            routers...
----------------------------------------------------------------
Dit stuk tekst zijn simpele tools voor gebruik van Bash

testen of de file exec is: sudo ls -l bestandsnaam.sh
script executable maken:   sudo chmod +x bestandsnaam.sh
script read/writeable maken voor iedereen:   sudo chmod a+rw bestandsnaam
scrip runnen:              ./bestandsnaam.sh

----------------------------------------------------------------
sudo ip link set dev wlan0 down
sudo ip link set dev wlan0 address 18:E2:C2:15:EC:48
sudo ip link set dev wlan0 up
sudo ip link set dev wlan1 down
sudo ip link set dev wlan1 address 00:C0:CA:58:16:A5
sudo ip link set dev wlan1 up
------------------------------------------------------------------
```
#### VNC (controle van desktop van buitenaf,oa android phone)       

vncserver
New 'archPC:2 (archie)' desktop is archPC:2
Starting applications specified in /home/archie/.vnc/xstartup
Log file is /home/archie/.vnc/archPC:2.log
Ik heb vnc beveiligd met ssh door het volgende commando:
```
sudo chmod 700 ~/.vnc
vncserver
```
of
```
vncserver -geometry 1920x1080 -alwaysshared -dpi 96-localhost :1
```
Mobieltje het lukt om in te loggen zonder ssh met androidVCN:
192.168.31.100:1 geeft login.. geen ssh
stoppen server
```
vncserver -kill :1
```
Vinden open vnc applicaties 
```
ps -A |grep vnc
kill -SIGKILL <PID>
kill -9 <PID>
```
Running directly from X0vncserver (werkt ook!)
```
x0vncserver -display :0 -passwordfile ~/.vnc/passwd
```
Aanpassen wachtwoord (ww in keepass)
```
vncpasswd
82.174.98.248
```
Configure the target computer's router to forward port 5900.
Look up the target computer's public (external) IP address.
Enter the public IP address in VNC Viewer to establish a connection.

#### Manipuleren van GE UNICORN
Installeren van packages die nodig zijn (oa een hex editor)
```
sudo pacman -S python2-pip python-pip python2-matplotlib python2-xlsxwriter 
sudo pacman -S python-matplotlib python-xlsxwriter ghex
```
Downloaden pycorn v 0.18 script, en daarna dit python script installeren 
via:
```
sudo pip install pycorn
```

Run het script via voorbeelden uit 
*/usr/lib/python3.6/site-packages/pycorn/docs/USAGE_pycorn-bin.txt*:
```
pycorn-bin.py -p /home/DATA/'HESP preproduct001.res'
pycorn-bin.py -p -r 3 /home/DATA/'HESP preproduct001.res'
pycorn-bin.py -e xlsx /home/DATA/'HESP preproduct001.res'
pycorn-bin.py -p csv /home/DATA/'HESP preproduct001.res'
```

Run het script via:
`pycorn-bin.py -2 csv /home/DATA/'HESP preproduct001.res'`
Geen output... waar is de csv file???

Volgende geeft geen output...:
```
cd /usr/lib/python3.6/site-packages/pycorn
pycorn.py /home/DATA/'HESP preproduct001.res
```

Batch script voor het maken van een pdf file van *.res in de huidige directory (WERKEND!):
```
for i in *.res;do pycorn-bin.py -p "$i";done
```
Proberen om data te lezen van een res file. Handmatig zonder de pycorn 
script. Uitleg opbouw van .res files staat in het onderstaande document.
Ik wil de sensor data uitlezen. Dit bevat de volgende informatie (twee 
locaties)
```
nano /home/werk/Downloads/PyCORN-master/pycorn/docs/RES_files_layout.txt
nano /usr/lib/python3.6/site-packages/pycorn/docs/RES_files_layout.txt

Structure of sensor data
8 bytes per pair
4 bytes sig/int	Accumulated volume, divide by 100 to obtain value in ml
4 bytes sig/int	Sensor value, divide by 1000/100/10 depending on sensor type. 

Bekijken file:
ghex /home/werk/Downloads/PyCORN-master/samples/sample1.res
ghex /home/DATA/'HESP preproduct001.res'
```
......to be continued....
     
#### Bluetooth instellen   

Geprobeerd aan de gang te krijgen: 07MAY18.
Install
```
yaourt -S bluez bluez-utils
modinfo btusb
```

Output:
```
modinfo
ERROR: Module aliaa btusb not found
```

Dus de module maar geladen:
```
modprobe btusb
```

Output: 
```
modprobe
FATAL: Module btusb not found in directory
/lib/modules/4.16.6-1-ARCH.  To load a module by filename (i.e. one that
is not installed in /usr/lib/modules/$(uname -r)/): insmod filename [args]
insmod filename [args]

modprobe -c | grep btusb
output: options btusb reset=1
Then start the bluetooth.service systemd unit.
You can enable it to start automatically at boot time. 

sudo systemctl start bluetooth.service

modinfo btusb
```
Deze keer wel output
dmenu Bluetooth manager: Bluez daemon is no running, blueman-manager cannot
continue.
sudo modprobe btusb
dmenu Bluetooth manager geen foutmelding maar er gebeurt niets.
Daaro blueberry, met gui, geïnstalleerd

sudo pacman -S blueberry
In Blueberry, gestart in commandline, staat er een x bij devices no 
plugin adapter found
met dmenu a, alle blueman apps geprobeerd, zonder succes.
blueman aangezet adapter
Blijkbaar heb ik geen bluetooth op mijn pc want geen output bij:
sudo lsusb |grep Bluetooth


#### VPN
19JAN19: ProtonVPN getest in mijn transip console.
Aangemeld bij ProtonVPN via werk email. ProtonVPN gebruikt openvpn.
Ingelogd op de website. Daar bij account staat de OpenVPN/IKEv2 username
Transip, rechtsonder networkmanager, add connection, VPN, 
Het probleem is dat ik geen secure core configs kan downloaden. Er werd
aangegeven dat er drie servers beschikbaar waren voor de gratis versie. 
Maar waar kan ik deze vinden en hoe krijg ik een config file....
Aangemeld voor protonmail...

20JAN19. VPNbook op mijn VPS getest
```
sudo apt-get update
sudo apt-get install network-manager-openvpn
```
Ga naar rechtsonder network manager, add connection, vpn, import a saved
VPN configuration. Gekozen: vpnbook, de4 server

Automatiseren van 200 muis klikken om de 50 ms:
```
xdotool click --delay 50 --repeat 20 1
```

#### Samba instellen
Het onderstaande werkt helaas nog niet.
`sudo yaourt -S samba`
daarna een smb.conf file aangemaakt in /etc/samba
gekopieerd van :https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default
aangepast: `workgroup = WORKGROUP`
aangepast: `log file = /var/log/samba/%m.log.`
scannen locaties: `smbtree`

installed: 
```
gvfs
gvfs-smb
sshfs
```

#### Fonts installeren
Double_Feature.ttf file gedownload, deze wil ik nu installeren.
Maak deze directory: 
```
mkdir -p ~/.local/share/fonts
```
Kopieer de ttf file:
```
cp ~/Downloads/*.ttf ~/.local/share/fonts
```
Verfris fc-cache:
```
fc-cache -f -v 
```
Kijken of de font erbij staat:
```
fc-list | grep Double
```

#### SQlite3 database
https://www.tutorialspoint.com/sqlite/sqlite_select_query.htm
Locatie database: /home/archie/domoticz/domoticz.db
Met de applicatie sqlitebrowser zie je dat de column Humidity staat in Table: Temperature

Command line; open database:
`sqlite3`
Nu zit je in 'sqlite3>' shell!
`.open domoticz.db`
select * from Temperature;
select Humidity from Temperature;
select Humidity, Date from Temperature;

csv export sqlite (volg door tussendoor '.show'):
```
.mode csv
.output test.csv
```
select Humidity, Date from Temperature;
```
.output stdout
```
---
### Corona script
Procedure gepikt van Luke Smith
```
curl https://corona-stats.online
curl https://corona-stats.online/netherlands > ~/.cache/corona
```
Script aangemaakt in ~/.local genaamd corona, executable gemaakt door:
```
chmod +x ~/.local/corona
```
Inhoud script:
```
#!/bin/sh
# 
# This script imports a corona dataset
# on a daily basis and gives output in
# the i3 bar

#If not downloaded today, then download
[ "$(stat -c %y ~/.cache/corona | cut -d' ' -f1)" != "$(date '+%Y-%m-%d')" ] &&
curl -s https://corona-stats.online/netherlands > ~/.cache/corona

# Fetch information and give output with emojis
grep "Netherlands" ~/.cache/corona |
sed "s/\s*//g ; s/║//g ; s/│/;/g" |
awk -F';' '{print "😷" $3 "("$4")" "☠️" $5 "("$6")"    ud script:
```
PROBLEEM: nu heb ik een goed script, maar hoe voeg ik dit toe aan i3bar.
Aan i3status kun je geen script hangen... (vim ~/.config/i3status/config)


### Video card information
lspci -vnn | grep VGA -A 12
[AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 / Radeon 520 OEM]
Deze kaart kan 2560X1440 EN 3840X2160 aan maar ik weet niet of dit een goed
idee is.
Ga ik gewoon een ultrawide kopen, of zal ga ik ook een betere video card kopen?

Een nieuwe amd card die zou werken kost 50 euro:
https://www.bol.com/nl/p/asus-r5230-sl-1gd3-l-radeon-r5-230-1gb-gddr3-videokaart/9200000027686779/?bltgh=lAYrxB4tzY134OkTkbpF-w.1_4.5.ProductPage

### Create Superfast ramdisk
Tijdelijke ramdisk creeren. Bijvoorbeeld voor snel schrijven
Check eerst beschikbare ram met free -g!
onderaan staat de umount.
```
free -g
mkdir -p /mnt/ram
mount -t tmpfs tmpfs /mnt/ram -o size=8192M
umount tmpfs /mnt/ram
```

### RSS stuff
sudo pacman -S newsboat
Add RSS feeds in the file: ~/.newsboat/urls
Create a config file: ~/.newsboat/config
I based it on Luke Smith: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/newsboat/config
The macro menu can be called by pressing "."
To download youtube.dll the tsp program is needed which can be installed by the
package called ts

### ff2mpv
Play youtube and other sources automatically by mpv in firefox.
First set the ff2mpv extension in firefox and then install:
yay ff2mpv-native-messaging-host-git

### C programming

De meest simpele manier om snel een C programma te draaien:
creeer een file in vim, bijv: test.c
Compile deze file met:
```
gcc test.c -o test
```
STart de C binary met:
```
./test
```
### ZSH en Oh-my-zhs
Na oh-my-zsh-git installatie via yay maak een config via:
cp /usr/share/oh-my-zsh/zshrc ~/.zshrc
Nu beginnen met configureren.

#### Applications (Command line and GUIs)

#### Vim
Installeer gvim, niet om te gebruiken maar om clipboard functionaliteit
tekunnen gebruiken :)
```
sudo pacman -S gvim
```

Kleuren in vim
Vind het filetype die vim heeft gedetecteerd:
```
:verbose setlocal syntax? filetype?
```
Verander tijdelijk de syntax naar conf type:
```
:set syntax:conf
```

 Vim plugins beheerde ik via Vundle (nu is het plug, want vundle is niet
 onderhouden)
```
yay vundle-git
```
 volg de manual op github: clone de repo en voeg de toe aan ~.vimrc zoals
  beschreven in de manual.
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
 Je zet de plugin in .vimrc en installeerd plugins in Vim via:
```
:PluginInstall
```
Helaas werkt het niet als ik op CTR-P druk, er wordt wel een command gegeven:
```
:call Vim_Markdown_Preview()
```
 maar er opent geen webpage.

De manual, ook te openen in vim met :help 
```
man vim
```
Personifieer vimrc
```
vim ~/.vimrc
```

My personal manual :)
```
Switching modes:

Esc: Exit open mode
i: Insert mode
I: Insert mode, en ga naar het begin van de regel
A: Insert mode, en start aan het einde van de regel
a: Insert mode, en start 1 cursor stap naar rechts
v: Visual mode
V: Visual line

Navigation(direct commands):
h: left
j: down
k: up
l: right
CTRL+b  : page up
CTRL+f  : page down
CTRL+e  : scrolls down (snelheid kun in in ./.vimrc instellen)
CTRL+y  : scrolls up (snelheid kun in in ./.vimrc instellen)
CTRL+f  : scrolls down one page
CTRL+b  : scrolls up  one page
H: verplaats cursor naar top pagina
M: verplaats cursor naar top pagina
L: verplaats cursor bodem van de pagina
gg: verplaats cursor naar start document
G: verplaats cursor naar einde document
z: ?
e: verplaats naar einde van het woord (einde: volgende woord)
b: verplaats cursor naar einde van het woord (einde: volgende woord)
w: verplaats volgend woord
A: einde van laatste woord

Modifiers
i: inner
s: surround
p: paragraph
.: perform the last

Search stuff
/string : search string. 
n: next word
N: previous word

Replace stuff
r: Replace a single character
R: Replace until we tell it to stop
c: Changes whatever specified (modifier)
C: Changes until the end of a line

Delete stuff
x: Delete single character after the cursor
X: Delete single character before the cursor
d: delete whatever specified (modifiers)
D: delete until the end of the line

Yank (copy) stuff
y: yanks whatever specified (modifiers)
Y: yanks current line completely

:reg: Show the register
"aY: Yank line to register B

Pasting stuff
p: pastes from vim buffer after cursor
"ap: paste  from registry entry a (:reg)

Working with macros

qa: Record a macro and save it to register a
q: Stop recording macro
@a: Play 1 time macro a (:reg)

Editing an existing macro(in dit geval a)

:new
"ap
Pas de macro aan en Escape

"ayy
dd
```

Zoek en vervang (search and replace), enkele keer: `:s/hot/cold/g`
Search and replace whole file: `:%s/hot/cold/g`
Search and replace,  wissen tekst: `:%s/Links naar bestanden op eigen pagina://g`
Search and replace, wissen tekst, zoeken met wildcard(</small>): `:%s/<.small>//g`
Saving macros separately, since :reg can be overwritten: `let @a='0fa'`

Alfabetisch Sorteren: `:sort`.

Voorbeelden
```
4w: 4 woorden verder
6k: 6 regels omhoog
d2w: delete the next two words
ciw: change inner word
ysiw"   : Onduidelijk wat ik hiermee kan doen ... ?
```

Navigation(command combination examples):
```
:42: verplaats cursor naar lijn nummer 42
10k: verplaats cursor 10 lijnen omhoog
10-: verplaats cursor 10 lijnen omhoog
10j: verplaats cursor 10 lijnen omlaag
10+: verplaats cursor 10 lijnen omlaag
```

Verander dit:
```
Commandl line
1  Command line tricks
2  Rechten bestanden
3  Grafische problemen
```
Naar dit:
```
Commandl line
<A href="#1  Command line tricks">naam
<A href="#2  Rechten bestanden">naam
<A href="#3  Grafische problemen">naam
<>
```
Door het volgende te typen:`qdI'Esc'A'Esc'0jq`
Speel de macro af met: `2@d`

The command line command: :
```
:q!                                 : Quit without saving
:wq                                 : Quit with saving
:w naam                             : Save file as naam
:new                                : Open een nieuw scherm
:verbose setlocal syntax? filetype? : Vind de syntax van bestand
:set syntax:conf                    : Tijdelijke Verandering syntax 
```

VIM; editen van markdown en live preview in browser met de
`iamcco/makrdown-preview.nvim` plugin.
Open een markdown file: `:MarkdownPreview`

Visual block rename tekst:
Control v, selecteer het blok dat je wil aanpassen
r, en hierna tekst invoeren wat je erover wilt schrijven
esc esc, om eruit te gaan en aan te passen.

#### Renaming in vim (fout --> goed)


```
/fout
cgn
goed
Escape
n
.
```

#### Sorting in vim
alfabetsch sorteren vim document:
:sort /\s\+/

#### Veranderen van tabbing naar spaces

:retab
#### Batch renaming in vim/vifm
Open een directory in vifm en tag de namen die je wil veranderen met 't'.
Selecteer een block met CTRL-v en geef daarna shift-I (insert tekst) Esc om 
het over het hele block toe te voegen.
Je kunt ook een blok doornummeren (na CTRL-v) door g CTRL-a te toetsen!

##### Spell checking in Vim
This functionality is alreadey build into Vim! Start it by entering:

```
:set spell!
```

List of keystrokes (about spell checking)
```
]s                      Next misspelled word
[s                      Previous misspelled word
z=                      Give autocorrection suggestions
zg                      Add word to dictionary
:set spelllang=en_us,nl Set two spelling dictionaries

Save the current document under another name:
:w ~/.config/suckless/dwm/config.h


```
#### fzf (fuzzy finder)
Command line zoek programma. Je kunt er in de huidige directory naar bestanden
zoeken met`fzf`. Dit is perfect voor piping. Bijvoorbeeld `cat * | fzf`
genereerd een tekst bestand van alle files in de directory waar je nu met fzf
in kunt zoeken.

#### Ranger (terminal file browser)
Instellen van image preview in ranger.
https://github.com/ranger/ranger/wiki/Image-Previews
Installeer w3m web browser: `sudo pacman -S w3m`
Voeg toe "set preview_images true" aan in  ~/.config/ranger/rc.conf: 
nano ~/.config/ranger/rc.conf
Tips voor gebruik Ranger
Stoppen is net als VIM: `:q!`.

Belangrijke commands in Ranger (je kunt ook ranger man gebruiken):
```
z 
zh #toggle hidden files on/off
zd #sort directives first
```

#### figlet
Maak asci word art van een woord in command line: `sudo pacman -S figlet`


#### vifm
Een terminal file manager die gebruikt maakt van VI bindings :-)
Ik heb van Distro Tube de volgende twee files toegevoegd aan 
vi ~/.config/vifm/scripts/vifmimg
```
#!/usr/bin/env bash
	readonly ID_PREVIEW="preview"
	if [ -e "$FIFO_UEBERZUG" ]; then
	    if [[ "$1" == "draw" ]]; then
	        declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"
	                           [x]="$2" [y]="$3" [width]="$4" [height]="$5" \
	                           [path]="${PWD}/$6") \
	            > "$FIFO_UEBERZUG"
	    else
	        declare -p -A cmd=([action]=remove [identifier]="$ID_PREVIEW") \
	            > "$FIFO_UEBERZUG"
	    fi
	fi
```
vi ~/.config/vifm/scripts/vifmrun
```
#!/usr/bin/env bash
	export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"
	function cleanup {
	    rm "$FIFO_UEBERZUG" 2>/dev/null
	    pkill -P $$ 2>/dev/null
	}
	rm "$FIFO_UEBERZUG" 2>/dev/null
	mkfifo "$FIFO_UEBERZUG"
	trap cleanup EXIT
	tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash &
	vifm
	cleanup
```
Wat je ook nodig hebt is het python script Ueberzug en pillow:
```
yay python-ueberzug
yay pillow
```

Om alles te laten lopen moet je het script ~/.config/vifm/scripts/vifmrun
starten. Verander de rechten van het bestand om executable te maken:
```
chmod u=rwx vifmrun
ls -a -l (Bekijk rechten)
less longfile.txt
test
```

Nu start je het script door in te voeren.  ~/.config/vifm/scripts/vifmrun
./vifmrun

Dit is toegevoegd als hotkey in i3: `mod+v`

Hernoemen van filenames in vifm in huidige directory(%: files in directory).
Ik wil de whitespaces vervangen door underscored:
```
:%rename
:%s/ /_/g
:wq
```
Het kan nog eenvoudiger!!! In vifm voer in:
```
:%s/ /_/g
```


#### urxvt (lightweight terminal). Kleurenschema kun je met pywal instellen :-)

Make Xdefault file, typ regel en druk op CTR+z
```
cat > .Xdefaults
```
Open nano
```
nano ~/.defaults
```
Plak daarin de onderstaande regels om de transparantie en font in te 
stellen, plus extra's die in de comments worden beschreven.
Created to rice the urxvt terminal.
```
Set transparency

URxvt.transparent:	        true
URxvt.shading:		        30

Choose a decent font.

URxvt.font:                 xft:bitstream Vera Sans Mono:size=9:antialias=true
URxvt.boldFont:             xft:bitstream Vera Sans Mono:bold:size=9:antialias=true

Set a rediculous cursor colour

URxvt.cursoColor:           magenta

Extentions (install urxvt-perls resize-font-git)

URxvt.perl-ext-common:      default, matcher, resize-font, url-select,keyboard-select
URxvt.keysym.M-u:           perl:url-select:select_next
URxvt.url-select.underline: True
 Resizing font by CTRL+j and CTRL+k
URxvt.resize-font.smaller:  C-j
URxvt.resize-font.bigger:   C-k 
 Keyboard select. Je gaat erin met Mod+ESC en eruit met Esc:
URxvt.keysym.M-Escape:      Perl:keyboard-select:activate
```

# .Xdefaults
#  __  __   _       __             _ _       
#  \ \/ /__| | ___ / _| __ _ _   _| | |_ ___ 
#   \  // _` |/ _ \ |_ / _` | | | | | __/ __|
# _ /  \ (_| |  __/  _| (_| | |_| | | |_\__ \
#(_)_/\_\__,_|\___|_|  \__,_|\__,_|_|\__|___/
#                                            
# Modified by Prutserdt
# Created to rice and improve functionality of the URxvt terminal.

## Set transparancy
```
URxvt.transparent:	        true
URxvt.shading:		        30
```
# Choose a decent font.
```
URxvt.font:                 xft:bitstream Vera Sans Mono:size=12:antialias=true
URxvt.boldFont:             xft:bitstream Vera Sans Mono:bold:size=12:antialias=true
Rxvt*letterSpace: -0 
```
# Orange cursor
```
URxvt.cursorColor:           orange
```

# Used extentions, requires: urxvt-perls resize-font-git
```
URxvt.perl-ext-common:      default,matcher,resize-font,url-select,keyboard-select
```
# url-select, werkt helaas nog niet... :-(
```
URxvt.keysym.M-u:           perl:url-select:select_next
URxvt.url-select.underline: true
URxvt.url-select.launcher:  "/usr/bin/firefox"
```
# Keyboard select. 
```
URxvt.keysym.M-Escape:      perl:keyboard-select:activate
URxvt.keysym.M-s:           perl:keyboard-select:search
URxvt.keysym.M-c:           perl:clipboard:copy
```


#### cmus. Terminal music player
Begin door het toevoegen van een direcotory, waar het prog. muziek in gaat
zoeken.
```
:add ~/Stack
```
Het programma heeft VIM bindings. Type 7 om de keybindinglijst te zien:
`7`

#### cava
Een audio visualizer voor in de commandline.
```
yay cava

```
#### Pywal.
Een script die in commandline van een foto een colorscheme maakte van
16 kleuren. Dit wordt de Xdefault. Op deze manier kun je eenvoudig switchen.
Installeer het script:
```
sudo pacman -S python-pywal
```
Destilleer de kleuren uit de wallpaper, deze veranderd ook direct de 
wallpaper :-)
```
wal -i women-arch-linux-wallpaper.jpg
wal -i wallpaper2.JPEG
```

Het wal commando veranderd de huidige kleuren in terminal. Je kunt de kleurselectie 
permanent maken door het volgende in .bashrc te zetten:
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
```
(cat ~/.cache/wal/sequences &)
```
# To add support for TTYs this line can be optionally added.
```
source ~/.cache/wal/colors-tty.sh
```

#### Nano
Pid van nano in gebruik... heel irritant als je bijv.
`sudo nano /etc/ssh/sshd_config`  wilt aanpassen. Als het verwijderen van
de PID niet werkt (zie allerlei), dan verwijder de swapfile. Deze staat 
in de directory van het bestand dat je wilt openen dus in dit geval:
`cd /etc/ssh` `ls *.swp` `sudo rm .sshd_config.swp` of direct:
```
sudo rm /.sshd_config.swp
```Dit werkt in Ubuntu 16.10 (mijn VPS)

#### Octave
Geinstalleerd via pacman. Octave-forge packages geinstalleerd via Octave met de
onderstaande commando's in Octave. Helaas mis ik Matlab functionaliteit, ook in
het statistics pakket :(.
```
pkg install - io
pkg install -forge statistics
```

#### Git (en dotfiles procedure)
Instellen Git
```
git config --global user.email "firstname@lastname.nl"
git config --global user.name "Prutserdt"
```


Automatisch wegschrijven van dotfiles in Github.
Dit gaat via de procedure van https://www.atlassian.com/git/tutorials/dotfiles
en https://www.youtube.com/watch?v=tBoLDpTWVOM. Aanmaken van de bare repository op de locale pc. Zorg dat je in de ~/dotfiles directory staat en voer het volgende in:
```
git remote add dotfiles https://github.com/Prutserdt/dotfiles.git
git push dotfiles
git push --set-upstream dotfiles master
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no
```

**Ik wil instellen dat de GIT repo direct werkt met een handshake, zonder
handmatig een password, dat ga ik nog regelen.**





Zorg eerst dat je een public SSH key hebt (had ik al)
```
sudo pacman -S xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
```
Plak de key in de webpagina van Github, settings/ssh key en geef het de naam van de computer
Daarna voer je in de terminal in:
```
ssh -T git@github.com
```

Selecteer `yes`, 

[archie@archPC ~]$ ssh -T git@github.com
The authenticity of host 'github.com (140.82.118.3)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,140.82.118.3' (RSA) to the list of known hosts.
Hi Prutserdt! You've successfully authenticated, but GitHub does not provide shell access.

HET WERKT DUS NOG NIET!!!!

eval "$(ssh-agent -s)"
ssh-add

### Nieuwe poging tot het toevoegen van een key aan github, 19JAN21:

Ik heb een ~/.ssh directory maar daar staat geen key in.
Generate a key:
ssh-keygen -t rsa -b 4096 -C email@email.com
Daarna heb ik alle vragen leeg gelaten en door 'geentered'(bijv empty
passphrase)
Bekijk of de keys zijn aangemaakt door:
ls -al ~/.ssh
Ja het staat er!
Nu ssh-agent laten lopen door:
eval "$(ssh-agent -s))"
Yes! De pid is aangemaakt dus het programma loopt.
Then, add your private key to ssh-agent with:
ssh-add ~/.ssh/id_rsa
Print the contents of your public key to the console with
cat ~/.ssh/id_rsa.pub
Copy de output en paste het hieronder:
___
ssh-rsa
AA....
email@email.com
___
Open de webpagina:
https://github.com/settings/keys
Kies New ssh key.
Title: Arch pc
Plak daarin bovenstaande key (incl ssh-rsa....==)
Klik op Add SSH key.
Nu voer in commandline:
ssh -T git@github.com
Nu heb ik ssh juist ingesteld, maar het werkt niet want ik moet nog eea
aanpassen, want er wordt geen ssh gebruikt maar .


















Nu is de bare repo geconfigureerd en kun je via de onderstaande procedure je bestanden toevoegen
aan deze bare repo:
```
config add .bashrc
config commit -m "Add my .bashrc"
```

Deze bestaat uit de volgende commando's
```
config add -u :/ -v
config commit -m "Updated"
config push -v
```

Git command line examples
```
config status
config push --force (deze wil je eigenlijk niet gebruiken)
```

### Add an additional dotfile to this repo
```
config add .example
config commit -m "Add my .example"
config push -v
```

### Remove an existing dotfile from this repo
```
config rm .example
config commit -m "Add my .example"
config push -v
```

### How to setup a new dotfiles repo
First create a `dotfiles` directory at ~/ then enter from ~/:
```
git remote add dotfiles https://githubc /Prutserdt/dotfiles.git
git push dotfiles
git push --set-upstream dotfiles master
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no
```
### How to add the dotfiles of this repo to a new Linux pc.

Make sure that git is installed and add a name and email:
```
git config --global user.email "firstname@lastname.nl"
git config --global user.name "Prutserdt"
```

Add the following alias to .bashrc:
```
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
echo "dotfiles" >> .gitignore
```

Now clone your dotfiles into a bare repository in a "dotfiles" folder of your $HOME:
```
git clone --bare https://github.com/Prutserdt/dotfiles.git $HOME/dotfiles
```

Define the alias in the current shell scope:
```
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Checkout the actual content from the bare repository to your $HOME:
```
config checkout
```

Probably there is an error message that some files are already excisting.
It's a good idea to make backup of the dotfiles in the ~/.config-backup directory:
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
Re-run the check out if you had problems:

config checkout

Probably not everything is in the correct subdirectory, therefore add the following dirs:
```
mkdir .config-backup/.config
mkdir .config-backup/.config/i3
mkdir .config-backup/.config/i3status
mkdir .config-backup/.config/ranger
mkdir .config-backup/.config/vifm
mkdir .config-backup/.config/i3status
mkdir .config-backup/Stack
mkdir .config-backup/Stack/Command_line
```
And then perform the same previously performed commands:
```
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
Now re-run the check and find out if there are still issues:
```
config checkout
```
Set the flag showUntrackedFiles to no on this specific (local) repository:
```
config config --local status.showUntrackedFiles no
```
If needed use:
```
config checkout -f
```
### Force update from local to github repo:
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME push -f

### Add my suckless utilities to my repo:


config add .example
```
commit -m "Add my .example"
push -v
config add ~/suckless/dwm/LICENSE
```

copy from vifm:
remove stuff by
open output in vim, ctrl v block selection, copy, and removing white space at
the end by :%s/\s\+$//e

```
config add ~/suckless/dwm/config.h &&
config add ~/suckless/dwm/config.mk &&
config add ~/suckless/dwm/drw.c &&
config add ~/suckless/dwm/drw.h &&
config add ~/suckless/dwm/drw.o &&
config add ~/suckless/dwm/dwm.1 &&
config add ~/suckless/dwm/dwm.c &&
config add ~/suckless/dwm/dwm.o &&
config add ~/suckless/dwm/dwm.png &&
config add ~/suckless/dwm/layouts.c &&
config add ~/suckless/dwm/transient.c &&
config add ~/suckless/dwm/util.c &&
config add ~/suckless/dwm/util.h &&
config add ~/suckless/dwm/util.o &&
config add ~/suckless/dwm/vanitygaps.c &&
config add ~/suckless/dwm/log/diff_log
config add ~/suckless/dmenu/LICENSE &&
config add ~/suckless/dmenu/Makefile &&
config add ~/suckless/dmenu/README &&
config add ~/suckless/dmenu/arg.h &&
config add ~/suckless/dmenu/config.def.h &&
config add ~/suckless/dmenu/config.h &&
config add ~/suckless/dmenu/config.mk &&
config add ~/suckless/dmenu/dmenu.1 &&
config add ~/suckless/dmenu/dmenu.c &&
config add ~/suckless/dmenu/dmenu.o &&
config add ~/suckless/dmenu/dmenu_path &&
config add ~/suckless/dmenu/dmenu_run &&
config add ~/suckless/dmenu/drw.c &&
config add ~/suckless/dmenu/drw.h &&
config add ~/suckless/dmenu/drw.o &&
config add ~/suckless/dmenu/stest &&
config add ~/suckless/dmenu/stest.1 &&
config add ~/suckless/dmenu/stest.c &&
config add ~/suckless/dmenu/stest.o &&
config add ~/suckless/dmenu/util.c &&
config add ~/suckless/dmenu/util.h
config add ~/suckless/dmenu/log/diff_log
config add ~/suckless/st/FAQ
config add ~/suckless/st/LEGACY &&
config add ~/suckless/st/LICENSE &&
config add ~/suckless/st/Makefile &&
config add ~/suckless/st/README &&
config add ~/suckless/st/TODO &&
config add ~/suckless/st/arg.h &&
config add ~/suckless/st/config.h &&
config add ~/suckless/st/config.mk &&
config add ~/suckless/st/st.1 &&
config add ~/suckless/st/st.c &&
config add ~/suckless/st/st.h &&
config add ~/suckless/st/st.info &&
config add ~/suckless/st/st.o &&
config add ~/suckless/st/win.h &&
config add ~/suckless/st/x.c &&
config add ~/suckless/st/x.o &&
config add ~/suckless/st/log/diff_log
config add ~/.config/dmenubackup.sh &&
config add ~/.config/dmenupatch.sh &&
config add ~/.config/dmenustable.sh &&
config add ~/.config/dmenuvanilla.sh &&
config add ~/.config/dwmbackup.sh &&
config add ~/.config/dwmpatch.sh &&
config add ~/.config/dwmstable.sh &&
config add ~/.config/dwmvanilla.sh &&
config add ~/.config/surfbackup.sh &&
config add ~/.config/surfpatch.sh &&
config add ~/.config/surfstable.sh &&
config add ~/.config/surfvanilla.sh &&
config add ~/.config/stbackup.sh &&
config add ~/.config/stpatch.sh &&
config add ~/.config/ststable.sh &&
config add ~/.config/stvanilla.sh 
```

#### Tox
Android: Antox
desktop: qtox

#### SXIV
Assign keyboard shortcuts (https://wiki.archlinux.org/index.php/Sxiv)
Kopieer het voorbeeld in de de wiki in de file
```
~/.config/sxiv/exec/key-handler en maak deze executable.
```
```
#!/bin/sh
while read file
do
        case "$1" in
#        "C-d")
#                mv "$file" ~/.trash ;;
        "C-r")
                convert -rotate 90 "$file" "$file" ;;
        "C-c")
                echo -n "$file" | xclip -selection clipboard ;;
        "C-w")
                wal -i "$file" ;;
        esac
done
```
Als je nu in SXIV een image als achtergrond wilt instellen klik je op
CTRL-x (voor key handler mode) en CTRL-w. :-).

play animated gif: CTRL+space 
a
#### Neomutt
Text based email client
Installation 18JUN20, alleen neomutt geinstalleerd en ~/.mutt/muttrc
aangemaakt...


#### Steam
Install July 2020: enable multilib in /etc/pacman.conf, install steam iwth
repository option 4: vulkan-radeon (other options: amdvlk, nvidia-utils,
vulkan-intel)
Repository multilib:  1) lib32-amdvlk  2) lib32-nvidia-utils  3) lib32-vulkan-intel  4) lib32-vulkan-radeon
gekozen: 4
Daarna gedownload (installed size: 353MB!)
Na het starten in commandline: steam
Fatal Error: Failed to load steamui.so
 Corrupt package file (/home/icefly/.local/share/Steam/package/webkit_ubuntu12.zip.vz.6f52fc663b60660500b356e9cf11098f56e312ef_55107636)
Failed to load steamui.so - dlerror(): steamui.so: cannot open shared object file: No such file or directory
Afgesloten en opnieuw opgestart met dezelfde foutmelding.
Deinstalled 
pacman -Rs steam
Geinstalleerd met optie 1 (amdvlk)en 4(lib32-vulkan-radeon)
Weer dezelfde foutmelding na starten steam in commmand line.
Nu geinstalleerd met optie 4 (vulkan-radeon) en 1 (lib43-amdvlk)
Wederom dezelfde foutmelding.
Daarna steamcmd geinstalleerd van de AUR
yay steamcmd
Dit werkt ook niet zo goed.
Ik heb gedeinstalleerd met yay.

#### Stack client
Stack staat in de AUR maar dit kun je beter niet gebruiken (geen: yay stack-client)
https://www.transip.nl/knowledgebase/artikel/283-de-desktopapplicatie-van-stack/
https://mirror.transip.net/stack/software/appimage/stack-2.6.5-20200909-x86_64.AppImage
Na het downloaden kun je hem uitvoerbaar maken met:
chmod +x stack-2.6.5-20200909-x86_64.AppImage
En starten door eerst in de webap in te loggen, dan naar de downloads
directory te  gaan en de appimage te starten:
https://icefly.stackstorage.com/files
cd /Downloads
./stack-2.6.5-20200909-x86_64.AppImage
Nu vraagt de applicatie om in te loggen in de webapp, doe dit met de link die
gegeven wordt. Daarna werkt het :-) (09JAN21)
Het aanmelden gaat het eenvoudigste via een single command line:
/home/icefly/Downloads ; ./stack-2.6.5-20200909-x86_64.AppImage &
Alternatief kun je dmenu gebruiken, voeg de volgende regel toe aan
~/.cache/dmenu_run
/home/icefly/Downloads/stack-2.6.5-20200909-x86_64.AppImage
Je moet wel even wachten en de link in de browser openen, even daarna kun je de
terminal weer verder gebruiken.

Koppel stack aan thunar door het volgende adres in browse network in te voeren:
davs://icefly.stackstorage.com/remote.php/webdav/
Daarna wordt naar username en password gevraagd en staat het in thunar
ingesteld.

Zie dmenu onderaan om te zien hoe je appimage koppeld aan dmenu_run

#### Copy pictures of mac to linux
Connect old imac hard drive connected to a usb connector with powersupply to 
new imac pc by the usb C hub. Open the photos application of mac and select
pictures and copy them to the harddrive (somewhere in top bar this can be
selected).
Then connnect the drive to the LINUX PC and reboot. Do a 
sudo mount /dev/sdc2 /mnt/USBdrive
Get super user rights:
su
Open vicd and copypasta
Change user rights of files, because it is now superuser
sudo chown icefly:users *.* 
go directory and:
sudo chown icefly:users directoryname

#### VPN
Many options...
surfshark
torguard
protonvpn

#### Virtualbox en Whonix
Installation:
sudo pacman -S virtualbox
choose: virtualbox-host-modules-arch
run:
modprobe vboxdrv

whonix virtualbox image downloaded, imported in virtualbox. Could not start
First run the gateway, after that the workstation.

#### Arduino
De arduino applicatie kreeg ik aan de gang na installatie van arduino
(community) toegang tot de groep uucp en installatie van arduino-avr-core.
```
sudo arduino
```
en selecteer: tools board: Arduino uno . port: ttyACM0
firmware is te uploaden, het werkt!


### Distros

#### XFCE tricks
XFCE4 in desktop achtergrond terminal services laten draaien.
Filename: wallterm.sh
maak executable:

```
chmod a+x /path/to/wallterm.sh
```

Voeg dit toe aan de file walltem.sh:
```
!/bin/bash
Dit script zorgt ervoor dat er terminals in de desktop komen...

xfce4-terminal -e nload --hide-borders --hide-toolbar --hide-menubar --title=dt1 --geometry=70x25+1420+190 &
xfce4-terminal -e htop --hide-borders --hide-toolbar --hide-menubar --title=dt2 --geometry=70x30+1420+610 &
sleep 5
wmctrl -r dt2 -b add,skip_pager,skip_taskbar 
wmctrl -r dt1 -b add,skip_pager,skip_taskbar
```
Autostart de wallterm.sh in XFCE4 door dit te doen: 
```
XFCE4-Settings-Session and Startup-Application Autostart 
--> add wallterm --> command: /home/icefly/wallterm.sh
```
Andere opties die interessant kunnen zijn voor monitoring:
```
vmstat
sudo tcpdump -i enp3s0
sudo tcpdump -c 5 -i enp3s0
sudo tcpdump -XX -i enp3s0
sudo iftop
sudo xfce4-terminal -e iftop --hide-borders --hide-toolbar --hide-menubar --title=dt5 --geometry=70x30+720+10 & 
sleep 5 wmctrl -r dt5 -b add,skip_pager,skip_taskbar 
monitorix 
yaourt -S monitorix ( vorige keer niet geinstalleerd)
nmon
sudo iptraf-ng
```

Maak de windows meer snappy, meer tiling window manager achtig...
XFCE4-Settings-Window manager --> advanced
Windows snapping: to screen border en To other windows, distance:
halverwege small-Wide

Quickbuttons voor verplaatsen van tiles (met alt knop) (quickbutton 
maximaliseren F11)
XFCE4-Settings-Window manager --> Keyboard
Het staat in een text file maar dat is minder goed leesbaar:
```
~/.config/xfce4/xfconf/xfce-perchannel-xml\xfce4-keyboard-shortcuts.xml
```
```
Maximize window					Alt+5
Tile window to the top				Alt+8
Tile window to the bottom			Alt+2
Tile window to the left				Alt+4
Tile window to the right			Alt+6
Tile window to the top-left			Alt+7
Tile window to the top-right        Alt+9
Tile window to the bottom-left      Alt+1
Tile window to the bottom-right	   	Alt+3
```

Aanmaken van keyboard shortcuts
XFCE4-Settings-Keyboard --> Application shortcuts
(Ook dit staat in de text file die hierboven staat, maar dat is minder goed leesbaar)
```
sh -c "mousepad && thunar "							Twee commands :-)
```
mousepad /mousepad /home/archie/Stack/Command_line/commands_2018_12_31.txt	Ctrl+Alt+M
firefox	https://facebook.com							Ctrl+Alt+F
firefox https://webmaileu.werk.com/OWA/	    			Ctrl+Alt+S
firefox firefox https://login.yahoo.com					Ctrl+Alt+Y
thunar sftp://icefly@IP VPS                 			Ctrl+Alt+T
amixer set Master 5%-								XF86AudioLowerVolume
amixer set Master 5%+								XF86Audiomute
KCalc										XF86Calculator

sh -c "xfce4-terminal --title=ssh_icefly@149.210.233.43 --geometry=93x29+1420+0 && thunar sftp://icefly@149.210.233.43/home/icefly/Downloads/"	Ctrl+Alt+I

Gebruik autokey voor assignen van macros aan keys (zoiets als autohotkey)
```
yaourt -S autokey
```

Gebruik windows key voor XFCE menu:
 XFCE4-Settings-Window manager --> keyboard --> Applications Shortcuts --> 
 xfce4-popup-applicationsmenu
 Edit --> click OK, daarna kun je de windows key selecteren

Windows snapping: to screen border en To other windows, distance: halverwege small-Wide

Appearance aanpassen
aanpassen bottom bar, rechtermuis op de bar, dan Panel --> panel preferences,
row size: 20
start button: Settings: setting manager: Appearance:     Style: Xfce-dusk. 
                                                         Icons: Faba. 
                                         Window manager: Style: Coldsteel.
Terminal aanpassen (onderstaande regels)
nano ~/.config/xfce4/terminal/terminalrc
BackgroundMode=TERMINAL_BACKGROUND_TRANSPARENT
MiscMenubarDefault=FALSE 
BackgroundDarkness=0.850000

Problemen met XFCE layout (windowsmanager, advanced, wrap workspace when 
reaching the screen edge). 
Eerst config files in ~/.config/xfce4 aangepast, zonder succes. oa deze 
directory:cd ~/.config/xfce4/xfconf/xfce-perchannel-xml
Daarna de home xfce4 directory verwijderd ~/.config/xfce4, helaas kwam de
default setting NIET terug...
Ook geprobeerd om de default settings /xdg/xfce4/xfconf te kopieren 
naar ~/.config/xfce4
```
cp -r /etc/xdg/xfce4 /home/archie/.config
```
Daarna xfce4 gedeinstalleerd, en opnieuw geinstalleerd:
```
sudo pacman -Rdd xfce4
sudo pacman -Rdd xfce4-panel
sudo pacman -Rdd xfconf
```
$ Probleem nog niet opgelost helaas :-(.
$ Oplossing: verwijder als super user, via mc de xfce4 cache files!
~/.cache/sessions

#### Thunar
Settings Manager (XFCE, vanuit superbutton)--> Settings Editor --> thunar
Hier kun je last-separator-position aan/uitzetten.
Of, veel simpeler, klik op CTR-M om het menu aan/uit te zetten in de Thunar 
balk.

Edit mp3 tags in Thunar, door onderstaande plugin:
```
sudo pacman -S  thunar-media-tags-plugin
```

After a minimal install (dwm) also install lxappearance and themes, for
example: breeze, nordic, juno, candy-icons, Papirus, equilux-theme, dark-olympic enz.

Toevoegen van directories bij PLACES; rechtermuis op directory en sent to: side pane.

Toevoegen plugin voor het extracten: thunar-archive-plugin
Plugin voor toevoegen mounted drives: thunar-volman

#### i3 window manager   

Tips: https://www.youtube.com/watch?v=8-S0cWnLBKg

Nieuwe installatie:
sudo pacman -S i3status i3gaps dmenu feh
Start i3 via startx (oftewel .xinitrc in home directory
Daarvoor eerst de default .xinitrc kopieren

Delete de regels van het bestand maar laat de laatste tekstblok staan 
en voeg exec i3 toe (plus onderstaande voor logging)
```
exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
twm &
xclock -geometry 50x50-1+1 &y
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
exec xterm -geometry 80x66+0+0 -name login
Start i3 (login als archie)
startx
```

Je kunt de config file aanmaken met 
(locatie /home/archie/.config/i3/config)
```
i3-config-wizard
```

Customize de config
```
nano /home/archie/.config/i3/config
```

Verander look and feel met lxappearance. Kies bijv. xfce-dusk
lxappearance

Mooi lettertype: system-san-francisco-font-git
```
yaourt -S system-san-francisco-font-git
```

De font wordt weegegeven in de lijst: 
fc-list : file
Open lxappearnce, verander de fontsize, klik op apply.
Nu is een .gtk file aangemaakt, vind het bestand (.gtkrc-2.0)
```
ls -al
```

Pas fontawesome-webfont.ttf de eigenschappen aan in nano, ook in gtk-3. 
Open de bestanden en verander gtk-font-name="Cantarell 13" naar 
gtk-font-name="System San Francisco Display "
```
nano .gtkrc-2.0
nano ~/.config/gtk-3.0/settings.ini
```

Het werkt, ook is dit font is toegevoegd aan /home/archie/.config/i3/config 
(font pango: System San Francisco Display 10)
Het is ook mogelijk om de font te kiezen in lxappearance, het heet daar 
SFNS display, maar dit geeft een slechte rendering.
....yosemity font gecopierd naar ~/.fonts

Pas het i3status.conf file aan, save het in de user directory voor gebruik voor alleen deze gebruiker
Ik heb de iPv6, Wireless en de battery status uitgevinkt met #.
```
mkdir .config/i3status
cp /etc/i3status.conf .config/i3status/config
vim .config/i3status/config
```

Zet icons op tabs. 
Download Font-Awesome Release 4.4 op webpagina:
https://github.com/FortAwesome/Font-Awesome/releases
Pak de fontawesome-webfont.ttf uit de zipfile en verplaats naar .fonts:
```
mv fontawesome-webfont.ttf ~/.fonts/
```

Kopier bijvoorbeeld de firefox afbeelding op de onderstaande webpagina
https://fontawesome.com/cheatsheet
Plak het icoon, , in de tekstfile
```
nano /home/archie/.config/i3/config
```

Forceer een applicatie om te openen op een vast tab blad met 
Vind de class van een applicatie door naast de applicatie een terminal te
openen en daarin xprop te starten en op de applicatie te klikken:
(assign [class="Firefox"] $workspace3)
```
xprop
```

Mooi icon theme. Instellen via lxappearance/Icon theme/Moka
```
yaourt -S moka-icon-theme
```

Save layout of workspace, dit zou de layout moeten wegschrijven, waarnaar
je het na modificatie kunt wegschrijven, niet eenvoudig en lukt me nog 
niet...  https://i3wm.org/docs/layout-saving.html EditingLayoutFiles: 
```
i3-save-tree --workspace 2 > ~/.config/i3/workspace-2.json
```

Zet numlock aan:

```
sudo pacman -S numlockx
exec_always --no-startup-id numlockx off
```


Een paar commands (meer staat in onderstaande config file!).
Let op mod: super key!

```
$mod+Enter	Open terminal
$mod+1		Selecteer space 1 (1-9 kun je kiezen)
$mod+Shift+e	Logout i3
$mod+Shift+q	Close container
$mod+f		Toggle full screen 
$mod+d		Choose application
$mod+z		Choose application
$mod+r		Rescale container (met pijltjes, escape om uit rescale te gaan)
$mod+shift+1	Verplaats container naar een andere workspace (in dit geval 1)
$mod+Shift+Left	Verplaats container op workspace naar andere positie met pijltjes
```

Instellen van Super_R als applications launcher en Capslock als escape
voor VIM. Wat is de default setting van mijn Ducky keyboard:
[archie@archPC ~]$ xmodmap -pm
xmodmap:  up to 3 keys per modifier, (keycodes in parentheses):
shift       Shift_L (0x32),  Shift_R (0x3e)
Hellock        Caps_Lock (0x42)
control     Control_L (0x25),  Control_R (0x69)
mod1        Alt_L (0x40),  Alt_R (0x6c),  Meta_L (0xcd)
mod2        Num_Lock (0x4d)
mod3      
mod4        Super_L (0x85),  Super_L (0xce),   Super_R (0x86), Hyper_L (0xcf)
mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)
mod3 is leeg, daar gaan we Super_R neerzetten.
nano .Xmodmap
Plak daarin:
remove mod4 = Super_R
add mod3 = Super_R
remove Lock = Caps_Lock
keysym Escape = Caps_Lock
keysym Caps_Lock = Escape
add Lock = Caps_Lock
laad xmodmap :-)
xmodmap ~/.Xmodmap

Voeg toe aan ~/.config/i3/config
bindsym mod3+f exec firefox
exec --no-startup-id xmodmap ~/.Xmodmap
Het werkt. Nu kan de rechter superkey worden gebruikt als applicatie
launcher :-)


PROBLEEM: Als ik mijn keyboard unplug dan werken de xmodmap keybindings niet
meer. Dat is irritant omdat de Esc/Capslock en "Menu" knop niet meer werken.
De oplossing is om een dotfile aan te maken `~/.config/kbswitch` en zet daarin:
```
!.kbswitch
! _    _                  _ _       _     
!| | _| |__  _____      _(_) |_ ___| |__  
!| |/ / '_ \/ __\ \ /\ / / | __/ __| '_ \ 
!|   <| |_) \__ \\ V  V /| | || (__| | | |
!|_|\_\_.__/|___/ \_/\_/ |_|\__\___|_| |_|
!                                         
! Modified by Prutserdt
! This dotfile triggered by the .bashrc and by
! entering: xmodmap ~/.bswitch

! Super_R key is set to mod3, this button is used for keybindings to apps in i3wm, see ~/.config/i3/config
remove mod4 = Super_R
add mod3 = Super_R

! A little hack for VIM. The Caps_Lock becomes the Escape key and vice versa.
remove Lock = Caps_Lock
keysym Escape = Caps_Lock
keysym Caps_Lock = Escape
add Lock = Caps_Lock
```
In .bashrc is een alias aangemaakt die deze xmodmap laat lopen:
alias kbswitch='xmodmap ~/.config/kbswitch'

Helaas werkt deze oplossing niet helemaal en niet altijd. 
Het kan ook via: setxkbmap -option ctrl:swapcaps
https://bbs.archlinux.org/viewtopic.php?id=172421
In mijn geval wordt het
https://bbs.archlinux.org/viewtopic.php?id=172421


# Swap toegevoegd 12JAN20
# manually 
```
fallocate -l 8G /mnt/sdc1/swapfile
chmod 600 /mnt/sdc1/swapfile
mkswap /mnt/sdc1/swapfile
swapon /mnt/sdc1/swapfile
/etc/fstab
```
# 12sep20 toegevoegd /etc/fstab:
```
/swapfile none swap default 0 0
```
Hierna werkt het nog niet, want error bij opstarten

### Emojis in dmenu
Geschreven volgens Luke Smith: https://www.youtube.com/watch?v=UCEXY46t3OA

ONderstaande unicode file gemaakt als test
~/.config/unicode
😀 grinning face
😃 grinning face with big eyes

Helaas geeft dit permission problemen. Opgelost door:
```
chmod 755  ~/.config/unicode
```
Nu werkt het volgende wel:
```
cat ~/.config/unicode | dmenu -i -l 30
```
Een script ervan gemaakt, ~/.config/unicode.sh, executable gemaakt, de alias u
aangemaakt (u). Dit werkt. Alleen de unicode lijst nog aanvullen....
Ook toegevoegd aan de i3 config, zodat menu-U het script runt.
Ik heb ttf-ancient-fonts van de AUR geinstalleerd, en nu zijn de meeste icons
zichtbaar. De unicod font lijst heb ik gevonden op: 
```
https://unicode.org/Public/emoji/13.0/emoji-test.txt
```
Het werkt nog niet perfect.
if you add the following line to the script that he showed:
```
xdotool key "ctrl+shift+v"
```
it will automatically insert the emoji into the focused program (like browser or terminal), making this
dmenu setup act like an emoji keyboard for quick insertion


    /*{ MENUKEY,                    XK_u,      spawn,          SHCMD("cat ~/.config/unicode | dmenu -i -l 20 -fn unifont-08| awk '{print $1}'| xclip -selection clipboard") },*/
    /*cat ~/.config/unicode | dmenu -i -l 25 -fn Monospace-24| awk '{print $1}'| xclip -selection clipboard && xdotool type "$(xclip -o -selection clipboard)" */


#### Install on persistent USB feb2017                    

Twee partities aangemaakt in GPARTED: 12.6 GB ext4 en 2.1 GB FAT32
sudo mount /dev/sdd1 /mnt
Create mount points for any remaining partitions and mount them accordingly,
for example:
```
sudo mkdir /mnt/boot
sudo mount /dev/sdd2 /mnt/boot
```
Installeer scripts (oa pacstrap) indien nodig
```
yaourt -S arch-install-scripts
```
pacstrap het basissysteem naar de usb stick (/mnt)
```
sudo pacstrap /mnt base
```
Generate an fstab file (use -U or -L to define by UUID or labels, respectively):
```
genfstab -U /mnt >> /mnt/etc/fstab
```
Check the resulting file in /mnt/etc/fstab afterwards, and edit it in case of errors.
Change root into the new system:
```
sudo arch-chroot /mnt
```
Set the time zone:
```
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```
Run hwclock(8) to generate /etc/adjtime:
```
hwclock --systohc
```
Set the LANG variable in locale.conf(5) accordingly, for example, 
in Nano toevoegen: LANG=en_US.UTF-8:
```
nano /etc/locale.conf
```
hostname aanmaken
```
echo USBdistro > /etc/hostname
```
Set the root password:
```
passwd
```
Install syslinux
```
pacman -S syslinux
syslinux-install_update -i -a -m
```
Pas de sda drives aan in /boot/syslinux/syslinux.cfg
Install XFCE4
```
pacman -S xfce4
```
Exit chroot en reboot.
Hmmmm, na inloggen starte linux mint op en liep daarna vast...
aangepast:
```
gparted --> bootable flag voor sda1 aangezet.
sudo dd bs=440 count=1 if=/usr/lib/syslinux/bios/mbr.bin of=/dev/sdd
reboot.... hopelijk nu ok.....?
... nee, geen linuxmint meer tijdens opstarten dus de mbr is veranderd, maar
nog steeds niet OK.
sudo mount /dev/sdd1 /mnt
sudo arch-chroot /mnt
Install syslinux en daarna sda1 aangepast.
pacman -S syslinux mc
reboot.... hopelijk nu ok.....?
... nee. waarschijnlijk is de mbr niet correct...
sudo mount /dev/sdd1 /mnt
sudo arch-chroot /mnt
printf '\x5' | cat /usr/lib/syslinux/bios/altmbr.bin - | dd bs=440 count=1 iflag=fullblock of=/dev/sdd
reboot.... hopelijk nu ok.....?
... nee. waarschijnlijk is syslinux niet correct geconfigureerd...
sudo mount /dev/sdd1 /mnt
sudo arch-chroot /mnt
syslinux-install_update -i -a -m
reboot.... hopelijk nu ok.....?
... nee. syslinux niet correct geconfigureerd...
sudo mount /dev/sdd1 /mnt
sudo arch-chroot /mnt
pacman -S linux
mkinitcpio -p linux
maak gebruiker aan
useradd -m -G wheel -s /bin/bash icefly
maak wachtwoord voor gebruiker aan:
passwd icefly
volgende geinstalleerd:
pacman -S xf86-video-vesa  xf86-video-fbdev xorg-server  xf86-video-amdgpu
dhcpcd gestart als root:
dhcpcd enp3s0
Aan /etc/pacman.conf toegevoegd:
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
sudoers aanpassen
pacman -S yaourt sudo
open visudo met nano en haal de hashtag weg voor %wheel ALL=all+all
EDITOR=nano visudo
list available timezones
timedatectl set-timezone Zone/SubZone
instellen timezone:
timedatectl set-timezone Europe/Amsterdam
```

Let op: de laatste backup is gemaakt op 30DEC18.
(er is sinds 20JUL17 een tweede useraccounts en setup voor op het werk).

#### Ubuntu 16.10 server en network

Zaterdag 27Jan17 transip vps opnieuw ingesteld

Hostname: UbuntuSERVER
User: icefly
Encrypted home directory
50 GB in een partitie (prim ext4 52.6GB en swap 1.1GB)
Security updates automatically
Alleen 'Standard system utilities','Xubuntu desktop' en 'OpenSSH server'
geselecteerd als software om te installeren.
Grub als bootloader gekozen (enige optie)
Start ssh op de server
```
sudo service ssh start
ssh-keygen -t rsa #geen passprase
```

genereer keygen op thuis computer
```
ssh-keygen -t rsa #geen passprase
```
verstuur nu vanuit thuis computer de key naar de host:
```
ssh-copy-id icefly@149.210.233.43
```
nu moet je wachtwoord vd server intypen.. 
(daarom staat passwordauthentificatino aan!)
PAS DAARNA naar de server sshd_config aanpassen, backup maken van file
Verander in sshd_config:
```
sudo nano /etc/ssh/sshd_config
PasswordAuthentication no
LoginGraceTime 60
AllowUsers archie icefly
```
Verander de MaxStartups niet want dit kan in errors resulteren, in mijn geval 
bij MaxStartups 3:50:10

Instellen server in Thunar filebrowser

Instellen link in thunar filebrowser
Eerst in commandline
```
ssh icefly@149.210.233.43
```
Daarna in thunar, network
```
sftp://icefly@149.210.233.43/home/icefly/
```

Ubuntu updaten
Via ssh het ubuntu systeem updaten, of via de https console:
```
sudo apt-get update        Fetches the list of available updates
sudo apt-get upgrade       Strictly upgrades the current packages
sudo apt-get dist-upgrade  Installs updates (new ones)
```

SSH problemen
Mijn probleem was:
If you had previously generated an SSH key pair, you may see a prompt that 
looks like this:
```
/home/username/.ssh/id_rsa already exists.
```
Overwrite (y/n)?
If you choose to overwrite the key on disk, you will not be able to authenticate using 
the previous key anymore. Be very careful when selecting yes, as this is a destructive 
process that cannot be reversed.

Oplossing: op beide kanten openssh uninstallen, client en server. 
Files op ~/.shh verwijderen aan beide kanten.
Opnieuw installeren beide kanten. Daarna aan beide kanten keygen doen:
```
ssh-keygen -t rsa
```
Alleen op lokale pc:
```
ssh-copy-id icefly@149.210.233.43
```
Nu moet je wachtwoord vd server intypen.. 
(daarom staat passwordauthentificatino aan!)
PAS DAARNA naar de server sshd_config aanpassen...
```
sudo nano /etc/ssh/sshd_config
```
Verander: PasswordAuthentication no
Vul in onderaan AllowUsers archie@81.174.98.248
Inloggen werkt hierna weer goed! :-)
 
#### Ubuntu Mate op GPD pocket

27APR19 opnieuwe linux installatie, want na Parrot upgrade loopte het systeem vast.
Ubuntu Mate 18.04.2 LTS (Bionic) 
De iso gedownload op via torrent (https://ubuntu-mate.org/download/)
en op een usb stick gezet.
```
sudo dd if=//home/archie/Downloads/ubuntu-mate-18.04.2-desktop-amd64-gpd-pocket.iso of=/dev/sdd status=progress
```

Accessing GPD boot menus
Switch the GPD Pocket on, immediately hold the Fn key and tapping the F7 key until the Boot Manager screen appears.

Arch linux op GPD pocke

Ik heb eerst ubuntu geinstalleerd, werkte goed, maar geen goede updates en GEEN ARCH dus
suboptimaal :-)

27APR18 https://wiki.archlinux.org/index.php/GPD_Pocket
Volgende file gedownload gelinked vanuit archlinux.org: archlinux-gpd-pocket-2018.01.05-x86_64.iso
Dit is de gepatchte versie. Weggeschreven op usb drive (micro card, via usb adapter):
sudo dd if=//home/archie/Downloads/archlinux-gpd-pocket-2018.01.05-x86_64.iso of=/dev/sde status=progress

arch vanuit usb gestart (01MAY18 22:18)
start met delete knop ingedruk, en boot from USB
```
ip link set wlp1s0 up
ip linkoutput: wlp1s0 ... UP
wifi-menu
Voer alvast het wachtwoord in
modprobe -r brcmfmac
modprobe brcmfmac
pacman -Syu
Yess, het werkt, ik zit online!
```

```
lsblk
NAME		MAJ:MIN	RM	SIZE	RO	TYPE	MOUNTPOINT
loop0		7:0	0	487.8M	0	loop	/run/archiso/sfs/airootfs
sda		7:0	0	1.9G	0	disk
sda1		8:0	1	1.9G	0	part	/run/archiso/bootmnt
sda2		8:1	1	595M	0	part	
mmcblk0		179:0	1	116.5G	0	disk
mmcblk0p1	179:1	0	100M	0	part	
mmcblk0p2	179:2	0	16M	0	part	
mmcblk0p3	179:3	0	65.8G	0	part	
mmcblk0p4	179:4	0	800M	0	part	
mmcblk0p5	179:5	0	49.8G	0	part	
mmcblk0boot0	179:8	0	4M	1	disk	
mmcblk0boot1	179:16	0	4M	1	disk	

```
```
cfdisk /dev/mmcblk0
mkfs.ext4 /dev/mmcblk0p3
mount /dev/mmcblk0p3 /mnt

```
Create boot directory and mount Windows Boot Loader
```
mkdir /mnt/boot
mount /dev/mmcblk0p1 /mnt/boot
```
....
alles gedaan zoals beschreven in:
```
https://wiki.archlinux.org/index.php/GPD_WIN
```

opstarten lukt. nog geen netwerk

```
ip link set wlp1s0 up
ip link
output: wlp1s0 ... UP
modprobe -r brcmfmac
modprobe brcmfmac
```
werkt verder nog niet....

06MAY18  Na opstarten is er een zwart scherm... wat gaat er mis... als er 
op de uitknop wordtgedruk, dan zie je dat Linux afgesloten wordt, er is 
dus iets niet pluis, maar wat...? #De oplossing lijkt een nieuwe 
installatie, en dan direct de juiste packages downloaden...
mkfs.ext4 /dev/mmcblk0p3
```
ip link set wlp1s0 up
ip link
```
output: wlp1s0 ... UP
```
wifi-menu
```
Voer alvast het wifi wachtwoord in
```
modprobe -r brcmfmac
modprobe brcmfmac
pacman -Syu
```
werkt niet, niet online, ook is de device niet meer aanwezig na ip link...

06MAY18 reboot en verder met de installatie...
```
ip link set wlp1s0 up
ip link
```
output: wlp1s0 ... UP
```
wifi-menu
```
Voer alvast het wifi wachtwoord in
```
ip link
```
output: wlp1s0 ... UP
```
pacman -Syy
```
veel foutmeldingen voor syncen.
```
nano /etc/pacman.conf
```
Toegevoegd (rest laten staan)
[gpd-pocket-arch]
```
SigLevel = Never
Server = https://github.com/joshskidmore/gpd-pocket-arch/raw/master
mrcmfmac
modprobe -r brcmfmac
modprobe brcmfmac
ip link 
```
Nu is de device aanwezig, en up.
```
pacman -Syy 
```
werk nog steeds niet.
```
ip link 
```
Nu is de device aanwezig, maar niet up. Maar weer up gezet:
```
ip link set wlp1s0 up
pacman -Syy 
```
werk nog steeds niet.
```
ip link
```
Nu is de device aanwezig, maar wel up.
modprobe brcmfmac
2 root wordt weergegeven
```
ip link
```
Nog steeds is de device aanwezig, en up.
```
pacman -Syy 
```
werk nog steeds niet.
```
modprobe -r brcmfmac
ip link 
```
Nu is de device compleet verdwenen....

exit
Weer in de root shell. Er is nog steeds geen wifi device....
reboot

De volgende keer maar met usb dongle proberen...

#### Kali linux op GPD pocket

kali-linux-rolling-pocket+20180207-1_oud.iso

Fn + NumLk Bestuur de muis met de keypad. linker muis knop: ) 
rechter: Del Scrol: - +

Fn+2 --> activeer profile #2. Indicator lights will flash twice.
Fn+Ctrl vasthouden 3 secondes om macro op te nemen. Indicator lights will flash slowly.
Klik op de toe te kennen macro knop. Indicator lights will flash quickly.
Voer de macro in. Indicator lights will continue to flash quickly.
Fn+Ctrl indrukken om opname te eindigen. Indicator lights will stop flashing.
De macro is opgenomen.

Fn+1: 0.02s delay
Fn+2 --> activeer profile #2. Indicator lights will flash twice.
Fn+Ctrl vasthouden 3 secondes om macro op te nemen. Indicator lights will flash slowly.
FN+1
Klik op de toe te kennen macro knop:a. Indicator lights will flash quickly.
Voer de macro in. Indicator lights will continue to flash quickly.
Fn+Ctrl indrukken om opname te eindigen. Indicator lights will stop flashing.
De macro is opgenomen.

13JAN19 nieuwe installatie op de GPD pocket, want update van Kali 
resulteerde in een niet werkend systeem.
De iso gedownload op https://whitedome.com.au/re4son/pocket-parrot/
en op een usb stick gezet.

```
sudo dd if=//home/archie/Downloads/Parrot-home-3.11-Re4son-Pocket_amd64.iso of=/dev/sdd status=progress
```

De GPD pocket aangezet en F7 ingedrukt, toen geboot via usb en Installation 
gekozen. Toen kwam er een old school installer (Debian). Daar doorheen 
gelopen.
root wachtwoord: het gebruikelijke
user: parrot
wachtwoord: het gebruikelijke
Het partioneren heb ik over de hele harde schijf gedaan met een enkele 
partitie en default settings.

in commandline update kernel:
```
wget -O re4son-pocket-kernel.tar.xz https://re4son-kernel.com/download/re4son-pocket-kernel-current/
tar xJf re4son-pocket-kernel.tar.xz
cd 4.1*
sudo ./install.sh
het verwijderen van de 
sudo apt-get install airgeddon
```

```
sudo apt-get update
sudo apt-get upgrade
```

tijdens de upgrade heb ik yes en yes gekozen (incl bootscreen) ipv default N
na reboot stond bootscreen gedraaid en werkt de wifi niet meer
dus de volgende keer niet yes yes kiezen...
wel werkt mijn alfa wifi adapter.
```
ip link
```
wlan0 is de alfa usb wifi... waar is de interne wifi...

25APR19. Wifi werkt nog steeds niet, wel alfa wifi adapter
```
sudo apt-get update
sudo apt-get upgrade
```


#### Install  i3 Arch op werk pc (december 2020), via dotfile en GIT
*Installatie* 
Eerst met dd de harde schijf gecomprimeerd en opgeslagen, zodat ik deze
terug kan zetten.
Daarna Arch linux via een USB drive geinstalleerd. Helaas ging dat niet zo
eenvoudig en heb ik het kunnen installeren via de USB drive na opstarten
en root account door het onderstaande script te downloaden (als root) en
het shell script te starten. Dit lijkt op de oude Arch installer:

```
wget archfi.sf.net/archfi
sh archfi
```

**

---
### Keebs

#### Ducky one mechanical keyboard

Fn + NumLk: keypad bestuurd de muis aan/uit Fn + NumLk. 
linker muis knop: 0 ins 
rechter: Del 
Scrol: - +

Fn+2 --> activeer profile #2. Indicator lights will flash twice.
Fn+Ctrl vasthouden 3 secondes om macro op te nemen. Indicator lights will flash slowly.
Klik op de toe te kennen macro knop. Indicator lights will flash quickly.
Voer de macro in. Indicator lights will continue to flash quickly.
Fn+Ctrl indrukken om opname te eindigen. Indicator lights will stop flashing.
De macro is opgenomen.

Fn+1: 0.02s delay
Fn+2 --> activeer profile #2. Indicator lights will flash twice.
Fn+Ctrl vasthouden 3 secondes om macro op te nemen. Indicator lights will flash slowly.
FN+1
Klik op de toe te kennen macro knop:a. Indicator lights will flash quickly.
Voer de macro in. Indicator lights will continue to flash quickly.
Fn+Ctrl indrukken om opname te eindigen. Indicator lights will stop flashing.
De macro is opgenomen.

#### Vortex 90M mechanical keyboard

!Programming/MacroGuideStep
1. Choose a layer (Pn+M, <,>key) where you want to edit the keycodes.
tep 2. HitPn + Left Ctrlto enter the programming mode (Capslock LED steadily litin green) 
Step 3. Select a desire key you want to program (Capslock LED flashingin green)
Step 4. Key-in the contents and then press Pn(CapslockLED steadily lit in green again) 
Step 5. Repeat step 2 and step 3 to program other keys.
Step 6. Press Pn + Left Ctrlto exit programming mode (CapslockLED off) 
More: Support Fn layer programming, you can select the Fn combination key 
(e.g., Fn + A) to program it Support time delay, press 15ms key (Fn + T) 
each time to delay 15ms, press 0.1s key (Fn + G) each time to delay 0.1s, 
press 0.5s key (Fn + B) each time to delay 0.5s. Consecutive delay will add 
up but will only be counted as 1 key stroke.
Every key can program up to 32 key strokes.If there is no key pressed for 15 sec 
in programming mode, it will back to normal mode.


#### Gergo mechanical ortholinear keyboard
I purchased a Gergo keyboard without switches. More details can be found on my
personal Github page about the keyboards.

Zomer 2020. Nieuwe poging om de firmware van de Gergo te updaten.
Nieuwe pc en nieuwe arch install zou misschien kunnen werken.

Ik heb de oude files gezet in ~/Downloads/Gergo_keyboard
online: https://qmk.fm/
daar heb ik geupload: noobmonkey.json
en op compile gedrukt.
Daarna download Full source gesaved op ~/Downloads/qmk_firmware-gergo-noobmonkey.zip
en download Firmware gesaved op: ~/Downloads/gergo_noobmonkey.hex

Winter 2020, verder gegaan, ook doordat het flashen vd redox zeer goed gaat,
dus hoopvol.....

qmk compile -kb gergo -km default
Als ik probeer te compilen krijg ik foutmelding van matrix.c ....
Ik ben niet tot flashen gekomen....

qmk flash -kb gergo -km Prutserdt 


#### Redox keyboard, falba teck (NOV2020)
Binnen gekomen 19NOV20.
Ik mis wel toetsen. geen rechter alt. dus dwm config aanpassen...
Eerst eens zien welke toetsen er standaar op zitten.

https://docs.qmk.fm/#/newbs_getting_started
Software geinstalleerd als beschreven en het volgende commando gestart:
python -m pip install --user qmk

echo 'PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc && source $HOME/.bashrc

qmk setup

Would you like to clone qmk/qmk_firmware to /home/icefly/qmk_firmware? [y/n] y]

Would you like to set /home/icefly/qmk_firmware as your QMK home? [y/n] y

Volgens mij heb ik dfu nodig dus ingevoerd:

sudo cp /home/icefly/qmk_firmware/util/udev/50-qmk.rules /etc/udev/rules.d/

Nu testen of compileren werkt met:
qmk compile -kb redox -km default
Ja het werkt!

Configureren build environment:
qmk config user.keyboard=redox/rev1
Github username erbij zetten:
qmk config user.keymap=Prutserdt

We zijn hier aangekomen:
https://docs.qmk.fm/#/newbs_building_firmware

create a new keymap:
qmk new keymap
Output:
Prutserdt keymap directory created in:/home/icefly/qmk_firmware/keyboards/redox/keymaps/Prutserdt
Compile a firmware with your new keymap by typing:
    qmk compile -kb redox/rev1 -km Prutserdt

nu kijken of ik kan flashen in linux.

qmk compile -kb redox/rev1 -km Prutserdt 

Nu flashen door eerst het board te resetten eerst links dan afzonderlijk rechts

qmk flash -kb redox/rev1 -km Prutserdt 

daarna opnieuw geflashed met:

qmk compile -kb redox/rev1 -km Prutserdt 

Na een pacman upgrade werkt qmk_cli niet meer. Wat is de Oorzaak?
Ik heb nu geen pip install gedaan maar:
yay qmk-git
En daarna (omdat dit package miste)
sudo pacman -S python-milc 


#### dwm
 ______        ____  __
|  _ \ \      / /  \/  |
| | | \ \ /\ / /| |\/| |
| |_| |\ V  V / | |  | |
|____/  \_/\_/  |_|  |_|

## Installatie
Procedure: https://www.youtube.com/watch?v=KaSuYdkV6Bg
Download de tarbal en run in deze directory in  terminal:
`tar -xvf ./dwm-6.2.tar.gz`
`make`
Nu is er een executable file gemaakt: dwm
Verplaats de bestanden naar de ~/dwm directory.
Maak directory "bin" aan in home directory:
`mkdir ~/bin`
Maak een symbolic link
`ln -s /home/icefly/dwm/dwm /home/icefly/bin/dwm`
Voeg toe aan bashrc:
`PATH="$HOME/bin:$PATH"`
Pas .xinitrc aan (exec dwm). Reboot en startx!

#!/bin/sh
#
# ~/.xinitrc
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#                               
# Modified by Prutserdt
# Executed by startx. 
#
```
xmodmap ~/.Xmodmap & # Use .Xmodmap for escape/Caps_lock change and Super_R to mod3
```
```
#
# Uncomment the next line to start i3wm and writes in the log:
#exec i3 -V >> ~/i3_log/i3log-$(date +'%F-%k-%M-%S') 2>&1

# give menu bar and start dwm
while true
do
#  xsetroot -name "`date +"%d%h%y %H:%M"` `amixer -c 1 get Master | sed '5!d'`"
# xsetroot -name "`amixer -c 1 get Master | sed '5!d'` `date +"%d%h%y %H:%M"`"
xsetroot -name "`awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master)` `date +"%d%h%y %H:%M"`"

sleep 1
done &
numlockx &
wal -i /home/icefly/Downloads/gekibbel.jpg
exec dwm
# if dwm exits 0, restart -- this allows hot reloading of config.h
while type dwm >/dev/null ; do dwm && continue || break ; done
```

## Vervang de huidige dwm installatie voor vanilla dwm: dwmrestore (staat in .bashrc)
Het commando "dwmrestore" geeft een vanilla install terug! Het kopieerd data.
alias dwmrestore="cp -i ~/Stack/dwm/dwm-6.2_200512_vanilla/* ~/dwm-6.2 && cd ~/dwm-6.2 && c && l"

## Maak symbolic link om eenvoudig te starten via startx (.xinitrc)
Let op: maak symlink aan in ~/bin. Vergeet niet dat het pad aan bashrc moet staan.
`ln -s -v /home/icefly/dwm/dwm /home/icefly/bin/dwm`
Of overschrijf een symlink:
`ln -f -s /home/icefly/Stack/dmw/dwmx /home/icefly/bin/dwm_x`
`ln -f -s /home/icefly/.config//dwm/dwm /home/icefly/bin/dwm`
Nu kun je via het executable kiezen in .xinitrc: exec dwm_vanilla voor startx.

## De laatste stabiele backup installeren:
## Vervang de huidige dwm installatie door: dwmstable (.bashrc alias)
Het commando "dwmstable" geeft een install van de laatste stabiele dwm versie terug!
Let op: LET OP DIT VERWIJDERD DE HUIDIGE VERSIE!!


```
# Automatische patching via de volgende .bashrc alias procedure:
# alias dwmpatch = "dwmstable && cp ~/dwm/config.h ~/dwm/config.def.h && rm ~/dwm/config.h &&
#                  patch -p1 < ~/Stack/dwm/patches/test/*.diff && make clean install"
# Stap 1: verwijdern files in test direcotory:
rm ~/Stack/dwm/patches/test/*
# Stap 2: Zet je diff file op de volgend locatie: ~/Stack/dwm/patches/test en run 
# Stap 3: run .bashrc alias:
dmwpatch
```

# Een complete walkthrough van een nieuwe installatie, vanuit vanilla (dwmvanilla)
#1: gridmode, via dwmpatch, werkt eenvoudig. :-)
#2: fakefullscreen, via dwmpatch :-)
#3: centered master. niet via dwmpatch. :-(. Onderstaande procedure werkt wel. :-)
dwmstable
Toevoeging aan config.def.h:
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
.....
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },
Daarna:
```
rm config.h
patch -p1 < ~/Stack/dwm/patches/test/*.diff
```
Foutmeldingen, maar gewoon doorgaan, rej en orig file verwijderen en:
```
make clean install
reboot: werkt!
```
#4: restartsig, via dmwpatch :-)
Let op pas aan de .xinitrc:
# if dwm exits 0, restart -- this allows hot reloading of config.h
```
while type dwm >/dev/null ; do dwm && continue || break ; done
```
#5: Verander modkey in ~/dwm/config.h:
Veranderen van modkey. 
define MODKEY Mod4Mask
```
cp config.h config.def.h
make clean install
```
Restart in place (super+ctrl+shift+q), dwmbackup
#6: defaulttransparency, werkt niet via  dwmpatch :-(
Toegevoegd aan config.def.h:
```
static const Bool topbar            = True;     /* False means bottom bar */
+static const double defaultopacity  = 0.75;
...
{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
+	{ MODKEY|ShiftMask,		XK_s,	   spawn,	   SHCMD("transset-df -a --dec .1") },
+	{ MODKEY|ShiftMask,		XK_d,	   spawn,	   SHCMD("transset-df -a --inc .1") },
+	{ MODKEY|ShiftMask,		XK_f,	   spawn,	   SHCMD("transset-df -a .75") },
```
Daarna:
```
rm config.h
patch -p1 < ~/Stack/dwm/patches/test/*.diff
make clean install
```
Restart in place (super+ctrl+shift+q), dwmbackup
hmmm hoe zit het eigenlijk, ik zie geen transparancy...
Helaas heb ik een dwmbackup gemaakt en zit deze nu in mijn stable built...
#7: attachbottom, werkt via dwmpatch :-)
```
dwmbackup
```
#8: (bottomstack.. dit is geen bruikbare patch en gebruik ik niet.)
#8: (Cyclelayouts. Cycle door de layouts met MOD-CTRL, handig, ga ik later
#8: installeren, gaat niet met dwmpatch.)
#8: Inplacerotate, gaat goed via dwmpatch.
Super handig voor cycling zonder dat de ordering veranders.
```
dwmbackup
```
#9: Sticky. werkt via dwmpatch :-). Handig, mod s om te togglen.
```
dwmbacup
```
#10: Swallow, werkt niet via dwmpatch. dwm.c moet je aanpassen:
```
+	int isfixed, isfloating, isurgent, neverfocus, oldstate, isfullscreen, isterminal, noswallow;
+	pid_t pid;
+	Client *swallowing;
+static pid_t getparentprocess(pid_t p);

+static int isdescprocess(pid_t p, pid_t c);
+	Client *c, *t, *term = NULL;
+	c->pid = winpid(w);
+		term = termforwin(c);
+	if (c->swallowing) {
+		unswallow(c);
+		return;
+	}
+
+	Client *s = swallowingclient(c->win);
+	if (s) {
+		free(s->swallowing);
+		s->swallowing = NULL;
+		arrange(m);
+	if (!(xcon = XGetXCBConnection(dpy)))
+		die("dwm: cannot get xcb connection\n");
+        focus(NULL);
+		return;
+	}
```
# Gelukt en saved dmv dmwbackup, plus een extra backup gemaakt dwm-6.2_stable_200517.

Transparancy werkt als je picom insteld in xinitrc:
# Start picom, for transparancy
```
picom -b
```

#fonts instellen
# font ingesteld voor config.def.h:
Aangepast in config.def.h:
orgineel:
```
static const char *fonts[]          = { "monospace:size=10" };
```
veranderd in:
```
static const char *fonts[]          = { "unifont:size=9" };
make clean install
```
Andere geinstalleerde en geprobeerde fonts:
```
inconsolata Dina profont ttf-monaco ttf-hack
```

# XF86XK buttons aanpassen
```
https://github.com/kusk/dwm/blob/master/config.h
/* commands */
	{ 0,			XF86XK_AudioRaiseVolume,   spawn,	       SHCMD("amixer -q set Master 5%+") },
	{ 0,			XF86XK_AudioLowerVolume,   spawn,	       SHCMD("amixer -q set Master 5%-") },
	{ 0,			XF86XK_AudioMute,	       spawn,	       SHCMD("amixer -q set Master toggle, NULL") }, 
    { 0,            XF86XK_Calculator,		   spawn,		   SHCMD("st -e bc -l") }, 
    { 0,            XK_Print,   		   spawn,		   SHCMD("xfce4-screenshooter") }, 

	{ MENUKEY,                      XK_u,      spawn,          SHCMD("cat ~/.config/unicode | dmenu -i -l 25 -fn unifont-10| awk '{print $1}'| xclip -selection clipboard") },
    /*{ MENUKEY,                    XK_w,      spawn,          SHCMD("ls ~/Stack/Afbeeldingen/Wallpapers/ | dmenu -i -l 20 -fn unifont-08| awk '{print $1}'| xclip -selection clipboard && wal -i "$(xclip -o -selection clipboard)"") },*/
```

# color emojis
Installeer: yay libxft-bgra
Open het bestand genaamd: drw.c. En verwijder het gedeelte over
iscol (do  not allow using color fonts). Doe dit ook voor dmenu, in
drw.c. Daarna werkt het helaas nog niet. Alleen een gedeelte van de
emojis zijn te zien en alleen in zwart-wit.
Ik heb ttf-ancient-fonts geinstalleerd maar helaas zie ik nog steeds geen
emojis.
```
noto-fonts-emoji
ttf-joypixel
ttf-symbola (geeft de eenvoudige monochrome fonts, niet installeren!)
```
Na de-installeren symbola zie ik emojis in dmenu!

26JUL20: emojis zijn al een tijd niet meer zichtbaar. Onduidelijk waarom....
ttf-symbola is niet geinstalleerd, zoals ik dacht dat het moest.
Ik heb vervolgens de volgende fonts geinstalleerd want ik wil ook emojis in st
```
terminal: https://github.com/LukeSmithxyz/voidrice/issues/284
ttf-symbola
```
Nu werkt dmenu unicode veel sneller, maar het is nog steeds niet in full color.
```
ttf-linux-libertine
```
Geen verschil na deze install
```
ttf-inconsolata 
```
Deze had ik al geinstalleerd
```
ttf-emojione
```
Helaas is het nog steeds monochrome.
Ik heb vervolgens in dmenu de font veranderd naar monochrome: geen verandering:
geen colored emojis.
Vervolgens de font in dwm op monospace gezet, maar helaas nog steeds geen
colored emojis....
Ik heb monospace als font gezet in : ~/.config/dmenuunicode.sh en ook het font
verwijderd, waarbij de default dmenu wordt gebruikt, maar....
Helaas, dit werkt ook niet.
Hierna heb ik dwm en dmenu weer hack als font gezet (en unicode zonder font
select, dus default dmenu font wat nu hack is)


#### st
     _   
 ___| |_ 
/ __| __|
\__ \ |_ 
|___/\__|
#st mijn eigen build!
# ik ga st in mijn dwm folder zetten en deze mee ontwikkelen met mijn huidige
# laten we kijken of dit goed werkt.

## Installatie en gebruik .bashrc aliases
Download de suckless.org tarbal en run in deze directory in  terminal:
```
tar -xvf st-0.8.3.tar.gz
make
```
Nu is er een executable file gemaakt: st. 
Verplaats de bestanden naar de ~/st directory.
Maak directory "bin" aan in home directory(als deze er nog niet is):
```
mkdir ~/bin
```
Maak een symbolic link
```
ln -s /home/icefly/st/st /home/icefly/bin/st
ln -s /home/icefly/Stack/st-0.8.3_vanilla/st /home/icefly/bin/st_vanilla
```
Voeg toe aan bashrc (hoeft niet als hij er al is):
```
PATH="$HOME/bin:$PATH"
```

#### dmenu
error na starten van dmenu_run
```
/home/icefly/bin/dmenu_run: line 2: dmenu_path: command not found
```
Ik heb daarna dmenu_path als symlink toegevoegd
```
ln -s -v /home/icefly/dmenu/dmenu_path /home/icefly/bin/dmenu_path
```
Helaas werkt dit niet, nog steeds dezelfde foutmelding, verkeerde directory...
Verwijderen symlink:
```
rm dmenu_path
```
Nieuwe symlink:
```
ln -s -v /home/icefly/suckless/dmenu/dmenu_path /home/icefly/bin/dmenu_path
```
Helaas, werkt nog niet, maar..... een andere dezelfde foutmelding:
```
/home/icefly/bin/dmenu_run: line 2: /home/icefly/bin/dmenu_path: Permission denied
```
Opgelost door met het script ~/.config/dmenuapps.sh:

#!/bin/sh

# Script to open applications (~/.cache/dmenu_run) by dmenu.
# It opens: ~/.cache/dmenu_run
# This required the dmenu patch: center, which gives the dmenu -c option.
```
cat ~/.cache/dmenu_run | dmenu -i -c -l 30 | ${SHELL:-"/bin/sh"}
```
Probleem is dat nieuwe apps nu niet bij dmenu_run worden toegevoegd.
Doe dat door eerst de file te deleten:
```
rm ~/.cache/dmenu_run
```
Daarna de lijst opnieuw te maken:
```
ls /usr/bin/* > ~/.cache/dmenu_run
```
En handmatig de appimage toevoegen:
```
sed -i '1 i /home/icefly/Downloads/stack-2.6.5-20200909-x86_64.AppImage' /home/icefly/.cache/dmenu_run
```
Dit allemaal tegelijk:

rm ~/.cache/dmenu_run ;ls /usr/bin/* > ~/.cache/dmenu_run; sed -i '1 i /home/icefly/Downloads/stack-2.6.5-20200909-x86_64.AppImage' /home/icefly/.cache/dmenu_run

Het bovenstaande werkt, maar wel met directory structuur wat lelijk is maar
verder geen probleem.
