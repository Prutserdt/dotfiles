<!Modified by Prutserdt, /home/archie/Stack/Command_line/>
          _     _                    _        _      _        
         | |   (_)_ __  _   ___  __ | |_ _ __(_) ___| | _____ 
         | |   | | '_ \| | | \ \/ / | __| '__| |/ __| |/ / __|
         | |___| | | | | |_| |>  <  | |_| |  | | (__|   <\__ \
         |_____|_|_| |_|\__,_/_/\_\  \__|_|  |_|\___|_|\_\___/
---
### Inhoud 
#### Command line tricks
* Rechten bestanden
* Grafische problemen
* Logging
* Linux keyboard shortcuts
* Batch rename image files
* PACMAN/YAOURT/YAY
* WIFI
* VNC (controle van desktop van buitenaf, oa android phone
* Manipuleren van GE UNICORN files
* Bluetooth instellen
* VPN
#### Applications (Command line and GUIs)
* Vim
* Nano
* Octave
* Git (en dotfiles procedure)
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
     
**more** command. Een ander manier om grote files te laten zien
more longfile.txt
cat longfile.txt | more

Op systemen waar **root user disabled** is, bijv. Ubuntu. Dan kun je 
toch inloggen door gebruik te maken van: `sudo -s`

**Start gnome** programma (wireshark, gparted, unetbootin); `gksu gparted WIFI`

**Switch user**. Ga naar juiste home directory: `su username`.

Vindt alle **system users**: `compgen -u`

Herstart het systeem: `sudo reboot`

Midnight Commander als super user gebruiken, bijvoorbeeld voor het 
wegschrijven op de 1 Terabyte drive: `su` en daarna `mc`.

Vind de **beeldscherm resolution**: `xdpyinfo | grep dimensions`

Afsluiten systeem, direct:`sudo shutdown -h now`
Afsluiten systeem over 15 minuten:`sudo shutdown -h 15`
Stel je wilt toch afsluiten terwijl je de afsluit timer hebt gezet: `sudo shutdown -c`

**bleachbit**. Schoonmaken van het systeem. Je kunt kiezen welke files van 
welke apps je  wilt wissen: `bleachbit`

Probleem: te weinig capaciteit tmp dir, en virtueel geheugen. Ccheck verdeling van geheugen:`df -H`

Vergroten tmp directory: sudo mount -t tmpfs tmpfs /tmp -o size=2000M,mode=1777,remount

Bekijk routers naar adres met: mtr: `mtr --report-wide --curses www.google.com`

geeft usb devices weer
lsusb

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

#### Multiple linux distros on one USB:
Hiermee kun je meerdere USB  distros op een enkele pendrive zetten :-)
```
yay multibootusb-git
sudo multibootusb
```
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

Schrijf de iso weg: `echo "That would be $(expr $blocks / 512) MB"`
`dd if=/dev/sr0 of=isoimage.iso bs=2048 count=$blocks  status=progress`
Eenvoudiger (externe harde schijf iso)
`sudo dd if=/dev/sdc of=MacCindy.iso status=progress`

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
`echo "Welcome back commander"`
Geeft arch logo in asci art plus wat extra info: `screenfetch`
Welkom tekst voor login venster: `sudo nano etc/issue`
Voeg bijvoorbeeld deze tekst toe:
```
|-----------------------------------------|
|        Welcome back commander           |
|-----------------------------------------|
|                                         |
| User:        archie/vanilla             |
|                                         |
| Start xfce4: startxfce4                 |
| Start i3:    startx                     |
|                                         |
|-----------------------------------------|

Arch Linux \r (\l)
```

Roteren van het scherm (0,1,2,3 zijn de richtingen, of left/right/normal)
```
xrandr -o 1
xrandr -o right
zoeken connected displays
xrandr --query
```
Specifieke setup in Synthon, twee monitoren, breedbeeld in A4 en extra beeldscherm,
gecorrigeerd voor hoogte
`xrandr --output VGA-1 --mode 1280x1024 --pos 1050x195 --output DP-1 --mode 1680x1050 --rotate left --pos 0x0`

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

Firefox customization: verander skins per website met Stylish

Change system time: `timedatectl set-time "2017-01-06 22:27:49"`

Check time: `sudo hwclock --debug`

Probleem gehad met een uur tijdsverschil, opgelost met: `timedatectl set-ntp true`

View all the groups: `cat /etc/group`
Bekijke groups van enkele user: `groups icefly`

add group (audio) to user (icefly): `sudo gpasswd -a icefly audio`

Check running programs/close programs.
see processes:
ps waux
find PID of program:
pidof firefox
ps aux | grep  firefox
(tweede kolom is PID, je kunt trouwens zoeken met wildcards*)
sudo kill -9 <ur process id> 
sudo killall firefox

MD5: `md5sum file.txt`

Video fragment cutting. T: begin in seconden. D: lengte van clip in sec:
```
ffmpeg -i input -ss T -t D -c copy -fflags +genpts output
ffmpeg -i Film.mp4 -ss 309 -t 105 -c copy -fflags +genpts Filmpje.mp4
Frame by frame (Duurt wel langer. Als het bovenstaande niet goed werkt.):
ffmpeg -i Film.mp4 -ss 308 -t 111 -fflags +genpts Filmpje.mp4
```
Vind de code van keys van keyboard (toetsenbord): `xev`
     
#### Rechten bestanden
     
Bekijk rechten: `ls -l` `ls -a -l`
Bekijk hidden directories
`ls -a`
uitleg output:
r: read, w: file can be modified, x: file can be executed, s:setUID bit, t: sticky
voorbeeld:
-rw-r--r-- 1 root   root    426 Feb 13 14:21 info
- : een file, want directory geeft de letter: d
rw: owners permission: read and write
r: groups permission: read
r: all the other users
root: gebruiker
root: groep
Verander rechten directory naar 
chmod u=rwx filename
chmod go=rx filename
chmod 755 Afbeeldingen
chmod 755 test.py nu is het executable
Verander ownership file met chown
chown archie filename
Bulk verander rechten, incl. subdirectories :-)
find Afbeeldingen -type d -exec chmod 755 {} +

