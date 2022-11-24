# NOTE: This file is generated from the README.org file. Do not alter
# config.el directly and only modify the README.org file in emacs by
# 'M-x' 'org-babel-tangle' and reload by 'M-x' 'doom/reload'

import psutil
import subprocess
import os
from typing import List
from libqtile import bar, layout, widget,hook
from libqtile.config import ( Click, Drag, Group, Key, KeyChord, Match,
                                Screen, ScratchPad, DropDown,)
from libqtile.lazy import lazy

modL = "mod4"                       # Left super key, dedicated to the windowmanager
modR = "mod3"                       # Right super key, dedicated to open applications
altR = "mod5"                       # Right alt key, dedicated to opening of files

home = os.path.expanduser("~")
termVim="alacritty -e vim "         # Open vim in alacritty (used for altR hotkeys)
Emacs="emacsclient -c -a 'emacs' "  # Opens Emacs via the EmacsClient

def threecol(qtile):
    qtile.cmd_to_layout_index(0) #0:monadthreecolumn with margins

def threecol2(qtile):
    qtile.cmd_to_layout_index(1) #1:monadthreecolumn without margins

def montall(qtile):
    qtile.cmd_to_layout_index(2) #2: monadtall with margins

def montall2(qtile):
    qtile.cmd_to_layout_index(3) #2: monadtall with margins

def monwide(qtile):
    qtile.cmd_to_layout_index(4) #3: monadwide with margins

def monwide2(qtile):
    qtile.cmd_to_layout_index(5) #3: monadwide with margins

def cmd_increase_margin(self): ### FIXME werkt NIET!
    self.margin += 10
    self.group.layout_all()

def cmd_decrease_margin(self): ### FIXME werkt NIET!
    new_margin = self.margin - 10
    if new_margin < 0:
        new_margin = 0
    self.margin = new_margin
    self.group.layout_all()

