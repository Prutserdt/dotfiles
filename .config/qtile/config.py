# NOTE This file is generated from a README.org file. Do not alter this
# config.py file directly and only modify the README.org file, then M-x and
# type: 'org-babel-tangle' in emacs and press CTR MOD R to reload qtile live.
# Happy hacking :-)

import psutil
import subprocess
import os
from typing import List
from libqtile import bar, layout, widget,hook
from libqtile.config import ( Click, Drag, Group, Key, Match,
                                Screen, ScratchPad, DropDown,)
from libqtile.lazy import lazy

modL = "mod4"
modR = "mod3"
altR = "mod5"

terminal = "alacritty"
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

keys = [
    # Switch between windows
    Key([modL], "h",
        lazy.layout.left(),
        desc="Move focus to left"
        ),
    Key([modL], "l",
        lazy.layout.right(),
        desc="Move focus to right"
        ),
    Key([modL], "j",
        lazy.layout.down(),
        desc="Move focus down"
        ),
    Key([modL], "k",
        lazy.layout.up(),
        desc="Move focus up"
        ),
    Key([modL], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    # Move windows around. Moving out range (Columns layout) creates new column.
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
    # xmonadlayout hotkeys
    Key([modL, "control"], "h",
        lazy.layout.grow(),
        desc="Grow selected window"
        ),
    Key([modL, "control"], "j",
        lazy.layout.shrink_main(),
        desc="Shrink main window"
        ),
    Key([modL, "control"], "k",
        lazy.layout.grow_main(),
        desc="Grow main window"
        ),
    Key([modL, "control"], "l",
        lazy.layout.shrink(),
        desc="Grow selected window"
        ),
    Key([modL], "space",
        lazy.layout.swap_main(),
        desc="Make selected window the main windos"
        ),
    Key([modL], "n",
        lazy.layout.flip(),
        desc="Draai main en secondary panes (niet bij xmonadthreecol!)"
        ),
    # Layout hotkeys
    Key([modL],"y",
        lazy.function(threecol),
        desc="Threecolumn selection, with margins"
        ),
    Key([modL],"u",
        lazy.function(threecol2),
        desc="Threecolumn selection without margins"
        ),
    Key([modL],"i",
        lazy.function(montall),
        desc="MonadTall selection"
        ),
    Key([modL],"o",
        lazy.function(montall2),
        desc="MonadTall selection without margins"
        ),
    Key([modL],"p",
        lazy.function(monwide),
        desc="MonadWide selection"
        ),
#    Key([modL],"=",
#        lazy.function(monwide2),
#        desc="MonadWide selection without margins"
#        ),
    Key([modL],"f",
        lazy.window.toggle_fullscreen(),
        desc="Fullscreen the current window"
        ),
    Key([modL],"b",
        lazy.hide_show_bar(position="top"),
        desc="hide/show bar"
        ),
    # multiple stack panes
    # FIXME: doesn't seem to work, probably for other layouts?
    Key([modL, "shift"],"Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"
    ),
    Key([modL], "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"),
   # Toggle between different layouts as defined below
    Key([modL], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
        ),
    Key([modL], "q",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
    Key([modL, "control"], "r",
        lazy.reload_config(),
        desc="Reload the config"
        ),
    Key([modL, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
        ),
    Key([modL], "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
        ),
#    Key([modL], "z", #FIXME: would be nice to dynamically control..
#        lazy.layout.increase_margin(),
#        desc="Increase margin, tests...."
#        ),
#    Key([modL], "x", #FIXME: idem
#        lazy.layout.decrease_margin(),
#        desc="Increase margin, tests...."
#        ),

    # Audio keys
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

    # Open applications
    Key([modR], "a",
        lazy.spawn("python " + os.path.expanduser("~/.config/Aandelen.py")),
        lazy.spawn(termVim +os.path.expanduser("~/Stack/Documenten/Aandelen/aandelen_log.md")),
        desc="Open in vim:Open aandelen log en script"
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
        lazy.spawn(os.environ["HOME"]+"/.config/dmenuapps.sh"),
        desc="Launch My dmenu to open applications"
        ),
    Key([modR, "shift"], "d",
        lazy.spawn(os.environ["HOME"]+"/.config/dmenuUpdate.sh"),
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
        lazy.spawn("xfce4-screenshooter -s " + os.path.expanduser("~/Downloads")),
        desc="Choose what to screenshot and save in Downloads"
        ),
    Key([modR], "t",
        lazy.spawn("thunar"),
        desc="Launch Thunar filemanager"
        ),
    #FIXME: modify the script because characters are not imported in emacs org mode
    Key([modR], "u",
        lazy.spawn(os.path.expanduser("~/.config/dmenuunicode.sh")),
        desc="Insert unicode, emojis :-)"
        ),
    Key([modR], "w",
        lazy.spawn(os.environ["HOME"]+"/.config/dmenuwallpaper.sh"),
        desc="Change wallpapers and select in dmenu"
        ),

    Key([altR], "a",
        lazy.spawn(Emacs +os.path.expanduser("~/Stack/Documenten/Aandelen/aandelen_log.md")),
        desc="Open in emacs:aandelen log"
        ),
    Key([altR], "b",
        lazy.spawn(termVim +os.path.expanduser("~/.bashrc")),
        desc="Open in vim: .bashrc"
        ),
    Key([altR], "c",
        lazy.spawn(Emacs +os.path.expanduser("~/Stack/Command_line/commands.org")),
        desc="Open in Emacs: commands.org"
        ),
    Key([altR], "u",
        lazy.spawn(termVim +os.path.expanduser("~/.config/urls")),
        desc="Open in vim: urls list used for newsboat"
        ),
    Key([altR], "d",
        lazy.spawn(termVim +os.path.expanduser("~/.config/suckless/dwm/config.h")),
        desc="Open in vim: config.h of my dwm build"
        ),
    Key([altR], "i",
        lazy.spawn(termVim +os.path.expanduser("~/.config/i3/config")),
        desc="Open in vim: config of my i3 build"
        ),
    Key([altR], "n",
        lazy.spawn(termVim +os.path.expanduser("~/.newsboat/config")),
        desc="Open in vim: config of newsboat"
        ),
    Key([altR], "q",
        lazy.spawn(Emacs +os.path.expanduser("~/.config/qtile/README.org")),
        desc="Open in emacs:Open qtile config"
        ),
    Key([altR], "r",
        lazy.spawn(termVim +os.path.expanduser("~/README.md")),
        desc="Open in vim: README.md of github dotfiles repo"
        ),
    Key([altR], "v",
        lazy.spawn(termVim +os.path.expanduser("~/.vimrc")),
        desc="Open in vim:"
        ),
    Key([altR], "w",
        lazy.spawn(os.path.expanduser("~/.config/wololo.sh")),
        desc="Launch shellscript"
        ),
    Key([altR], "x",
        lazy.spawn(termVim +os.path.expanduser("~/.xinitrc")),
        desc="Open in vim: .xinitrc"
        ),
    Key([altR], "r",
        lazy.spawn(termVim +os.path.expanduser("~/.Xresources")),
        desc="Open in vim: .Xresources"
        ),
    Key([altR], "z",
        lazy.spawn(termVim +os.path.expanduser("~/.zshrc")),
        desc="Open in vim: .zshrc"
        ),
]

#groups = [Group(i) for i in "123456789"]
groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [modL],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1+shift+group letter= move focused window to group(no follow)
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

layout_theme = {"border_width": 2,
#                "margin": 20,
                "border_focus": "#00ffd2",  #98C379= groen
                "border_normal": "#282C34",
                }

layouts = [
    layout.MonadThreeCol(**layout_theme, min_ratio=0.05, max_ratio=0.9,
                         new_client_position='bottom'),
    layout.MonadThreeCol(**layout_theme, margin=20, min_ratio=0.05,
                         max_ratio=0.9, new_client_position='bottom'),
    layout.MonadTall(**layout_theme, min_ratio=0.05, max_ratio=0.9,
                     new_client_position='bottom'),
    layout.MonadTall(**layout_theme, margin=20, min_ratio=0.05,
                     max_ratio=0.9, new_client_position='bottom'),
    layout.MonadWide(**layout_theme, min_ratio=0.05, max_ratio=0.9,
                     new_client_position='bottom'),
    layout.MonadWide(**layout_theme, margin=20, min_ratio=0.05,
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
                widget.CurrentLayout(foreground="#555555"),
                widget.Prompt(foreground="#555555"),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.QuickExit(foreground="#282C34"),
                widget.Volume(foreground="#d75f5f"),
                widget.Systray(),
                widget.Clock(format="%d%b%y %H:%M",foreground="#555555"),
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
floating_layout = layout.Floating(
    float_rules=[
        # Run utility of `xprop` to see the wm class and name of an X client
        *layout.Floating.default_float_rules,
        Match(wm_class="gimp"),  # gimp image editor
        Match(wm_class="keepass2"),  # keepass password editor
    ]
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