Aanmaken directory voor meerdere users (in dit geval, DATA in /home) 
sudo groupadd project
sudo usermod -a -G project icefly
sudo usermod -a -G project synthon
sudo chgrp -R project /home/DATA/
sudo chmod -R 2775 /home/DATA/ 
     
Grafische problemen
     
     Check grafische kaart
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
     
#### Logging
     
journalctl
Zoeken in tijd
journalctl -b  #current boot
journalctl --since "2017-02-11 17:00:00"
journalctl --since "2015-01-10" --until "2015-01-11
        03:00"e
journalctl --since yesterday
journalctl --since 09:00 --until "1 hour ago"
Zoeken op unit
journalctl -u nginx.service
journalctl -u nginx.service --since today
journalctl -u nginx.service -u php-fpm.service --since
        today
Zoeken op process, users, groupID
journalctl _PID=8088
journalctl _UID=33 --since today
Kernel messages
journalctl -k #from the current boot
journalctl -k -b -5 #messages from 5 boots ago
Zoeken naar fouten -p=sort by priority
journalctl -p err -b #Gives all error, critical, alert, or
        emergency. 

Log live volgen:
journalctl -f

groote log
journalctl --disk-usage

De command line history staat hier: /home/icefly/.bash_history
Zoeken in de history naar bijv. ssh gaat alsvolgt:
ctrl R
history | grep ssh
cat
Maak text bestand aan, daarna typ je text en sluit je met CTR+z om te
saven.
cat > text.txt

     
#### Linux keyboard shortcuts
Lijstje met allelei keyboard shortcuts.

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
    Ctrl Shift Z                    Redo a change that you just undid 

    Terminal shortcuts:
    Ctrl a				Ga na begin van de line (in bijv. Nano)
    Ctrl e				Ga na het einde van de line (in bijv. Nano)
    Ctrl c				Kill process in terminal
    Ctrl z				Zombie an application in a terminal, dit geeft de terminal terug en de applicatie is niet afgesloten. Het proces komt terug door het typen van "fg".
    Ctrl r				Zoek in de command line. Type een woord dat je zoekt.

    Firefox shortcuts
    Ctrl                            Open a new tab
    Ctrl Tab                        Rotate through each tab
    Ctrl Shift                      TabRotate backwards through each tab
    Alt Left                        Page Back
    Alt right                       Page Forward
    Ctrl b				Show a list of your bookis
    Ctrl h				Show your browsing history
    Ctrl k				Enter a new web search in the search bar
    Ctrl y				Show a list of downloaded files
    Ctrl r				Reload the current page 
    Ctrl p				Open a private window
    F11				Display the current page full-screen
    Esc				Stop loading the current page

     
#### Batch rename image files

Batch rename. Verander de naam van bestanden. Zet eerst de foto's in 
directories met nummer van dag v.d. vakantie en lokatie. Ga in de main 
directory. Dit scriptje VERPLAATST alleen bestanden uit de directory naar
de main directory met als begin de naam van de directory waar het in stond
start=$PWD
for directory in *; do
  cd "$directory"
  for filename in *; do
    mv "$filename" ../"$directory$filename"
  done
  cd "$start"
done
In command line:
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do mv "$filename" ../"$directory $filename"; done; cd "$start"; done

