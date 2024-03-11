# NOTE: This file is generated from ~/.config/qtile/README.org
#       Please only edit that file and org-babel-tangle (Emacs)

import psutil
import subprocess
import os
import socket

from typing import List
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from os.path import expanduser
# from subprocess imprt check_output  # uncomment for battery, Lenovo Thinkpad

class ScrollableTextWidget(widget.base._TextBox):
    def __init__(self, file_path, **config):
        super().__init__(text="", **config)
        self.file_path = file_path
        self.lines = []
        self.current_line_index = -1  # Start with the last line

    def load_file(self):
        try:
            with open(self.file_path, "r") as file:
                self.lines = file.readlines()
        except FileNotFoundError:
            self.lines = []

    def scroll(self, direction):
        if direction == "up":
            self.current_line_index = max(self.current_line_index - 1, -len(self.lines))
        elif direction == "down":
            self.current_line_index = min(self.current_line_index + 1, -1)
        self.update_text()

    def update_text(self):
        if self.lines:
            self.text = self.lines[self.current_line_index].strip()
        else:
            self.text = "No notifications"

    def button_press(self, x, y, button):
        if button == 4:
            self.scroll("up")
        elif button == 5:
            self.scroll("down")

    def poll(self):
        self.load_file()
        self.update_text()

def open_last_notification(qtile):
    try:
        with open(expanduser("~/.config/notify.log"), "r") as file:
            lines = file.readlines()
            if lines:
                notification = lines[-1].strip()
                qtile.cmd_spawn(["notify-send", notification])  #
    except FileNotFoundError:
        pass

mL = "mod4"                       # Left super key, dedicated to the windowmanager
mR = "mod3"                       # Right super key, dedicated to open applications
aR = "mod5"                       # Right alt key, dedicated to opening of files

# Declare the variable for the file path
emacs_script = expanduser("~/.config/qtile/open_emacs.py")
home = os.path.expanduser("~")

def threecol(qtile):
    qtile.cmd_to_layout_index(0) # monadthreecolumn

def montall(qtile):
    qtile.cmd_to_layout_index(1) # monadtall

def monwide(qtile):
    qtile.cmd_to_layout_index(2) # monadwide

def Max(qtile):
    qtile.cmd_to_layout_index(3) # Max


# Define a global variable to track the current layout
current_layout = 0  # threecol is the default layout

# Toggle between the max layout and monadthreecolumn
def toggle_max_and_bar(qtile):
    global current_layout

    if current_layout == 3:  # If Max is currently selected
        qtile.cmd_to_layout_index(0)  # Switch to threecol layout
        qtile.cmd_hide_show_bar()  # Show the bar
        current_layout = 0  # Update the current layout
    else:
        qtile.cmd_to_layout_index(3)  # Switch to Max layout
        qtile.cmd_hide_show_bar()  # Hide the bar
        current_layout = 3  # Update the current layout

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

# Check if hostname is "thinkpad" or "work"
is_thinkpad_or_work = socket.gethostname().lower() in ["thinkpad", "work"]

# Define get_battery_status() function
if is_thinkpad_or_work:
    def get_battery_status():
        battery = check_output(['acpi'])
        return battery.decode("utf-8").strip()

battery_widget = [
    widget.Battery(
        battery=1,
        format='{char} {percent:2.0%}',
        update_interval=30
    )
] if is_thinkpad_or_work else []

