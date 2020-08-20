/* See LICENSE file for copyright and license details.
 ______        ____  __   ____             _                    _ _
|  _ \ \      / /  \/  | |  _ \ _ __ _   _| |_ ___  ___ _ __ __| | |_
| | | \ \ /\ / /| |\/| | | |_) | '__| | | | __/ __|/ _ \ '__/ _` | __|
| |_| |\ V  V / | |  | | |  __/| |  | |_| | |_\__ \  __/ | | (_| | |_
|____/  \_/\_/  |_|  |_| |_|   |_|   \__,_|\__|___/\___|_|  \__,_|\__|
*/

// appearance                                                      comments
static const unsigned int borderpx  = 2;                        // Border pixel of windows
static const unsigned int snap      = 32;                       // Snap pixel
static const unsigned int gappih    = 60;                       // Horiz inner gap between windows
static const unsigned int gappiv    = 60;                       // Vert inner gap between windows
static const unsigned int gappoh    = 50;                       // Horiz outer gap between windows and screen edge
static const unsigned int gappov    = 50;                       // Vert outer gap between windows and screen edge
static const int smartgaps          = 1;                        // 1 means no outer gap when there is only one window
static const int showbar            = 1;                        // 0 means no bar
static const int topbar             = 1;                        // 0 means bottom bar
static const char *fonts[]          = { "hack:size=9" };        // Font of statusbar
static const char black[]           = "#000000";                // Color of background
static const char dark_gray[]       = "#111111";                // Color of not selected borders
static const char gray[]            = "#555555";                // Color of (not selected) menubar text
static const char green[]           = "#8ec07c";                // Gruvbox color: slightly desaturaded green
static const char *colors[][3]      =
{
    //name           fg     bg      border
	[SchemeNorm] = { gray,  black,  dark_gray},
	[SchemeSel]  = { green, black,  green},      
};

typedef struct 
{
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {"st", "-n", "spvifm", "-g", "144x41", "-e", "vifm", NULL };
const char *spcmd3[] = {"st", "-n", "spcalc", "-g", "95x35", "-e", "qalculate-gtk", NULL };
const char *spcmd4[] = {"st", "-n", "spexit", "-g", "15x10", "-e", "/home/icefly/.config/exitdwm.sh", NULL };
const char *spcmd5[] = {"st", "-n", "spkeepass", "-g", "120x34", "-e", "keepass", NULL };
static Sp scratchpads[] =
{
    //name          cmd         Scratchpads, to show/hide apps in floating mode
	{"spterm",      spcmd1}, // terminal
	{"spvifm",      spcmd2}, // vifm
	{"spcalc",      spcmd3}, // calculator
	{"spexit",      spcmd4}, // exit dwm
	{"spkeepass",   spcmd5}, // keepass
};

// Tagging
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; /* Nine tags available */

static const Rule rules[] =
{
    // xprop(1): WM_CLASS(STRING) = instance, class,  WM_NAME(STRING) = title
    //class       instance    title       tags mask     isfloating   isterminal noswallow monitor      comment
	{ "Gimp",     NULL,       NULL,       0,            1,           0,         0,        -1 },     // gimp, floating 
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           0,         0,        -1 },     // firefox: on tag 1
	{ "st",       NULL,       NULL,       0,            0,           1,         1,        -1 },     // st: swallowing
    { "Steam",    NULL,       NULL,       0,            1,           0,         0,        -1 },     // steam
    { "keepass",  NULL,       NULL,       0,            1,           0,         0,        -1 },     // keepass, floating
	{ NULL,		  "spterm",   NULL,		  SPTAG(0),		1,			 1,         1,        -1 },     // st: as scratchpad
	{ NULL,		  "spvifm",	  NULL,		  SPTAG(1),		1,			 1,         1,        -1 },     // vifm: as scratchpad 
	{ NULL,		  "spcalc",	  NULL,		  SPTAG(2),		1,			 1,         1,        -1 },     // calculator: as scratchpad
	{ NULL,		  "spexit",	  NULL,		  SPTAG(3),		1,			 1,         1,        -1 },     // exit dwm: as scratchpad
	{ NULL,		  "spkeepass",NULL,		  SPTAG(4),		1,			 1,         1,        -1 },     // keepass: as scratchpad
};

// Layout(s)
static const float mfact     = 0.5;         // factor of master area size [0.05..0.95]
static const int nmaster     = 1;           // number of clients in master area
static const int resizehints = 0;           // 1 means respect size hints in tiled resizals

#include "layouts.c"
#include "vanitygaps.c"
static const Layout layouts[] =
{
	// symbol     arrange function             comments
	{ "|M|",      centeredmaster },         // First one is default layout. Masters horizontally in middle, slaves on sides horizontally
	{ "[]=",      tile },                   // Tile layout. Master left horizontally, slaves right horizontally
	{ "><>",      NULL },                   // Floating mode, no layout function
	{ "[M]",      monocle },                // All windows on top of eachother
	{ "HHH",      grid },                   // Grid layout, no discrimination master/slave
	{ ">M>",      centeredfloatingmaster }, // As centered master, but then the master floats
	{ "TTT",      bstack },                 // Master on top vertically, slave on bottom verticall
	{ "|||",      col },                    // Column layout. Master left vertically, slaves right horizontally
};