Batch rename. Verander de naam van bestanden. Zet foto's in directories met nummer van 
dag v.d. vakantie en lokatie. Ga in de main directory. Dit scriptje KOPIEERD alle 
bestanden uit de directory naar de main directory met als begin de naam van de 
directory waar het in stond.
PWD = print working directory
start=$PWD
for directory in *; do
  cd "$directory"
  for filename in *; do
    cp "$filename" ../"$directory$filename"
  done
  cd "$start"
done

In command line:
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do cp "$filename" ../"$directory $filename"; done; cd "$start"; done

rename all files in all directories....

start=$PWD
for directory in *; do
  cd "$directory"
  for filename in *; do
 for i in $(ls *.*); do exiv2 -r '%Y%m%d-%H%M-:basename:' rename $i; done
  done
  cd "$start"
done

In command line:
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do exiv2 -r'%Y%m%d_%H%M_:basename:' rename $(ls); done; cd "$start"; done
start=$PWD; for directory in *; do cd "$directory"; for filename in *; do exiv2 -r'%Y%m%d_:basename:' rename $(ls); done; cd "$start"; done

start=$PWD; for directory in *; do cd "$directory"; for filename in *; do for i in $(ls *.*); do for i in $(ls *.*); do exiv2 -r '%Y%m%d-%H%M-:basename:' rename $i; done; done; cd "$start"; done

werkt redelijk, maar niet super want de tijd wordt 3 keer herhaald (original+digitized+modified) Haakjes in naam werkt niet. .mov --> no exif data found in the file. 
for i in $(ls *.*); do exiv2 -r '%Y%m%d-%H%M-:basename:' rename $i; done

Find datum van foto metadata:
identify -format %[EXIF:DateTimeOrginal]
        IMG_1923.JPG

Kopier bestand in dezelfde directory met andere naam:
cp IMG_1923.JPG test.JPG

Vind datum van foto en gebruik dit voor het hernamen van de foto (test.jpg
--> 20150516-1935_test.jpg)
werkt goed. metadat blijft intact.
exiv2 -r'%Y%m%d-%H%M_:basename:' rename $(ls)

#### PACMAN/YAOURT/YAY    
     
Info staat in /etc/pacman.conf en /etc/pacman.d/mirrorlist
Yaourt --> pas pacman.conf aan, toelaten van franse server:
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
==> Pacman is currently in use, please wait.
sudo rm /var/lib/pacman/db.lck
update
yaourt -Syu
sudo pacman -Syu
yaourt -Syyu --debug
To remove a package, which is required by another package, without 
removing the  dependent package:
yaourt -Rdd
Als een file corrupted is, dan forceer het opnieuw installeren:
yaourt -S --force

Ignore package, stel dat een package een probleem geeft, dan kun je dit
ignoren...
sudo pacman -Syu --ignore fontconfig

Forcefull install package (liever niet forceren, alleen bij uitzondering)
sudo pacman -S --force packagename 
Installeer alles geforceerd, alleen bij uitzondering, zorg voor een 
volledige backup van het systeem voor de zekerheid
sudo pacman -Syu --force 

For recursively removing orphans and their configuration files
sudo pacman -Rns $(pacman -Qtdq)

number of applications
sudo pacman -Q | wc -l
sudo pacman -Qet | wc -l
all apps:
sudo pacman -Qe
check orphan packages
sudo pacman -Qdt  
Remove the application + orphan packages
sudo pacman -Rns packagename  
combineren van bovenstaande 2 commands, verwijderd automatisch de orphan 
packages
sudo pacman -Rns $(pacman -Qdtq)

opschonen cache en outdated packages
sudo pacman -Scc
pacman icoontje bij downloaden repo's. Zet in misc. gedeelte:
ILoveCandy
grafische info over pacman
sudo pacman --version
Display clever insults when an incorrect password is entered instead of
printing the default "wrong password" message. Find /etc/sudoers and 
append "insults"
sudo nano /etc/sudoers
Defaults specification
Defaults insults
Cleaning package cache

26JUN19: overgestapt van Yaourt naar YAY, omdat yaourt niet meer 
onderhouden wordt. Installatie:
sudo git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
Update het hele systeem
yay -Pw #print nieuws, als het er is
yay -Syu #Hetzelfde als alleen yay gebruiken! Dus -Syu hoef je niet te
gebruiken
De help functie
yay --help
man yay
Zoeken beschikbare packages
yay -Ss spotify Geeft een lijst van AUR plus officiele
        packages
Installeren van bekende package
yay -S spotify
packages
yay spotify

#### WIFI            

Find names of network devices
sudo ip link
ip addr show laat ip addres zien (en andere
        info)
Discovery of access points
iwlist wlan0 scanning | less
Check current mac adress
ip link show eth0
Bring network interface down
ip link set dev eth0 down
Change mac adress
ip link set dev eth0 address XX:XX:XX:XX:XX:XX
Bring network interface back up
ip link set dev eth0 up