keys = [
    KeyChord([modL], "m", [      # testje, keychording werkt!! :-)
        Key([], "u",lazy.spawn("amixer -q set Master 5%+")),
        Key([], "i",lazy.spawn("amixer -q set Master 5%-")),
        Key([], "k", lazy.function(cmd_increase_margin)),  ### FIXME werkt NIET:!
        Key([], "j", lazy.funtion(cmd_decrease_margin))    ### FIXME werkt NIET:!
        ],
        mode="Margins" # als je mode kiest dan moet je eruit met escape....
        ),
    KeyChord([modL], "z", [  # test, weet niet ik dit erin hou...
        Key([], "k", lazy.layout.grow_main()),
        Key([], "j", lazy.layout.shrink_main()),
        Key([], "i", lazy.layout.grow()),
        Key([], "u", lazy.layout.shrink()),
        Key([], "n", lazy.layout.normalize()),
        Key([], "m", lazy.layout.maximize())
        ],
        mode="Windows"
        ),
    Key([modL], "a",
        lazy.function(cmd_increase_margin), ### FIXME werkt NIET:
        desc="increase margin..."
        ),
    Key([modL, "shift"], "a",
        lazy.function(cmd_decrease_margin), ### FIXME werkt NIET:
        desc="decrease margin..."
        ),
    Key([modL], "Return",
        lazy.spawn("alacritty"),
        desc="Launch a terminal in a new window"
        ),
    Key([modL], "space",
        lazy.layout.swap_main(),
        desc="Make the selected window the main window"
        ),
    Key([modL],"b",
        lazy.hide_show_bar(position="top"),
        desc="Toggle the bar"
        ),
    Key([modL],"f",
        lazy.window.toggle_fullscreen(),
        desc="Fullscreen the current window"
        ),
    Key([modL], "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget in the taskbar"
        ),
    Key([modL], "t",
        lazy.window.toggle_floating(),
        desc="Toggle the floating state of the window."
        ),
    Key([modL], "q",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
    Key([modL, "control"], "r",
        lazy.reload_config(),
        desc="Reload the Qtile configuration"
        ),
    Key([modL, "shift"], "q",
        lazy.spawn("alacritty -e"+ home + "/.config/exitqtile.sh"),
        desc="Shutdown Qtile by a shellscript"
        ),
    #Hotkeys to move windows around, resize windows and choose layouts
    Key([modL], "h",
        lazy.layout.left(),
        desc="Move window focus to the left"
        ),
    Key([modL], "l",
        lazy.layout.right(),
        desc="Move window focus to the right"
        ),
    Key([modL], "j",
        lazy.layout.down(),
        desc="Move window focus down"
        ),
    Key([modL], "k",
        lazy.layout.up(),
        desc="Move window focus up"
        ),
    Key([modL, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
        ),
    Key([modL, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
        ),
    Key([modL, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
        ),
    Key([modL, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
        ),
    Key([modL, "control"], "h",
        lazy.layout.grow(),
        desc="Grow the selected window"
        ),
    Key([modL, "control"], "j",
        lazy.layout.shrink_main(),
        desc="Shrink the main window"
        ),
    Key([modL, "control"], "k",
        lazy.layout.grow_main(),
        desc="Grow the main window"
        ),
    Key([modL, "control"], "l",
        lazy.layout.shrink(),
        desc="Shrink the selected window"
        ),
    Key([modL],"y",
        lazy.function(montall),
        desc="Layout: MonadTall selection without margins"
        ),
    Key([modL],"u",
        lazy.function(threecol),
        desc="Layout: Threecolumn selection without margins"
        ),
    Key([modL],"i",
        lazy.function(monwide),
        desc="Layout: MonadWide selection without margins"
        ),
    Key([modL],"6",
        lazy.function(montall2),
        desc="Layout: MonadTall selection with margins"
        ),
    Key([modL],"7",
        lazy.function(threecol2),
        desc="Layout: Threecolumn selection with margins"
        ),
    Key([modL],"8",
        lazy.function(monwide2),
        desc="Layout: MonadWide selection without margins"
        ),

    # Hotkeys for audio and printscreen
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -q set Master 5%+"),
        desc="Raise the volume"
        ),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("amixer -q set Master 5%-"),
        desc="Lowering the volume"
        ),
    Key([], "XF86AudioMute",
        lazy.spawn("amixer -q set Master toggle"),
        desc="Toggle mute/unmute"
        ),
    Key([], "Print",
        lazy.spawn("xfce4-screenshooter -r -s " + os.path.expanduser("~/Downloads")),
        desc="Draw area by mouse to copy the selection and save in Downloads"
        ),
    Key(["shift"], "Print",
        lazy.spawn(home + "/.config/ScreenshotToText.sh"),
        desc="Make screenshot and text is magically in the system clipboard"
        ),

    # Open applications
    Key([modR], "a",
        lazy.spawn("python " + os.path.expanduser("~/.config/Aandelen.py")),
        lazy.spawn(Emacs + home + ("/Stack/Documenten/Aandelen/aandelen_log.org")),
        #lazy.spawn(termVim + os.path.expanduser("~/Stack/Documenten/Aandelen/aandelen_log.org")),
        desc="Open in vim: run het python aandelen script en open het aandelen log"
        ),
    Key([modR], "b",
        lazy.spawn("brave"),
        desc="Launch Brave browser"
        ),
    Key([modR], "e",
        lazy.spawn("emacsclient -c -a 'emacs'"),
        desc="Launch emacs"
        ),
    Key([modR], "d",
        lazy.spawn(home + "/.config/dmenuapps.sh"),
        desc="Launch My dmenu to open applications"
        ),
    Key([modR, "shift"], "d",
        lazy.spawn(home + "/.config/dmenuUpdate.sh"),
        desc="Recreate list of applications (list used for dmenuapps.sh)"
        ),
    Key([modR], "f",
        lazy.spawn("firefox"),
        desc="Launch Firefox browser"
        ),
    Key([modR], "g",
        lazy.spawn("gimp"),
        desc="Launch Gimp image manipulation"
        ),
    Key([modR], "k",
        lazy.spawn("keepass"),
        desc="Launch Keepass password manager"
        ),
    Key([modR], "m",
        lazy.spawn("mousepad"),
        desc="Launch Mousepad"
        ),
    Key([modR], "s",
        #lazy.spawn("xfce4-screenshooter -s " + os.path.expanduser("~/Downloads")),
        lazy.spawn("xfce4-screenshooter -s " + (home + ("~/Downloads"))),
        desc="Choose what to screenshot and save in Downloads"
        ),
    Key([modR], "t",
        lazy.spawn("thunar"),
        desc="Launch Thunar filemanager"
        ),
    Key([modR], "u",
        lazy.spawn(home + ("/.config/dmenuunicode.sh")),
        desc="Insert unicode, emojis :-)"
        ),
    Key([modR], "w",
        lazy.spawn(home + ("/.config/dmenuwallpaper.sh")),
        desc="Change wallpapers and select in dmenu"
        ),

    Key([altR], "a",
        lazy.spawn(Emacs + home + ("/Stack/Documenten/Aandelen/aandelen_log.org")),
        desc="Open in Emacs: aandelen log"
        ),

    Key([altR], "b",
        lazy.spawn(Emacs + home + "/.bashrc"),
        desc="Open in Emacs: .bashrc"
        ),
    Key([altR], "c",
        lazy.spawn(Emacs + home + "/Stack/Command_line/commands.org"),
        desc="Open in Emacs: commands.org"
        ),
    Key([altR], "d",
        lazy.spawn(Emacs + home + "/.config/suckless/dwm/config.h"),
        desc="Open in Emacs: config.h of my dwm build"
        ),
    Key([altR], "e",
        lazy.spawn(Emacs + home + "/.doom.d/README.org"),
        desc="Open in Emacs my Doom emacs config: README.org"
        ),
    Key([altR], "i",
        lazy.spawn(Emacs + home + "/.config/i3/config"),
        desc="Open in Emacs: config of my i3 build"
        ),
    Key([altR], "n",
        lazy.spawn(Emacs + home + "/.newsboat/config"),
        desc="Open in Emacs: config of newsboat"
        ),
    Key([altR], "p",
        lazy.spawn(Emacs + home + "/Arduino/PowerStrike/README.org"),
        desc="Open in Emacs: the readme of the PowerStrike project"
        ),
    Key([altR], "q",
        lazy.spawn(Emacs + home + "/.config/qtile/README.org"),
        desc="Open in Emacs:Open qtile config"
        ),
    Key([altR, "shift"], "r",
        lazy.spawn(Emacs + home + "/README.org"),
        desc="Open in Emacs: README.md of github dotfiles repo"
        ),
    Key([altR], "r",
        lazy.spawn(Emacs + home + "/.Xresources"),
        desc="Open in Emacs: .Xresources"
        ),
    Key([altR], "u",
        lazy.spawn(Emacs + home + "/.config/urls"),
        desc="Open in Emacs: urls list used for newsboat"
        ),
    Key([altR], "v",
        lazy.spawn(termVim +os.path.expanduser("~/.vimrc")),
        desc="Open in Vim:"
        ),
    Key([altR], "w",
        lazy.spawn(os.path.expanduser("~/.config/wololo.sh")),
        desc="Launch shellscript for generating keystroke wololo"
        ),
    Key([altR], "x",
        lazy.spawn(Emacs + home + "/.xinitrc"),
        desc="Open in Emacs: .xinitrc"
        ),
    Key([altR], "z",
        lazy.spawn(Emacs + home + "/.zshrc"),
        desc="Open in Emacs: .zshrc"
        ),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            # modL + letter of group = switch to group
            Key(
                [modL],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # modL+shift+group letter= move focused window to group(no follow)
            Key(
                [modL, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                # add ",switch_group=True" after i.name to follow the window
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

keys.extend([
        Key([], "XF86Calculator", lazy.group["scratchpad"].dropdown_toggle("1")),
])

# My default theme
layout_theme = {"border_width": 2,
                "border_focus":  "#d75f5f",
                "border_normal": "#282C35", # #966363
                }
# A separate theme for floating mode, to make it clear that the window floats
floating_theme = {"border_width": 3,
                "border_focus": "#00ffd2",  #98C379= groen
                "border_normal": "#006553",
                }

layouts = [
    layout.MonadThreeCol(**layout_theme, min_ratio=0.05, max_ratio=0.9,
                         new_client_position='bottom'),
    layout.MonadThreeCol(**layout_theme, margin=60, min_ratio=0.05,
                         max_ratio=0.9, new_client_position='bottom'),
    layout.MonadTall(**layout_theme, min_ratio=0.05, max_ratio=0.9,
                     new_client_position='bottom'),
    layout.MonadTall(**layout_theme, margin=60, min_ratio=0.05,
                     max_ratio=0.9, new_client_position='bottom'),
    layout.MonadWide(**layout_theme, min_ratio=0.05, max_ratio=0.9,
                     new_client_position='bottom'),
    layout.MonadWide(**layout_theme, margin=60, min_ratio=0.05,
                     max_ratio=0.9, new_client_position='bottom'),
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
                widget.QuickExit(foreground="#888888"),
                widget.Volume(foreground="#d75f5f"),
                widget.Systray(),
                widget.Clock(format="%d%b%y %H:%M",foreground="#888888"),
            ],
            24,
            opacity=0.85,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([modL], "Button1",
        lazy.window.set_position_floating(), start=lazy.window.get_position()
        ),
    Drag([modL], "Button3",
        lazy.window.set_size_floating(), start=lazy.window.get_size()
        ),
    Click([modL], "Button2",
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

auto_minimize = True # handy for steam games

# Startup scripts
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])

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
