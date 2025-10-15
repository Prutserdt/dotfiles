# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)

import psutil
import subprocess
import os
import socket
import sys

from typing import List
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy

from os.path import expanduser
from libqtile.scripts.main import VERSION

mL = "mod4"                         # Left super key, dedicated to the windowmanager
mR = "mod3"                         # Right super key, dedicated to open applications

home = os.path.expanduser("~")      # Declare the variable for the file path

def threecol(qtile):
    qtile.cmd_to_layout_index(0)    # monadthreecolumn

def montall(qtile):
    qtile.cmd_to_layout_index(1)    # monadtall

def monwide(qtile):
    qtile.cmd_to_layout_index(2)    # monadwide

def Max(qtile):
    qtile.cmd_to_layout_index(3)    # Max

# Define a global variable to track the current layout
current_layout = 0  # threecol is the default layout

# Toggle between the max layout and monadthreecolumn
def toggle_max_and_bar(qtile):
    global current_layout

    if current_layout == 3:         # If Max is currently selected
        qtile.cmd_to_layout_index(0)# Switch to threecol layout
        qtile.cmd_hide_show_bar()   # Show the bar
        current_layout = 0          # Update the current layout
    else:
        qtile.cmd_to_layout_index(3)# Switch to Max layout
        qtile.cmd_hide_show_bar()   # Hide the bar
        current_layout = 3          # Update the current layout

@lazy.layout.function
def increase_margin(self):
    self.margin += 20
    self.group.layout_all()

@lazy.layout.function
def decrease_margin(self):
    new_margin = self.margin - 1
    if new_margin < 0:
        new_margin = 0
    self.margin = new_margin
    self.group.layout_all()

@lazy.layout.function
def reset_margin(self):
    self.margin = 0
    self.group.layout_all()

# Path to my API key file
api_key_path = os.path.expanduser('~/Stack/Command_line/openweather_api_key')

# Read the API key
with open(api_key_path, 'r') as file:
    api_key = file.read().strip()

# Check if hostname is "thinkpad" or "work"
is_thinkpad_or_work = socket.gethostname() in ["thinkpad", "work"]

# Define get_battery_status() function
if is_thinkpad_or_work:
    def get_battery_status():
        battery = check_output(['acpi'])
        return battery.decode("utf-8").strip()

battery_widget = [
    widget.Battery(
       #battery=0, # Thinkpad batteries can be 0 or 1!
        battery=1,  # Thinkpad batteries can be  0 or 1!
        format='{char} {percent:2.0%}',
        update_interval=30
    )
] if is_thinkpad_or_work else []

def toggle_mute():
       try:
           mute_status = subprocess.run(
               ['amixer', 'get', 'Master'],
               stdout=subprocess.PIPE,
               text=True,
               check=True
           ).stdout
           subprocess.run(['amixer', '-q', 'set', 'Master', 'toggle'], check=True)

           message = "🔊 Volume unmuted" if "off" in mute_status else "🔇 Volume muted"

           os.system(f'notify-send -t 1000 "{message}"')
           return message
       except subprocess.CalledProcessError as e:
           print("Error occurred:", e)
           return "Error"