mac adress vast internet desktop pc
eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT qlen 1000
link/ether 00:1a:4d:5d:fe:4c brd ff:ff:ff:ff:ff:ff
Mijn ip address 82.174.98.248

sudo ip link set dev eth0 down
sudo ip link set dev eth0 address 00:23:4E:00:00:00
sudo ip link set dev eth0 up
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
sudo chmod 700 ~/.vnc
vncserver
of
vncserver -geometry 1920x1080 -alwaysshared -dpi 96-localhost :1
Mobieltje het lukt om in te loggen zonder ssh met androidVCN:
192.168.31.100:1 geeft login.. geen ssh
stoppen server
vncserver -kill :1
Vinden open vnc applicaties 
ps -A |grep vnc
kill -SIGKILL <PID>
kill -9 <PID>
Running directly from X0vncserver (werkt ook!)
x0vncserver -display :0 -passwordfile ~/.vnc/passwd
Aanpassen wachtwoord (ww in keepass)
vncpasswd
82.174.98.248
    Configure the target computer's router to forward port 5900.
    Look up the target computer's public (external) IP address.
    Enter the public IP address in VNC Viewer to establish a connection.

#### Manipuleren van GE UNICORN
Installeren van packages die nodig zijn (oa een hex editor)
sudo pacman -S python2-pip python-pip python2-matplotlib python2-xlsxwriter 
sudo pacman -S python-matplotlib python-xlsxwriter ghex
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
nano /home/synthon/Downloads/PyCORN-master/pycorn/docs/RES_files_layout.txt
nano /usr/lib/python3.6/site-packages/pycorn/docs/RES_files_layout.txt

Structure of sensor data
8 bytes per pair
4 bytes sig/int	Accumulated volume, divide by 100 to obtain value in ml
4 bytes sig/int	Sensor value, divide by 1000/100/10 depending on sensor
type. 

Bekijken file:
ghex /home/synthon/Downloads/PyCORN-master/samples/sample1.res
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
Daaro blueberry, met gui, geinstalleerd

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
Het probleem is dat ik geen secure core configs kan dowloaden. Er werd
aangegeven dat er drie servers beschikbaar waren voor de gratis versie. 
Maar waar kan ik deze vinden en hoe krijg ik een config file....
Aangemeld voor protonmail...

20JAN19. VPNbook op mijn VPS getest
sudo apt-get update
sudo apt-get install network-manager-openvpn
Ga naar rechtsonder network manager, add connection, vpn, import a saved
VPN configuration. Gekozen: vpnbook, de4 server


Automatiseren van 200 muis klikken om de 50 ms:
xdotool click --delay 50 --repeat 20 1

---
### Applications (Command line and GUIs)

#### Vim
Installeer gvim, niet om te gebruiken maar om clipboard functionaliteit
te kunnen gebruiken :)
sudo pacman -S gvim

Kleuren in vim
Vind het filetype die vim heeft gedetecteerd:
:verbose setlocal syntax? filetype?
Verander tijdelijk de syntax naar conf type:
:set syntax:conf

 Vim plugins beheer ik via Vundle
yay vundle-git
 volg de manual op github: clone de repo en voeg de toe aan ~.vimrc zoals
  beschreven in de manual.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
 Je zet de plugin in .vimrc en installeerd plugins in Vim via:
:Plugininstall
Helaas werkt het niet als ik op CTR-P druk, er wordt wel een command gegeven:
:call Vim_Markdown_Preview()
 maar er opent geen webpage.

De manual, ook te openen in vim met :help 
man vim
Personificeer vimrc
vim ~/.vimrc

My personal manual :)