keys = [
    Key([mL], "Return", lazy.spawn("alacritty"),        desc="Launch terminal in new window"),
    Key([mL], "space", lazy.layout.swap_main(),         desc="Make main window of selected window"),
    Key([mL], "b", lazy.hide_show_bar(position="top"),  desc="Toggle the bar"),
    Key([mL], "c", lazy.spawncmd(),                     desc="Spawn a command using a prompt widget"),
    Key([mL], "f", lazy.function(toggle_max_and_bar), desc="Toggle layout and bar"),
    Key([mL], "r", lazy.spawncmd(),                     desc="Prompt commands from taskbar"),
    Key([mL], "t", lazy.window.toggle_floating(),       desc="Toggle floating state"),
    Key([mL], "q", lazy.window.kill(),                  desc="Kill focused window"),
    Key([mL,  "control"], "r", lazy.reload_config(),    desc="Reload the Qtile configuration"),
    Key([mL,  "shift"], "q", lazy.spawn(expanduser("~/.config/exitqtile.sh")), desc="Shutdown Qtile by a shellscript with dmenu options"),
    #Hotkeys to move windows around, resize windows and choose layouts
    Key([mL], "j", lazy.layout.down(),                  desc="Move window focus down"),
    Key([mL], "k", lazy.layout.up(),                    desc="Move window focus up"),
    Key([mL, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mL, "shift"], "l", lazy.layout.shuffle_right(),desc="Move window to the right"),
    Key([mL, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mL, "shift"], "k", lazy.layout.shuffle_up(),   desc="Move window up"),
    Key([mL, "control"], "h", lazy.layout.grow(),       desc="Grow the selected window"),
    Key([mL, "control"], "j", lazy.layout.shrink_main(),desc="Shrink the main window"),
    Key([mL, "control"], "k", lazy.layout.grow_main(),  desc="Grow the main window"),
    Key([mL, "control"], "l", lazy.layout.shrink(),     desc="Shrink the selected window"),
    Key([mL], "y", lazy.function(Max),                  desc="Layout: max"),
    Key([mL], "u", lazy.function(threecol),             desc="Layout: Threecolumn  without margins"),
    Key([mL], "i", lazy.function(monwide),              desc="Layout: MonadWide no margins"),
    Key([mL], "n", lazy.function(open_last_notification)),
    Key([mL], "o", lazy.function(montall),              desc="Layout: MonadTall no margins"),
    Key([mL], 'a', increase_margin,                     desc="Increase gaps"),
    Key([mL, "shift"], "a", decrease_margin,            desc="Decrease gaps"),
    Key([mL], "m", reset_margin,                        desc="Reset gaps to zero"),

    # Hotkeys for audio and printscreen
    Key([], "XF86AudioRaiseVolume", lazy.spawn('amixer -q set Master 5%+'), lazy.spawn('notify-send -t 6000 " 🔊 Volume increased"')),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-"), lazy.spawn('notify-send -t 6000 "🔈 Volume decreased"')),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle"), lazy.spawn('notify-send -t 6000 "🔇 Volume muting toggled"')),
    Key([], "Print", lazy.spawn("xfce4-screenshooter -r -s " + expanduser("~/Downloads")), lazy.spawn('notify-send -t 6000 "Running xfce4-screenshooter, please select area with your mouse to make a screenshot"')),
    Key(["shift"], "Print", lazy.spawn(expanduser("~/.config/screenshot2text.sh"))),
    # The following hotkeys of my Redox keyboard are free to be used..!
    # Key([], "XF86Launch5", lazy.spawn(''), lazy.spawn('notify-send -t 6000 ""')),
    # Key([], "XF86Launch6", lazy.spawn(''), lazy.spawn('notify-send -t 6000 ""')),
    # Key([], "XF86Launch7", lazy.spawn(''), lazy.spawn('notify-send -t 6000 ""')),
    Key([], "XF86Launch8", lazy.spawn('xmodmap $HOME/.config/kbswitch && xset r rate 300 80'), lazy.spawn('notify-send -t 6000 "⌨️Keyboard settings changed (kbswitch)"')),
    Key([], "XF86Launch9", lazy.spawn(expanduser("~/.config/resetRGB.sh"))),
    Key([], "XF86MonBrightnessUp", lazy.spawn(expanduser("~/.config/incrMonitorBrightness.sh"))),
    Key([], "XF86MonBrightnessDown", lazy.spawn(expanduser("~/.config/decrMonitorBrightness.sh"))),

    # Open applications
    Key([mR], "a",
        lazy.spawn("python " + expanduser("~/.config/aandelen.py")),
        lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Documenten/Aandelen/aandelen_log.org')}"),
        desc="Open in emacs: run het python aandelen script en open het aandelen log"),
    Key([mR], "b", lazy.spawn(expanduser("~/.config/dmenuinternet.sh"))), # browser via dmenu, related to 'urls'
    Key([mR], "c", lazy.spawn(expanduser("~/.config/clipboard_dm.sh"))), # copy/paste clipoard
    Key([mR], "d", lazy.spawn(expanduser("~/.config/dmenuapps.sh"))),
    Key([mR, "shift"], "d", lazy.spawn(expanduser("~/.config/dmenuUpdate.sh"))),
    Key([mR], "e", lazy.spawn("emacsclient -c -n -a 'emacs'")),
    Key([mR], "f", lazy.spawn("firefox")),
    Key([mR], "g", lazy.spawn("gimp")),
    Key([mR], "h", lazy.spawn(expanduser("~/.config/bitcoin_notification.py"))),
    Key([mR], "k", lazy.spawn("keepass")),
    Key([mR, "shift"], "k", lazy.spawn(expanduser("~/.config/dmenukill.sh"))),
    Key([mR], "m", lazy.spawn("mousepad")),
    Key([mR], "p", lazy.spawn(expanduser("~/.config/dm_image_to_maps.sh"))), # show location of picture in google maps
    Key([mR, "shift"], "p", lazy.spawn(expanduser("~/.config/dm_move_images.sh"))), # show location of picture in google maps
    Key([mR], "s", lazy.spawn("xfce4-screenshooter -s " + expanduser("~~/Downloads"))),
    Key([mR, "shift"], "s", lazy.spawn("signal-desktop --start-in-tray --use-tray-icon")),
    Key([mR], "t", lazy.spawn(expanduser("~/.config/dmenuthunar.sh"))), # related to 'directories'
    Key([mR], "u", lazy.spawn(expanduser("~/.config/dmenuunicode.sh"))), # related to 'unicode'
    Key([mR], "v", lazy.spawn("alacritty -e vim")),
    Key([mR], "w", lazy.spawn(expanduser("~/.config/dmenuwallpaper.sh"))),

    # Open text files in emacs
    Key([aR], "a", lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Documenten/Aandelen/aandelen_log.org')}")),
    Key([aR], "b", lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Command_line/urls')}")), # related to dmenuinternet.sh
    Key([aR], "c", lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Command_line/commands.org')}")),
    Key([aR], "d", lazy.spawn(expanduser("~/.config/dmenuemacs.sh"))),
    Key([aR], "e", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.doom.d/README.org')}")),
    Key([aR], "i", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.config/i3/config')}")),
    Key([aR], "n", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.newsboat/config')}")),
    Key([aR], "p", lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Code/git/PowerStrike_code/README.org')}")),


#    Key([aR], "q", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.config/qtile/README.org')}")),
    Key([aR], "q", lazy.spawn(expanduser("~/.config/emacs_open_file.sh"))),


    Key([aR], "r", lazy.spawn(f"python3 {emacs_script} {expanduser('~/README.org')}")), # github readme
    Key([aR], "s", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.config/README.org')}")),  # shell scripts readme
    Key([aR, "shift"], "t", lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Command_line/textfiles')}")),
    Key([aR], "t", lazy.spawn(f"python3 {emacs_script} {expanduser('~/Stack/Command_line/directories')}")),  # related to dmenuthunar.sh
    Key([aR], "u", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.config/unicode')}")),  # related to dmenuunicode.sh
    Key([aR], "v", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.vimrc')}")),
    Key([aR], "w", lazy.spawn(expanduser("~/.config/wololo.sh"))),
    Key([aR], "x", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.xinitrc')}")),
    Key([aR], "z", lazy.spawn(f"python3 {emacs_script} {expanduser('~/.zshrc')}")),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            Key(
                [mL],      # mL + letter of group = switch to group
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # Move and follow focused window to group
            Key(
                [mL, "shift"],
                i.name,
                lazy.window.togroup(i.name,switch_group=True), #True=follow window
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
        DropDown("1", "qalculate-gtk", x=0.0, y=0.0, width=0.2, height=0.3,
                 on_focus_lost_hide=False),
    ])
)

is_thinkpad = socket.gethostname().lower() in ["thinkpad"]

keys.extend([
    Key([], "XF86Favorites" if is_thinkpad else "XF86Calculator",
        lazy.group["scratchpad"].dropdown_toggle("1"),
        lazy.spawn('notify-send -t 60000 " Running qalculate-gtk"'))
])

layout_theme = {"border_width": 2,
                "border_focus":  "#d75f5f",
                "border_normal": "#282C35", #966363
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
                "border_focus": "#98BE65",  #98C379= groen
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
                widget.GroupBox(foreground="#555555"),
                widget.CurrentLayout(foreground="#777777"),
                widget.Prompt(foreground="#777777"),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Notify(foreground="#ff966c"),
                ScrollableTextWidget(
                    file_path="~/.config/notify.log",
                    foreground="#ff966c"),  # Use the widget here
                widget.Systray(),
                widget.QuickExit(foreground="#888888"),
            ] + battery_widget + [
                widget.OpenWeather(
                    app_key="4cf3731a25d1d1f4e4a00207afd451a2",
                    cityid="2759661",
                    format='{main_temp}°C {icon}',
                    foreground="#888888",
                    metric=True,
                    mouse_callbacks={"Button1": lazy.spawn("xdg-open https://buienradar.nl"), "Button3": lazy.spawn("xdg-open https://openweathermap.org/city/2759661")}
                ),
                widget.Volume(foreground="#d75f5f"),
                widget.Clock(format="%d%b%y %H:%M",
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
    Drag([mL], "Button1",
        lazy.window.set_position_floating(), start=lazy.window.get_position()
        ),
    Drag([mL], "Button3",
        lazy.window.set_size_floating(), start=lazy.window.get_size()
        ),
    Click([mL], "Button2",
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

auto_minimize = True # for steam games

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
#    subprocess.call([expanduser("~/.config/qtile/autostart.sh")])

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

wmname = "LG3D"