keys = [
    Key(
        [mL],
        "Return",
        lazy.spawn("alacritty"),
        desc="Launch terminal in new window"),
    Key(
        [mL],
        "space",
        lazy.layout.swap_main(),
        desc="Make main window of selected window"),
    Key(
        [mL],
        "b",
        lazy.hide_show_bar(position="top"),
        desc="Toggle the bar"),
    Key(
        [mL],
        "c",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key(
        [mL],
        "f",
        lazy.function(toggle_max_and_bar),
        desc="Toggle layout and bar"),
    Key(
        [mL],
        "l",
        lazy.spawn(expanduser("i3lock -i /home/icefly/Stack/Afbeeldingen/Wallpapers/thomas_thiemeyer_Voyage1920x1080-3261363968.jpg -F")),
        desc="Lock the screen"),
    Key(
        [mL],
        "r",
        lazy.spawncmd(),
        desc="Prompt commands from taskbar"),
    Key(
        [mL],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating state"),
    Key(
        [mL],
        "q",
        lazy.window.kill(),
        desc="Kill focused window"),
    Key(
        [mL, "control"],
        "r",
        lazy.reload_config(),
        desc="Reload the Qtile configuration"),
    Key(
        [mL, "shift"],
        "q",
        lazy.spawn(expanduser("~/.config/exitqtile.sh")),
        desc="Shutdown Qtile by a shellscript with dmenu options"),

    #Hotkeys to move windows around, resize windows and choose layouts
    Key(
        [mL],
        "j",
        lazy.layout.down(),
        desc="Move window focus down"),
    Key(
        [mL],
        "k",
        lazy.layout.up(),
        desc="Move window focus up"),
    Key([mL, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key(
        [mL, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key(
        [mL, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key(
        [mL, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"),
    Key(
        [mL, "control"],
        "h",
        lazy.layout.grow(),
        desc="Grow the selected window"),
    Key(
        [mL, "control"],
        "j",
        lazy.layout.shrink_main(),
        desc="Shrink the main window"),
    Key(
        [mL, "control"],
        "k",
        lazy.layout.grow_main(),
        desc="Grow the main window"),
    Key(
        [mL, "control"],
        "l",
        lazy.layout.shrink(),
        desc="Shrink the selected window"),
    Key(
        [mL],
        "y",
        lazy.function(Max),
        desc="Layout: max"),
    Key(
        [mL],
        "u",
        lazy.function(threecol),
        desc="Layout: Threecolumn  without margins"),
    Key(
        [mL],
        "i",
        lazy.function(monwide),
        desc="Layout: MonadWide no margins"),
    Key(
        [mL],
        "o",
        lazy.function(montall),
        desc="Layout: MonadTall no margins"),
    Key(
        [mL],
        'a',
        increase_margin,
        desc="Increase gaps"),
    Key(
        [mL, "shift"],
        "a",
        decrease_margin,
        desc="Decrease gaps"),
    Key(
        [mL],
        "m",
        reset_margin,
        desc="Reset gaps to zero"),

    # Hotkeys for audio and printscreen
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn('amixer -q set Master 5%+'),
        lazy.spawn('notify-send -t 1000 " 🔊 Volume increased"')),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer -q set Master 5%-"),
        lazy.spawn('notify-send -t 1000 "🔈 Volume decreased"')),
    Key (
        [],
        "XF86AudioMute",
        lazy.spawn("amixer -q set Master toggle"),

    lazy.spawn('notify-send -t 1000 "🔇 Volume muting toggled"')),
    # FIXME: toggle_mute werkt nog niet...
    # Key(
    #     [],
    #     "XF86AudioMute",
    #     lazy.function(toggle_mute)),
    Key(
        [],
        "Print",
        lazy.spawn("xfce4-screenshooter -r -s " + expanduser("~/Downloads")),
        lazy.spawn('notify-send -t 1000 "Running xfce4-screenshooter, please select area with your mouse to make a screenshot"')),
    Key(
        ["shift"],
        "Print",
        lazy.spawn(expanduser("~/.config/screenshot2text.sh"))),
    Key(
        [],
        "XF86Launch8",
        lazy.spawn('$HOME/.config/keyboard_config.sh')),
    Key(
        [],
        "XF86Launch9",
        lazy.spawn(expanduser("~/.config/resetRGB.sh"))),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(expanduser("~/.config/incrMonitorBrightness.sh"))),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(expanduser("~/.config/decrMonitorBrightness.sh"))),

    # Open applications
    Key([mR],
        "a",
        #lazy.spawn("emacs --eval '(load \"" + expanduser("~/Stack/Documenten/Aandelen/aandelen.el") + "\")'"),
        #lazy.spawn("emacs --script " + expanduser("~/Stack/Documenten/Aandelen/aandelen.el")),
        lazy.spawn("emacsclient -n ~/Stack/Documenten/Aandelen/aandelen_log.org"),
        #lazy.spawn(expanduser("~/run_aandelen.sh")),
        desc="Open in emacs: run the elisp script and open the aandelen log"),
        # lazy.spawn("python " + expanduser("~/.config/aandelen.py")),
        # lazy.spawn("emacsclient -n ~/Stack/Documenten/Aandelen/aandelen_log.org"),
        # desc="Open in emacs: run het python aandelen script en open het aandelen log"),
    Key(
        [mR],
        "b",
        lazy.spawn(expanduser("~/.config/dmenuinternet.sh"))), # browser via dmenu, related to 'urls'
    Key(
        [mR],
        "c",
        lazy.spawn(expanduser("~/.config/clipboard_dm.sh"))), # copy/paste clipoard
    Key(
        [mR],
        "d",
        lazy.spawn(expanduser("~/.config/dmenuapps.sh"))),
    Key(
        [mR, "shift"],
        "d",
        lazy.spawn(expanduser("~/.config/dmenuUpdate.sh"))),
    Key(
        [mR],
        "e",
        lazy.spawn(expanduser("~/.config/run_emacs.sh"))),
        #Keylazy.function(run_emacs)), # check bash shell for functionality
        #lazy.spawn("emacsclient -c -n -a 'emacs'")),
        #lazy.spawn("emacsclient -c -n -a '/usr/bin/emacs'")), # works on my desktop
        #lazy.spawn('pgrep -u "$USER" -f "emacs --daemon" > /dev/null || emacs --daemon; emacsclient -c -n')), # does not work on my desktop
        #lazy.spawn('pgrep -u "$USER" -f "emacs --daemon" > /dev/null || emacs --daemon; emacsclient -c -n -a "/usr/bin/emacs"')), # does not work on my desktop
        #lazy.spawn("bash -c 'pgrep -u \"$USER\" -f \"emacs --daemon\" > /dev/null || emacs --daemon; emacsclient -c -n -a \"/usr/bin/emacs\"'")),
        #lazy.spawn("/usr/bin/emacsclient -c")),
        #lazy.spawn("/usr/local/bin/emacs --daemon")),
        #lazy.spawn("/usr/bin/emacs")), # works currently on my desktop
        #lazy.spawn(expanduser("~/.config/run_emacs.sh"))),
    #Keylazy.function(run_emacs)), # use in case of problems([mR], "E", lazy.spawn(expanduser("~/.config/run_emacs_new_frame.sh"))),
    Key(
        [mR],
        "f",
        lazy.spawn("firefox")),
    Key(
        [mR],
        "g",
        lazy.spawn("gimp")),
    Key(
        [mR],
        "h",
        lazy.spawn(expanduser("~/.config/bitcoin_notification.py"))),
#    Key(
        # [mR],
        # # "j",
        #lazy.spawn(expanduser("~/.config/wololo.sh"))),
    Key(
        [mR],
        "m",
        lazy.spawn("mousepad")),
    Key(
        [mR, "shift"],
        "m",
        lazy.spawn(expanduser("~/.config/dm_image_to_maps.sh"))),
    # show location of picture in google maps
    Key(
        [mR],
        "p",
        lazy.spawn("keepass")),
    Key(
        [mR, "shift"],
        "p",
        lazy.spawn(expanduser("~/.config/dm_move_images.sh"))),  # show location of picture in google maps
    Key(
        [mR],
        "s",
        lazy.spawn("xfce4-screenshooter -s " + expanduser("~~/Downloads"))),
    Key(
        [mR, "shift"],
        "s",
        lazy.spawn("signal-desktop --start-in-tray --use-tray-icon")),
    Key(
        [mR],
        "t",
        lazy.spawn(expanduser("~/.config/dmenuthunar.sh"))),  # related to 'directories'
    Key(
        [mR],
        "u",
        lazy.spawn(expanduser("~/.config/dmenuunicode.sh"))),  # related to 'unicode'
    Key(
        [mR],
        "v",
        lazy.spawn("alacritty -e vim")),
    Key(
        [mR],
        "w",
        lazy.spawn(expanduser("~/.config/dmenuwallpaper.sh"))),
    Key(
        [mR],
        "delete",
        lazy.spawn(expanduser("~/.config/dmenukill.sh"))),
]

groups = [Group(i) for i in "1245"]

for i in groups:
    keys.extend(
        [
            Key(
                [mL],      # mL + number of group --> switch to group
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # Move and follow focused window to group
            Key(
                [mL, "shift"],
                i.name,
                lazy.window.togroup(
                    i.name,
                    switch_group=True),  #True=follow window
                desc="Move and follow the focused window to group {}".format(i.name),
            ),
            # Exactly the same as above, but don't follow the moved window to group
            Key(
                [mL, "control", "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="Move the focused window to group {}".format(i.name),
            ),
        ]
    )

groups.append(
    ScratchPad("scratchpad", [
        DropDown("1",
                 "qalculate-gtk",
                 x=0.0,
                 y=0.0,
                 width=0.2,
                 height=0.3,
                 on_focus_lost_hide=False),
    ])
)

is_thinkpad = socket.gethostname().lower() in ["thinkpad"]

keys.extend([
    Key([],
        "XF86Favorites" if is_thinkpad else "XF86Calculator",
        lazy.group["scratchpad"].dropdown_toggle("1"),
        lazy.spawn('notify-send -t 1000 " Running qalculate-gtk"'))
])

layout_theme = {"border_width": 2,
                "border_focus":  "#d75f5f",
                "border_normal": "#282C35",
                "min_ratio": 0.05, "max_ratio": 0.9,
                "new_client_position":'bottom',
                }

layout_theme_max = {"border_width": 0,
                "border_focus": False,
                "min_ratio": 0.05, "max_ratio": 0.9,
                "new_client_position":'bottom',
                }

# A separate theme for floating mode, different color, thicker border width
floating_theme = {"border_width": 3,
                "border_focus": "#98BE65",
                "border_normal": "#006553",
                }

layouts = [
   layout.MonadThreeCol(**layout_theme),
   layout.MonadTall(**layout_theme),
   layout.MonadWide(**layout_theme),
   layout.Max(**layout_theme_max),  # Set border_focus to False for Max layout
]

widget_defaults = dict(
    font="hack",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(),
                widget.GroupBox(
                    inactive= "333333",
                    active= "888888",
                    disable_drag=True,
                    highlight_method='line',
                    highlight_color=['000000','d75f5f']),
                widget.WindowName(
                    foreground="#555555"),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
            ]   + battery_widget +
            [
                widget.OpenWeather(
                    app_key=api_key,
                    cityid="2759661",
                    format='{main_temp:.1f} °C {icon}',
                    foreground="#888888",
                    metric=True,
                    mouse_callbacks={"Button1": lazy.spawn("xdg-open https://buienradar.nl"), "Button3": lazy.spawn("xdg-open https://openweathermap.org/city/2759661")}
                ),
                widget.Volume(
                    foreground="#d75f5f"),
                widget.QuickExit(
                    default_text="  🛑",
                    foreground="#888888"),
                widget.Clock(
                    format="%d%b%y %H:%M",
                    foreground="#888888",
                    mouse_callbacks={"Button1": lazy.spawn("xdg-open https://www.timeanddate.com/calendar/")}
                ),
            ],
            24,
            opacity=0.85,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mL],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
        ),
    Drag(
        [mL],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
        ),
    Click(
        [mL],
        "Button2",
        lazy.window.bring_to_front()
        ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(**floating_theme,
    float_rules=[
        # Run utility of `xprop` to see the wm class and name of an X client
        *layout.Floating.default_float_rules,
        Match(wm_class="gimp"),      # gimp image editor
        Match(wm_class="keepass2"),  # keepass password editor
    ],
)

auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True  # for steam games

@hook.subscribe.layout_change
def update_current_layout(layout):
    global current_layout
    current_layout = layout.index()

# Startup script
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])
    home = os.path.expanduser("~")

# swallow window when starting application from terminal
@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {
        c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()
    }
    for i in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()

@hook.subscribe.client_killed
def _unswallow(window):
    if hasattr(window, 'parent'):
        window.parent.minimized = False

wmname = f"Qtile {VERSION}"