Switching modes:
```
Esc     : Exit open mode
i       : Insert mode
I       : Insert mode, en ga naar het begin van de regel
A       : Insert mode, en start aan het einde van de regel
a       : Insert mode, en start 1 cursor stap naar rechts
v       : Visual mode
V       : Visual line
```
Navigation(direct commands):
```
h       : left
j       : down
k       : up
l       : right
CTRL+b  : page up
CTRL+f  : page down
CTRL+e  : scrolls down (snelheid kun in in ./.vimrc instellen)
CTRL+y  : scrolls up (snelheid kun in in ./.vimrc instellen)
CTRL+f  : scrolls down one page
CTRL+b  : scrolls up  one page
H       : verplaats cursor naar top pagina
M       : verplaats cursor naar top pagina
L       : verplaats cursor bodem van de pagina
gg      : verplaats cursor naar start document
G       : verplaats cursor naar einde document
z       : ?
e       : verplaats naar einde van het woord (einde: volgende woord)
b       : verplaats cursor naar einde van het woord (einde: volgende woord)
w       : verplaats volgend woord
A       : einde van laatste woord
```
Modifiers
```
i       : inner
s       : surround
p       : paragraph
.       : perform the last
```
Search stuff
```
/string : search string. 
n       : next word
N       : previous word
```
Replace stuff
```
r       : Replace a single character
R       : Replace until we tell it to stop
c       : Changes whatever specified (modifier)
C       : Changes until the end of a line
```
Delete stuff
```
x       : Delete single character after the cursor
X       : Delete single character before the cursor
d       : delete whatever specified (modifiers)
D       : delete until the end of the line
```
Yank (copy) stuff
```
y       : yanks whatever specified (modifiers)
Y       : yanks current line completely

:reg    : Show the register
"aY     : Yank line to register B
```
Pasting stuff
```
p       : pastes from vim buffer after cursor
"ap     : paste  from registry entry a (:reg)
```
Working with macros
```
qa      : Record a macro and save it to register a
q       : Stop recording macro
1@a     : Play 1 time macro a (:reg)
```
Editing an existing macro(in dit geval a)
```
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

Voorbeelden
```
4w      : 4 woorden verder
6k      : 6 regels omhoog
d2w     : delete the next two words
ciw     : change inner word
ysiw"   : Onduidelijk wat ik hiermee kan doen ... ?
```
Navigation(command combination examples):
```
???    : verplaats cursor naar lijn nummer 42
???    : verplaats cursor 10 lijnen omhoog
```
Doornummeren voorbeeld. Maak van dit:
```
[00:01.24]
[00:00.24]
[00:00.24]
[00:00.24]

```
Het volgende:
```
[00:01.24]
[00:01.24]
[00:01.24]
[00:01.24]
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

#### Ranger (terminal filebrowser)

Instellen van image preview in ranger.
https://github.com/ranger/ranger/wiki/Image-Previews
Installeer w3m web browser. En voeg
sudo pacman -S w3m
Voeg toe "set preview_images true" aan ~/.config/ranger/rc.conf
nano ~/.config/ranger/rc.conf
Tips voor gebruik Ranger
Stoppen is net als VIM, 
:q!
Ranger manual (je kunt ook ranger man gebruiken :-)
z 
zh #toggle hidden files on/off
zd #sort directives first

#### figlet
Maak asci word art van een woord in command line
sudo pacman -S figlet


#### vifm
Een terminal file manager die gebruikt maakt van VI bindings :-)
Ik heb van Distro Tube de volgende twee files toegevoegd aan 
vi ~/.config/vifm/scripts/vifmimg
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
    vi ~/.config/vifm/scripts/vifmrun
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

Wat je ook nodig hebt is het python script Ueberzug
yay python-ueberzug
Om alles te laten lopen moet je het script ~/.config/vifm/scripts/vifmrun
starten.
Verander de rechten van het bestand om executable te maken
chmod u=rwx vifmrun
Bekijk rechten
ls -a -l

less longfile.txt
test


Nu start je het script door in te voeren.  ~/.config/vifm/scripts/vifmrun
./vifmrun
opmerking: ik zie geen enkele preview....
opmerking: er is geen transparancy...
opmerking: files worden niet juist geopenE; niet leesbare afbeeldingen # opmerking: 
opmerking: vifmrun: export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"
opmerking: deze directory bestaat niet... Er klopt iets niet
opmerking: wel ik ueberzug geinstalleerd: mod+d laat het zien
opmerking: 
opmerking: 

    

#### urxvt (lightweight terminal). Kleurenschema kun je met pywal instellen :-)

Make Xdefault file, typ regel en druk op CTR+z
cat > .Xdefaults
Open nano
nano ~/.defaults
Plak daarin de onderstaande regels om de transparantie en font in te 
stellen, plus extra's die in de comments worden beschreven.
 Created to rice the urxvt terminal.

 Set transparancy

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

#### cmus. Terminal musicplayer
Begin door het toevoegen van een direcotory, waar het prog. muziek in gaat
zoeken.
:add ~/Stack
Het programma heeft VIM bindings. Type 7 om de keybindinglijst te zien:
7
j:
k:

the j and k keys.

#### cava
Een audio visualizer voor in de commandline.
yay cava

#### Pywal.
Een script die in commandline van een foto een colorscheme maakte van
16 kleuren. Dit wordt de Xdefault. Op deze manier kun je eenvoudig switchen.
Installeer het script:
sudo pacman -S python-pywal
Destilleer de kleuren uit de wallpaper, deze veranderd ook direct de 
wallpaper :-)
wal -i women-arch-linux-wallpaper.jpg
wal -i wallpaper2.JPEG

#### Nano
Pid van nano in gebruik... heel irritant als je bijv.
´sudo nano /etc/ssh/sshd_config´  wilt aanpassen. Als het verwijderen van
de PID niet werkt (zie allerlei), dan verwijder de swapfile. Deze staat 
in de directory van het bestand dat je wilt openen dus in dit geval:
´cd /etc/ssh´ ´ls *.swp´ ´sudo rm .sshd_config.swp´ of direct:
sudo rm /.sshd_config.swp
Dit werkt in Ubuntu 16.10 (mijn VPS)