// Key definitions
#define MODKEY Mod4Mask                     // Left Superkey : MODKEY
#define MENUFILE Mod5Mask                   // Right Superkey: open applications
#define MENUKEY Mod3Mask                    // Right Alt key : open text files in VIM
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#include <X11/XF86keysym.h>
static Key keys[] =
{
	// modifier                     key        function        argument                                                            comments
    // XF86XK keys
    { 0,			XF86XK_AudioRaiseVolume,   spawn,	       SHCMD("amixer -q set Master 5%+ & ~/.config/updatebar.sh") },    // Volume up. Update statusbar
	{ 0,			XF86XK_AudioLowerVolume,   spawn,	       SHCMD("amixer -q set Master 5%- & ~/.config/updatebar.sh") },    // Volume down. Update statusbar
	{ 0,			XF86XK_AudioMute,	       spawn,	       SHCMD("amixer -q set Master toggle & ~/.config/updatebar.sh") }, // Toggle mute
    { 0,            XK_Print,   		       spawn,		   SHCMD("xfce4-screenshooter -r -s ~/Downloads") },                // Select by mouse what to print from screen
    // Right alt key to open textfiles                                                                                             Open textfile in vim:
	{ MENUFILE,                     XK_a,      spawn,          SHCMD("st -e vim ~/.config/applications.md") },                  // used application for my Arch linux build
	{ MENUFILE,                     XK_b,      spawn,          SHCMD("st -e vim ~/.bashrc") },                                  // .bashrc
	{ MENUFILE,                     XK_c,      spawn,          SHCMD("st -e vim ~/Stack/Command_line/commands.md") },           // personal notes and comments about Linux
	{ MENUFILE,                     XK_d,      spawn,          SHCMD("st -e vim ~/suckless/dwm/config.h") },                    // dwm config file
	{ MENUFILE,                     XK_f,      spawn,          SHCMD("st -e vim ~/.config/urls") },                             // firefox url list, used in dmenuinternet.sh
	{ MENUFILE|ShiftMask,           XK_f,      spawn,          SHCMD("st -e vim ~/.config/dmenuinternet.sh") },                 // dmenu to open url list in firefox
	{ MENUFILE,                     XK_i,      spawn,          SHCMD("st -e vim ~/.config/i3/config") },                        // i3 config file
	{ MENUFILE,                     XK_n,      spawn,          SHCMD("st -e vim ~/.newsboat/urls") },                           // newsboat urls file
	{ MENUFILE|ShiftMask,           XK_n,      spawn,          SHCMD("st -e vim ~/.newsboat/config") },                         // newsboat config file
	{ MENUFILE,                     XK_r,      spawn,          SHCMD("st -e vim ~/.config/ranger/rc.conf") },                   // ranger config file
	{ MENUFILE|ShiftMask,           XK_r,      spawn,          SHCMD("st -e vim ~/README.md") },                                // my github dotfiles README file
	{ MENUFILE,                     XK_s,      spawn,          SHCMD("st -e vim ~/suckless/st/config.h") },                     // st 'config' file
	{ MENUFILE,                     XK_v,      spawn,          SHCMD("st -e vim ~/.vimrc") },                                   // vim 'config' file
	{ MENUFILE|ShiftMask,           XK_v,      spawn,          SHCMD("st -e vim ~/.config/vifm/vifmrc") },                      // vifm 'config' file
	{ MENUFILE,                     XK_x,      spawn,          SHCMD("st -e vim ~/.xinitrc") },                                 // .xinitrc
	{ MENUFILE|ShiftMask,           XK_x,      spawn,          SHCMD("st -e vim ~/.Xresources") },                              // .Xresources
    // Right super as application modkey                                                                                           Open application:
	{ MENUKEY,                      XK_d,      spawn,          SHCMD("~/.config/dmenuapps.sh") },                               // dmenu
    { MENUKEY,                      XK_f,      spawn,          SHCMD("~/.config/dmenuinternet.sh") },                           // dmenuinternet
    { MENUKEY|ShiftMask,            XK_f,      spawn,          SHCMD("firefox") },                                              // Firefox
	{ MENUKEY,                      XK_g,      spawn,          SHCMD("gimp") },                                                 // gimp
	{ MENUKEY,                      XK_m,      spawn,          SHCMD("mousepad") },                                             // mousepad
	{ MENUKEY,                      XK_n,      spawn,          SHCMD("st -e newsboat") },                                       // newsboat, open in st
    { MENUKEY,                      XK_s,      spawn,          SHCMD("~/.config/dmenusurf.sh") },                               // surf
	{ MENUKEY,                      XK_t,      spawn,          SHCMD("~/.config/dmenuthunar.sh") },                             // thunar
	{ MENUKEY|ShiftMask,            XK_t,      spawn,          SHCMD("thunar") },                                               // thunar
	{ MENUKEY,                      XK_u,      spawn,          SHCMD("~/.config/dmenuunicode.sh") },                            // Insert emojis
	{ MENUKEY,                      XK_v,      spawn,          SHCMD("st -e vifm") },                                           // vifm
	{ MENUKEY,                      XK_w,      spawn,          SHCMD("~/.config/dmenuwallpaper.sh") },                          // Change wallpaper by dmenu
    // Left super as modkey                                                                                                        dwm related (modkey):
	{ MODKEY,                       XK_b,      togglebar,      {0} },                                                           // Toggle the visibility of the bar
	{ MODKEY,                       XK_Return, spawn,	       SHCMD("st") },                                                   // Open terminal
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },                                                    // Select another window, direction: up the stack
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },                                                    // Select another window, direction: down the stack
	{ MODKEY|ShiftMask,             XK_j,      inplacerotate,  {.i = +1} },                                                     // InPlaceRotate:
	{ MODKEY|ShiftMask,             XK_k,      inplacerotate,  {.i = -1} },                                                     // InPlaceRotate:
	{ MODKEY|ShiftMask,             XK_h,      inplacerotate,  {.i = +2} },                                                     // InPlaceRotate:
	{ MODKEY|ShiftMask,             XK_l,      inplacerotate,  {.i = -2} },                                                     // InPlaceRotate:
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },                                                    // nmastery, add master
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },                                                    // nmaster, remove master
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.02} },                                                  // Make master window more narrow
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.02} },                                                  // Make master window more wide
	{ MODKEY,                       XK_space,  zoom,           {0} },                                                           // Swap a master and slave window
	{ MODKEY,                       XK_Tab,    view,           {0} },                                                           // Switch to previous tag
	{ MODKEY,                       XK_q,      killclient,     {0} },                                                           // Kill the selected window, similar to CTL-
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[0]} },                                            // Layout: centeredmaster
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[1]} },                                            // Layout: tile
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[2]} },                                            // Layout: floating
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[3]} },                                            // Layout: monocle
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[4]} },                                            // Layout: grid
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },                                            // Layout: centeredfloatingmaster
	{ MODKEY,                       XK_p,      setlayout,      {.v = &layouts[6]} },                                            // Layout: bottomstack
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[7]} },                                            // Layout: column
	{ MODKEY,                       XK_a,      setlayout,      {0} },                                                           // Toggle between previous layout and current one back/forth
	{ MODKEY,		                XK_comma,  cyclelayout,    {.i = -1 } },                                                    // Cycle layout: backward
	{ MODKEY,                       XK_period, cyclelayout,    {.i = +1 } },                                                    // Cycle layout: forward
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },                                                           // Toggle current window in/out of floating mode
	{ MODKEY,                       XK_s,      togglesticky,   {0} },                                                           // Toggle current window to be sticky: visible in all tags
	{ MODKEY,                       XK_w,      view,           {.ui = ~0 } },                                                   // View the windows of all of the tags
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },                                                   // ?? select a window to show in all tags, similar to toggle sticky??
	{ MODKEY|ControlMask|ShiftMask, XK_comma,  focusmon,       {.i = -1 } },                                                    // Not used, single monitor system
	{ MODKEY|ControlMask|ShiftMask, XK_period, focusmon,       {.i = +1 } },                                                    // Not used, single monitor system
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },                                                    // Not used, single monitor system
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },                                                    // Not used, single monitor system
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} },                                                           // Restart dwm inplace
	{ MODKEY,                       XK_equal,  incrgaps,       {.i = +2 } },                                                    // Vanity gaps: increase gaps
    { MODKEY,                       XK_minus,  incrgaps,       {.i = -2 } },                                                    // Vanity gaps: decrease gaps
	{ MODKEY,                       XK_0,      togglegaps,     {0} },                                                           // Vanity gaps: toggle gaps on/of
    // scratchpads                                                                                                                 Scratchpads
    { MODKEY,            			XK_z,  	   togglescratch,  {.ui = 0 } },                                                    // Open st in scratchpad
	{ MODKEY,            			XK_v,	   togglescratch,  {.ui = 1 } },                                                    // Open vifm in scratchpad
    { 0,               XF86XK_Calculator,	   togglescratch,  {.ui = 2 } },                                                    // Open calculator
	{ MODKEY|ShiftMask,             XK_q,      togglescratch,  {.ui = 3 } },                                                    // Exit dwm with y/n options, in a small centered floating window
	{ MENUKEY,                      XK_k,      togglescratch,  {.ui = 4 } },                                                    // Exit dwm with y/n options, in a small centered floating window
    // Tagkeys
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

// Button definitions, for instance: ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, ClkRootWin
static Button buttons[] = 
{
    //click                 event mask      button          function        argument
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
