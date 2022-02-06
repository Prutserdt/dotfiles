import os

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import ( Click, Drag, Group, Key, Match, 
                                Screen, ScratchPad, DropDown,)
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

modL = "mod4"
modR = "mod3"
altR = "mod5"

terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([modL], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([modL], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([modL], "j", lazy.layout.down(), desc="Move focus down"),
    Key([modL], "k", lazy.layout.up(), desc="Move focus up"),
    Key([modL], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([modL, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([modL, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([modL, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([modL, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([modL, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([modL, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([modL, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([modL, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([modL],"b", lazy.hide_show_bar(position="top"), desc="hide/show bar"),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),

    #Right superkey for opening of applications.
    Key([modR], "b", lazy.spawn("brave"), desc="Brave browser"),
    Key([modR], "d", lazy.spawn(os.environ["HOME"]+"/.config/dmenuapps.sh"), desc="My dmenu to open applications"),
    Key([modR], "f", lazy.spawn("firefox"), desc="Firefox browser"),
    Key([modR], "g", lazy.spawn("gimp"), desc="Gimp image manipulation"),
    Key([modR], "k", lazy.spawn("keepass"), desc="Keepass password manager"),
    Key([modR], "m", lazy.spawn("mousepad"), desc="Mousepad notepad"),
    Key([modR], "t", lazy.spawn("thunar"), desc="Thunar filemanager"),
    Key([modR], "w", lazy.spawn("wing-101-8"), desc="Wing 101 Python IDE"),

    #Right alt for opening of files in vim
    Key([altR], "c", lazy.spawn("alacritty -e vim " + os.path.expanduser("~/Stack/Command_line/commands.md")), desc=""),
    Key([altR], "a", lazy.spawn("python " + os.path.expanduser("~/.config/Aandelen.py")),
    lazy.spawn("alacritty -e vim " +os.path.expanduser("~/Stack/Documenten/Aandelen/aandelen_log.md")),
        desc="Open aandelen log en script"),
    #Key([altR], "a", lazy.spawn(os.path.expanduser("~/.config/aandelen.sh")), desc="Open aandelen.sh script"),
    Key([altR], "b", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.bashrc")), desc=""),
    Key([altR], "c", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/Stack/Command_line/commands.md")), desc=""),
    Key([altR], "u", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.config/urls")), desc=""),
    Key([altR], "d", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.config/suckless/dwm/config.h")), desc=""),
    Key([altR], "i", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.config/i3/config")), desc=""),
    Key([altR], "n", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.newsboat/config")), desc=""),
    Key([altR], "q", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.config/qtile/config.py")), desc="Open qtile config"),
    Key([altR], "r", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/README.md")), desc=""),
    Key([altR], "v", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.vimrc")), desc=""),
    Key([altR], "w", lazy.spawn(os.path.expanduser("~/.config/wololo.sh")), desc=""),
    Key([altR], "x", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.xinitrc")), desc=""),
    Key([altR], "r", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.Xresources")), desc=""),
    Key([altR], "z", lazy.spawn("alacritty -e vim " +os.path.expanduser("~/.zshrc")), desc=""),

    # multiple stack panes
    Key(
        [modL, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([modL], "Return", lazy.spawn(terminal), desc="Launch terminal"),

   # Toggle between different layouts as defined below
    Key([modL], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([modL], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([modL, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([modL, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([modL], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "123456789"]

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
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [modL, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


groups.append(
    ScratchPad("scratchpad", [
        DropDown("1", "qalculate-gtk", x=0.0, y=0.0, width=0.2, height=0.3,on_focus_lost_hide=False),
    ])
)

keys.extend([
        Key([], "XF86Calculator", lazy.group["scratchpad"].dropdown_toggle("1")),
])

layouts = [
    layout.Columns(num_columns=3),
    layout.Columns(),
    layout.Max(),
    layout.Bsp(),
    layout.Matrix(),
    layout.MonadTall(),
    layout.MonadWide(),
    layout.RatioTile(),
    layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
    #layout.Stack(num_stacks=2),
### TODO: nieuwe layout komt eraan soort centeredmaster:
### layout.MonadThreeCol(),
]

widget_defaults = dict(
    font="hack",
#    font="sans",
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
#                widget.TextBox("default config", name="default"),
#                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.QuickExit(foreground="#282C34"),
                widget.Volume(foreground="#d75f5f"),
                widget.Systray(),
                widget.Clock(format="%d%b%y %H:%M",foreground="#555555"),
            ],
            24,
           # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
           # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([modL], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([modL], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([modL], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="gimp"),  # gimp image editor
        Match(wm_class="keepass2"),  # keepass password editor
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True # handy for steam games

wmname = "LG3D"