#### Octave
Geinstalleerd via pacman. Octave-forge packages geinstalleerd via Octave met de
onderstaande commando's in Octave. Helaas mis ik Matlab functionaliteit, ook in
het statistics pakket :(.
```
pkg install -forge io
pkg install -forge statistics
```
#### Git (en dotfiles procedure)
Instellen Git
```
git config --global user.email "walter@elffrink.nl"
git config --global user.name "Prutserdt"
```
Zorg dat je in de /dotfiles directory staat!
```
git remote add dotfiles https://github.com/Prutserdt/dotfiles.git
git push dotfiles
git push --set-upstream dotfiles master
```
Nu wordt voor username en wachtwoord gevraagd en daarna werkt het!

Automatisch wegschrijven van dotfiles in Github.
Dit gaat via de procedure van https://www.atlassian.com/git/tutorials/dotfiles
en https://www.youtube.com/watch?v=tBoLDpTWVOM.
Aanmaken van de bare repository op de locale pc:
```
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no
```
Je kunt nu dotfiles toevoegen of direct committen via:

```
config add .bashrc
config commit -m "Add my .bashrc"
config push

config add .bashrc .Xmodmap
config commit -m "Add my .bashrc"
```

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
sleep 5
wmctrl -r dt5 -b add,skip_pager,skip_taskbar 
monitorix 
(yaourt -S monitorix, vorige keer niet geinstalleerd)
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
~/.config/xfce4/xfconf/xfce-perchannel-xml\xfce4-keyboard-shortcuts.xml
```
Maximize window									Alt+5
Tile window to the top								Alt+8
Tile window to the bottom							Alt+2
Tile window to the left								Alt+4
Tile window to the right							Alt+6
Tile window to the top-left							Alt+7
Tile window to the top-right							Alt+9
Tile window to the bottom-left							Alt+1
Tile window to the bottom-right							Alt+3
```
Aanmaken van keyboard shortcuts
XFCE4-Settings-Keyboard --> Application shortcuts
(Ook dit staat in de text file die hierboven staat, maar dat is minder goed leesbaar)
sh -c "mousepad && thunar "							Twee commands :-)
mousepad /mousepad /home/archie/Stack/Command_line/commands_2018_12_31.txt	Ctrl+Alt+M
firefox	https://facebook.com							Ctrl+Alt+F
firefox https://webmaileu.synthon.com/OWA/					Ctrl+Alt+S
firefox firefox https://login.yahoo.com						Ctrl+Alt+Y
thunar sftp://icefly@149.210.233.43/home/icefly/Downloads/			Ctrl+Alt+T
amixer set Master 5%-								XF86AudioLowerVolume
amixer set Master 5%+								XF86Audiomute
KCalc										XF86Calculator

sh -c "xfce4-terminal --title=ssh_icefly@149.210.233.43 --geometry=93x29+1420+0 && thunar sftp://icefly@149.210.233.43/home/icefly/Downloads/"	Ctrl+Alt+I

