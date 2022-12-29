# NOTE: This file is generated from the README.org file. Do not alter
# config.el directly and only modify the README.org file in emacs by
# 'M-x' 'org-babel-tangle' and reload by 'M-x' 'doom/reload'

import psutil, subprocess, os
from typing import List
from libqtile import bar, layout, widget,hook
from libqtile.config import ( Click, Drag, Group, Key, KeyChord, Match,
                                Screen, ScratchPad, DropDown,)
from libqtile.lazy import lazy

mL = "mod4"                       # Left super key, dedicated to the windowmanager
mR = "mod3"                       # Right super key, dedicated to open applications
aR = "mod5"                       # Right alt key, dedicated to opening of files

home = os.path.expanduser("~")
termVim="alacritty -e vim "         # Open vim in alacritty (used for aR hotkeys)
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
    #self.group.MonadThreeCol()
#    self.group.cmd_to_layout_index(2) #2: monadtall with margins

def cmd_decrease_margin(self): ### FIXME werkt NIET!
    new_margin = self.margin - 10
    if new_margin < 0:
        new_margin = 0
    self.margin = new_margin
    self.group.layout_all()
    #self.group.cmd_to_layout_index(2) #2: monadtall with margins
    #self.group.MonadThreeCol()

#onderstaande wil ik ombouwen om de keybindings eenvoudiger te maken
# FIXME: werkt nog NIET!!

def keyb(toets, programma, description):
    samengevoegd ='Key([mR], "' + toets +'" , lazy.spawn("' + programma + '"), desc="' + description +  '"),'
    #samengevoegd =str('Key([mR], "' + toets +'" , lazy.spawn("' + programma + '"), desc="' + description +  '"),')
    return samengevoegd

keys = [
    KeyChord([mL], "m", [      # testje, keychording werkt!! :-)
        Key([], "u",lazy.spawn("amixer -q set Master 5%+")),
        Key([], "i",lazy.spawn("amixer -q set Master 5%-")),
        Key([], "k", lazy.function(cmd_increase_margin)),  ### FIXME werkt NIET:!
        Key([], "j", lazy.funtion(cmd_decrease_margin))    ### FIXME werkt NIET:!
        ],
        mode="Margins" # als je mode kiest dan moet je eruit met escape....
        ),
#   KeyChord([mL], "z", [  # example of keychording
#       Key([], "k", lazy.layout.grow_main()),
#       Key([], "j", lazy.layout.shrink_main()),
#       Key([], "i", lazy.layout.grow()),
#       Key([], "u", lazy.layout.shrink()),
#       Key([], "n", lazy.layout.normalize()),
#       Key([], "m", lazy.layout.maximize())
#       ],
#       mode="Windows"
#       ),
    Key([mL], "a",
        lazy.function(cmd_increase_margin), ### FIXME werkt NIET:
        desc="increase margin..."
        ),
    Key([mL, "shift"], "a",
        lazy.function(cmd_decrease_margin), ### FIXME werkt NIET:
        desc="decrease margin..."
        ),
    Key([mL], "Return", lazy.spawn("alacritty"),        desc="Launch terminal in new window"),
    Key([mL], "space", lazy.layout.swap_main(),         desc="Make main window of selected window"),
    Key([mL], "b", lazy.hide_show_bar(position="top"),  desc="Toggle the bar"),
    Key([mL], "f", lazy.window.toggle_fullscreen(),     desc="Fullscreen the current window"),
    Key([mL], "r", lazy.spawncmd(),                     desc="Prompt commands from taskbar"),
    Key([mL], "t", lazy.window.toggle_floating(),       desc="Toggle floating state"),
    Key([mL], "q", lazy.window.kill(),                  desc="Kill focused window"),
    Key([mL,  "control"], "r", lazy.reload_config(),    desc="Reload the Qtile configuration"),
    Key([mL,  "shift"], "q", lazy.spawn("alacritty -e"+ home + "/.config/exitqtile.sh"), desc="Shutdown Qtile by a shellscript"),
    
    #Hotkeys to move windows around, resize windows and choose layouts
    Key([mL], "h", lazy.layout.left(),                  desc="Move window focus to the left"),
    Key([mL], "l", lazy.layout.right(),                 desc="Move window focus to the right"),
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
    Key([mL], "y", lazy.function(montall),              desc="Layout: MonadTall no margins"),
    Key([mL], "u", lazy.function(threecol),             desc="Layout: Threecolumn  without margins"),
    Key([mL], "i", lazy.function(monwide),              desc="Layout: MonadWide no margins"),
    Key([mL], "6", lazy.function(montall2),             desc="Layout: MonadTall margins"),
    Key([mL], "7", lazy.function(threecol2),            desc="Layout: Threecolumn  margins"),
    Key([mL], "8", lazy.function(monwide2),             desc="Layout: MonadWide  margins"),

    # Hotkeys for audio and printscreen
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "Print", lazy.spawn("xfce4-screenshooter -r -s " + home + "/Downloads")),
    Key(["shift"], "Print", lazy.spawn(home + "/.config/screenshot2text.sh")),

    # Open applications
    Key([mR], "a",
        lazy.spawn("python " + home + "/.config/Aandelen.py"),
        lazy.spawn(Emacs + home + "/Stack/Documenten/Aandelen/aandelen_log.org"),
        desc="Open in vim: run het python aandelen script en open het aandelen log"
        ),
    #keyb(b,brave, LaunchBravebrowser)
    #lazy.function(keyb(b, brave, LaunchBravebrowser)),
    #lazy.function(keyb(b, brave, LaunchBravebrowser)),
    #(lazy.function(keyb("b","brave", "Launch Brave browser")))
    #lazy.function(keyb("b","brave", "Launch Brave browser")),#FIXME: wil keybinds versimpelen...
    # even kijken of ik het met EzKey ga doen!!! weet niet of mL en mR gaaat werken....
    