Gebruik autokey voor assignen van macros aan keys (zoiets als autohotkey)
yaourt -S autokey

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
cp -r /etc/xdg/xfce4 /home/archie/.config
Daarna xfce4 gedeinstalleerd, en opnieuw geinstalleerd:
sudo pacman -Rdd xfce4
sudo pacman -Rdd xfce4-panel
sudo pacman -Rdd xfconf
$ Probleem nog niet opgelost helaas :-(.
$ Oplossing: verwijder als super user, via mc de xfce4 cache files!
~/.cache/sessions

#### Thunar
Settings Manager (XFCE, vanuit superbutton)--> Settings Editor --> thunar
Hier kun je last-separator-position aan/uitzetten.
Of, veel simpeler, klik op CTR-M om het menu aan/uit te zetten in de Thunar 
balk.

Edit mp3 tags in Thunar, door onderstaande plugin:
sudo pacman -S  thunar-media-tags-plugin
     
#### i3 window manager   
     
Tips: https://www.youtube.com/watch?v=8-S0cWnLBKg

Nieuwe installatie:
sudo pacman -S ill3 dmenu feh
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

Pas het i3status.conf file aan, save het in de user directory voor gebruik 
voor alleen deze gebruiker
Ik heb de iPv6, Wireless en de battery status uitgevinkt met #.
```
mkdir .config/i3status
cp /etc/i3status.conf .config/i3status/config
nano .config/i3status/config
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
lock        Caps_Lock (0x42)
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

To do list:
pagina 2 wil ik monitors op vaste plaatsen zetten...
Links boven: command line
$mod+enter
Linksonder monitoring:
glances 
Rechter helft laat de 'live' log zien:
tail -f -s 4 ~/i3_log/i3log-2019-07-25-21-09-49 4 sec updates
find  ~/i3_log/i3log-2019-07-25-21-09-49 -type f -mmin -10 -exec tail -f {} +
find  ~/i3_log/ -type f -mmin -10 -exec tail -f {} +

De output van de log (laatste bestand in ~/i3_log en laatste entries)
Dit niet toevoegen: nload -a 3000, sudo iftop, htop sudo jnettop
* de border iets minder fel wit maken dan hij nu is
* In de config een keybinding maken die een script runt die door wallpapers
  cycled,
* automatisch achtergrond veranderen en kleurenpallet
* maak een  wal -i walpapernaam script

#### Install on persistent USB feb2017                    
     
Twee partities aangemaakt in GPARTED: 12.6 GB ext4 en 2.1 GB FAT32
sudo mount /dev/sdd1 /mnt
Create mount points for any remaining partitions and mount them accordingly,
for example:
sudo mkdir /mnt/boot
sudo mount /dev/sdd2 /mnt/boot
Installeer scripts (oa pacstrap) indien nodig
yaourt -S arch-install-scripts
pacstrap het basissysteem naar de usb stick (/mnt)
sudo pacstrap /mnt base
Generate an fstab file (use -U or -L to define by UUID or labels, respectively):
genfstab -U /mnt >> /mnt/etc/fstab
Check the resulting file in /mnt/etc/fstab afterwards, and edit it in case of errors.
Change root into the new system:
sudo arch-chroot /mnt
Set the time zone:
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
Run hwclock(8) to generate /etc/adjtime:
hwclock --systohc
Set the LANG variable in locale.conf(5) accordingly, for example, 
in Nano toevoegen: LANG=en_US.UTF-8:
nano /etc/locale.conf
hostname aanmaken
echo USBdistro > /etc/hostname
Set the root password:
passwd
Install syslinux
pacman -S syslinux
syslinux-install_update -i -a -m
Pas de sda drives aan in /boot/syslinux/syslinux.cfg
Install XFCE4
pacman -S xfce4
Exit chroot en reboot.
Hmmmm, na inloggen starte linux mint op en liep daarna vast...
aangepast:
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

Let op: de laatste backup is gemaakt op 30DEC18.
(er is sinds 20JUL17 een tweede useraccounts en setup voor bij Synthon).

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
sudo service ssh start
ssh-keygen -t rsa #geen passprase

genereer keygen op thuis computer
ssh-keygen -t rsa #geen passprase
verstuur nu vanuit thuis computer de key naar de host:
ssh-copy-id icefly@149.210.233.43
nu moet je wachtwoord vd server intypen.. 
(daarom staat passwordauthentificatino aan!)
PAS DAARNA naar de server sshd_config aanpassen, backup maken van file
Verander in sshd_config:
sudo nano /etc/ssh/sshd_config
PasswordAuthentication no
LoginGraceTime 60
AllowUsers archie icefly
Verander de MaxStartups niet want dit kan in errors resulteren, in mijn geval 
bij MaxStartups 3:50:10

Instellen server in Thunar filebrowser
     
     Instellen link in thunar filebrowser
     Eerst in commandline
ssh icefly@149.210.233.43
Daarna in thunar, network
sftp://icefly@149.210.233.43/home/icefly/
     
Ubuntu updaten
Via ssh het ubuntu systeem updaten, of via de https console:
sudo apt-get update        Fetches the list of available updates
sudo apt-get upgrade       Strictly upgrades the current packages
sudo apt-get dist-upgrade  Installs updates (new ones)

SSH problemen
Mijn probleem was:
If you had previously generated an SSH key pair, you may see a prompt that 
looks like this:
/home/username/.ssh/id_rsa already exists.
Overwrite (y/n)?
If you choose to overwrite the key on disk, you will not be able to authenticate using 
the previous key anymore. Be very careful when selecting yes, as this is a destructive 
process that cannot be reversed.

Oplossing: op beide kanten openssh uninstallen, client en server. 
Files op ~/.shh verwijderen aan beide kanten.
Opnieuw installeren beide kanten. Daarna aan beide kanten keygen doen:
ssh-keygen -t rsa
Alleen op lokale pc:
ssh-copy-id icefly@149.210.233.43
Nu moet je wachtwoord vd server intypen.. 
(daarom staat passwordauthentificatino aan!)
PAS DAARNA naar de server sshd_config aanpassen...
sudo nano /etc/ssh/sshd_config
Verander: PasswordAuthentication no
Vul in onderaan AllowUsers archie@81.174.98.248
Inloggen werkt hierna weer goed! :-)
 
#### Ubuntu Mate op GPD pocket

27APR19 opnieuwe linux installatie, want na Parrot upgrade loopte het systeem vast.
Ubuntu Mate 18.04.2 LTS (Bionic) 
De iso gedownload op via torrent (https://ubuntu-mate.org/download/)
en op een usb stick gezet.

sudo dd if=//home/archie/Downloads/ubuntu-mate-18.04.2-desktop-amd64-gpd-pocket.iso of=/dev/sdd status=progress

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
ip link set wlp1s0 up
ip link
output: wlp1s0 ... UP
wifi-menu
Voer alvast het wachtwoord in
modprobe -r brcmfmac
modprobe brcmfmac
pacman -Syu
Yess, het werkt, ik zit online!

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

cfdisk /dev/mmcblk0
mkfs.ext4 /dev/mmcblk0p3
mount /dev/mmcblk0p3 /mnt
     
Create boot directory and mount Windows Boot Loader
mkdir /mnt/boot
mount /dev/mmcblk0p1 /mnt/boot
....
alles gedaan zoals beschreven in:
https://wiki.archlinux.org/index.php/GPD_WIN

opstarten lukt. nog geen netwerk
     
ip link set wlp1s0 up
ip link
output: wlp1s0 ... UP
modprobe -r brcmfmac
modprobe brcmfmac
werkt verder nog niet....

06MAY18  Na opstarten is er een zwart scherm... wat gaat er mis... als er 
op de uitknop wordtgedruk, dan zie je dat Linux afgesloten wordt, er is 
dus iets niet pluis, maar wat...? #De oplossing lijkt een nieuwe 
installatie, en dan direct de juiste packages downloaden...
mkfs.ext4 /dev/mmcblk0p3
ip link set wlp1s0 up
ip link
output: wlp1s0 ... UP
wifi-menu
Voer alvast het wifi wachtwoord in
modprobe -r brcmfmac
modprobe brcmfmac
pacman -Syu
werkt niet, niet online, ook is de device niet meer aanwezig na ip link...
     
06MAY18 reboot en verder met de installatie...
ip link set wlp1s0 up
ip link
output: wlp1s0 ... UP
wifi-menu
Voer alvast het wifi wachtwoord in
ip link
output: wlp1s0 ... UP
pacman -Syy
veel foutmeldingen voor syncen.
nano /etc/pacman.conf
Toegevoegd (rest laten staan)
[gpd-pocket-arch]
SigLevel = Never
Server = https://github.com/joshskidmore/gpd-pocket-arch/raw/master
mrcmfmac
modprobe -r brcmfmac
modprobe brcmfmac
ip link 
Nu is de device aanwezig, en up.
pacman -Syy 
werk nog steeds niet.
ip link 
Nu is de device aanwezig, maar niet up. Maar weer up gezet:
ip link set wlp1s0 up
pacman -Syy 
werk nog steeds niet.
ip link
Nu is de device aanwezig, maar wel up.
modprobe brcmfmac
2 root wordt weergegeven
ip link
Nog steeds is de device aanwezig, en up.
pacman -Syy 
werk nog steeds niet.
modprobe -r brcmfmac
ip link 
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

sudo dd if=//home/archie/Downloads/Parrot-home-3.11-Re4son-Pocket_amd64.iso of=/dev/sdd status=progress

De GPD pocket aangezet en F7 ingedrukt, toen geboot via usb en Installation 
gekozen. Toen kwam er een old school installer (Debian). Daar doorheen 
gelopen.
root wachtwoord: het gebruikelijke
user: parrot
wachtwoord: het gebruikelijke
Het partioneren heb ik over de hele harde schijf gedaan met een enkele 
partitie en default settings.

in commandline update kernel:
wget -O re4son-pocket-kernel.tar.xz https://re4son-kernel.com/download/re4son-pocket-kernel-current/
tar xJf re4son-pocket-kernel.tar.xz
cd 4.1*
sudo ./install.sh
het verwijderen van de 
sudo apt-get install airgeddon

sudo apt-get update
sudo apt-get upgrade

tijdens de upgrade heb ik yes en yes gekozen (incl bootscreen) ipv default N
na reboot stond bootscreen gedraaid en werkt de wifi niet meer
dus de volgende keer niet yes yes kiezen...
wel werkt mijn alfa wifi adapter.
ip link
wlan0 is de alfa usb wifi... waar is de interne wifi...

25APR19. Wifi werkt nog steeds niet, wel alfa wifi adapter
sudo apt-get update
sudo apt-get upgrade

         
---
### Keebs         
     
#### Ducky one mechanical keyboard
     
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

     
#### Gergo keyboard
     
"https://github.com/Prutserdt"

-----------------------------------------------------------------------
#### Email en elffrink.nl domein
elffrink.nl domein
Aangeschaft in 01DEC19: elffrink.nl via transip