#    Key([mR], "b", lazy.spawn("brave" ),desc="Launch Brave browser"),
#    Key([mR], "b", lazy.spawn("brave")),
    Key([mR], "b", lazy.spawn(home + "/.config/dmenuinternet.sh")),
    Key([mR], "e", lazy.spawn("emacsclient -c -a 'emacs'")), 
    Key([mR], "d", lazy.spawn(home + "/.config/dmenuapps.sh")),
    Key([mR, "shift"], "d", lazy.spawn(home + "/.config/dmenuUpdate.sh")), 
    Key([mR], "f", lazy.spawn("firefox")), 
    Key([mR], "g", lazy.spawn("gimp")), 
    Key([mR], "k", lazy.spawn("keepass")), 
    Key([mR], "m", lazy.spawn("mousepad")), 
    Key([mR], "s", lazy.spawn("xfce4-screenshooter -s " + home + "~/Downloads")), 
    Key([mR], "t", lazy.spawn("thunar")), 
    Key([mR], "u", lazy.spawn(home + "/.config/dmenuunicode.sh")),
    Key([mR], "w", lazy.spawn(home + "/.config/dmenuwallpaper.sh")),

    Key([aR], "a", lazy.spawn(Emacs + home + ("/Stack/Documenten/Aandelen/aandelen_log.org"))),
    Key([aR], "b", lazy.spawn(Emacs + home + "/.bashrc")), 
    Key([aR], "c", lazy.spawn(Emacs + home + "/Stack/Command_line/commands.org")), 
    Key([aR], "d", lazy.spawn(Emacs + home + "/.config/suckless/dwm/config.h")), 
    Key([aR], "e", lazy.spawn(Emacs + home + "/.doom.d/README.org")), 
    Key([aR], "i", lazy.spawn(Emacs + home + "/.config/i3/config")), 
    Key([aR], "n", lazy.spawn(Emacs + home + "/.newsboat/config")), 
    Key([aR], "p", lazy.spawn(Emacs + home + "/Arduino/PowerStrike/README.org")), 
    Key([aR], "q", lazy.spawn(Emacs + home + "/.config/qtile/README.org")), 
    Key([aR, "shift"], "r", lazy.spawn(Emacs + home + "/README.org")), 
    Key([aR], "r", lazy.spawn(Emacs + home + "/.Xresources")), 
    Key([aR], "u", lazy.spawn(Emacs + home + "/.config/urls")), 
    Key([aR], "v", lazy.spawn(termVim + home + "/.vimrc")), 
    Key([aR], "w", lazy.spawn(home + "/.config/wololo.sh")), 
    Key([aR], "x", lazy.spawn(Emacs + home + "/.xinitrc")), 
    Key([aR], "z", lazy.spawn(Emacs + home + "/.zshrc")), 
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            # mL + letter of group = switch to group
            Key(
                [mL],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mL+shift+group letter= move focused window to group(no follow)
            Key(
                [mL, "shift"],
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
                "border_focus":  "#d75f5f",
                "border_normal": "#282C35", #966363
                "min_ratio": 0.05, "max_ratio": 0.9,
                "new_client_position":'bottom', # FIXME: does NOT open on bottom!
                }
# A separate theme for floating mode, different color, thicker border width
floating_theme = {"border_width": 3,
                "border_focus": "#00ffd2",  #98C379= groen
                "border_normal": "#006553",
                }

layouts = [
   layout.MonadThreeCol(**layout_theme),
   layout.MonadThreeCol(**layout_theme, margin=60),
   layout.MonadTall(**layout_theme),
   layout.MonadTall(**layout_theme, margin=60),
   layout.MonadWide(**layout_theme),
   layout.MonadWide(**layout_theme, margin=60),
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
