/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const double defaultopacity  = 0.75;
static const char *fonts[]          = { "unifont:size=8" };
static const char dmenufont[]       = "unifont:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   isterminal noswallow monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           0,         0,        -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           0,         0,        -1 },
	{ "st",       NULL,       NULL,       0,            0,           1,         1,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#include "layouts.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },                   /* first entry is default */
	{ "><>",      NULL },                   /* no layout function means floating behavior */
	{ "[M]",      monocle },                /* All windows on top of eachother */
	{ "HHH",      grid },                   /* Windows in grid layout*/
	{ "|M|",      centeredmaster },         /* Master in middle, slaves on sides */
	{ ">M>",      centeredfloatingmaster }, /* Same but master floats*/
};

/* key definitions */
#define MODKEY Mod4Mask
#define MENUFILE Mod5Mask
#define MENUKEY Mod3Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

#include <X11/XF86keysym.h>
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MENUFILE,                     XK_a,      spawn,          SHCMD("st -e vim ~/.config/applications.md") },
	{ MENUFILE,                     XK_b,      spawn,          SHCMD("st -e vim ~/.bashrc") },
	{ MENUFILE,                     XK_c,      spawn,          SHCMD("st -e vim /home/icefly/Stack/Command_line/commands.md") },
	{ MENUFILE|ShiftMask,           XK_d,      spawn,          SHCMD("st -e vim /home/icefly/dwm_configuratie.md") },
	{ MENUFILE,                     XK_d,      spawn,          SHCMD("st -e vim /home/icefly/dwm/config.def.h") },
	{ MENUFILE,                     XK_i,      spawn,          SHCMD("st -e vim ~/.config/i3/config") },
	{ MENUFILE|ShiftMask,           XK_r,      spawn,          SHCMD("st -e vim ~/README.md") },
	{ MENUFILE,                     XK_r,      spawn,          SHCMD("st -e vim ~/.config/ranger/rc.conf") },
	{ MENUFILE,                     XK_x,      spawn,          SHCMD("st -e vim ~/.xinitrc") },

    { MENUKEY,                      XK_f,      spawn,          SHCMD("firefox") },
	{ MENUKEY,                      XK_g,      spawn,          SHCMD("gimp") },
	{ MENUKEY,                      XK_k,      spawn,          SHCMD("keepass") },
	{ MENUKEY,                      XK_m,      spawn,          SHCMD("mousepad") },
	{ MENUKEY,                      XK_t,      spawn,          SHCMD("thunar") },
	{ MENUKEY,                      XK_u,      spawn,          SHCMD("cat ~/.config/unicode | dmenu -i -l 20 -fn unifont-08| awk '{print $1}'| xclip -selection clipboard") },
/*cat ~/.config/unicode | dmenu -i -l 25 -fn Monospace-24| awk '{print $1}'| xclip -selection clipboard && xdotool type "$(xclip -o -selection clipboard)" */
/*special keys*/
	{ MENUKEY,                      XK_v,      spawn,          SHCMD("st -e vifm") },
/*	{ MENUKEY,                      XK_w,      spawn,          SHCMD("ls ~/Stack/Afbeeldingen/Wallpapers/*.* | dmenu -i -l 20 -fn unifont-08| awk '{print $1}'| xclip -selection clipboard && wal -i "$(xclip -o -selection clipboard)"") },*/
	{ MENUKEY,                      XK_w,      spawn,          SHCMD("/home/icefly/.config/dmenuunicode.sh") },

	{ 0,			XF86XK_AudioRaiseVolume,   spawn,	       SHCMD("amixer -q set Master 5%+") },
	{ 0,			XF86XK_AudioLowerVolume,   spawn,	       SHCMD("amixer -q set Master 5%-") },
	{ 0,			XF86XK_AudioMute,	       spawn,	       SHCMD("amixer -q set Master toggle, NULL") }, 
    { 0,            XF86XK_Calculator,		   spawn,		   SHCMD("st -e bc -l") }, 
    { 0,            XK_Print,   		       spawn,		   SHCMD("xfce4-screenshooter") }, 
    
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,		        XK_s,	   spawn,	       SHCMD("transset-df -a --dec .1") },
	{ MODKEY|ShiftMask,		        XK_d,	   spawn,	       SHCMD("transset-df -a --inc .1") },
	{ MODKEY|ShiftMask,		        XK_f,	   spawn,	       SHCMD("transset-df -a .75") },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },/**/
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },/**/
	{ MODKEY|ShiftMask,             XK_j,      inplacerotate,  {.i = +1} },
	{ MODKEY|ShiftMask,             XK_k,      inplacerotate,  {.i = -1} },
	{ MODKEY|ShiftMask,             XK_h,      inplacerotate,  {.i = +2} },
	{ MODKEY|ShiftMask,             XK_l,      inplacerotate,  {.i = -2} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.02} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.02} },
/*Vanity gaps settings*/
	{ MODKEY,                        XK_equal, incrgaps,       {.i = +2 } },
    { MODKEY,                        XK_minus, incrgaps,       {.i = -2 } },
	{ MODKEY,                        XK_0,     togglegaps,     {0} },
/*Vanity gaps controls, also commented out in dmw.c*/
/*	{ MENUKEY|ShiftMask,             XK_h,     incrogaps,      {.i = +1 } },*/
/*	{ MENUKEY|ShiftMask,             XK_l,     incrogaps,      {.i = -1 } },*/
/*  { MENUKEY|ControlMask,           XK_h,     incrigaps,      {.i = +1 } },*/
/*	{ MENUKEY|ControlMask,           XK_l,     incrigaps,      {.i = -1 } },*/
/*	{ MENUKEY|ShiftMask,             XK_1,     defaultgaps,    {0} },*/
/*	{ MENUKEY,                       XK_y,     incrihgaps,     {.i = +1 } },*/
/*	{ MENUKEY,                       XK_o,     incrihgaps,     {.i = -1 } },*/
/*	{ MENUKEY|ControlMask,           XK_y,     incrivgaps,     {.i = +1 } },*/
/*	{ MENUKEY|ControlMask,           XK_o,     incrivgaps,     {.i = -1 } },*/
/*	{ MENUKEY|Mod4Mask,              XK_y,     incrohgaps,     {.i = +1 } },*/
/*	{ MENUKEY|Mod4Mask,              XK_o,     incrohgaps,     {.i = -1 } },*/
/*	{ MENUKEY|ShiftMask,             XK_y,     incrovgaps,     {.i = +1 } },*/
/*	{ MENUKEY|ShiftMask,             XK_o,     incrovgaps,     {.i = -1 } },*/

	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },/* title */
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[1]} },/**/
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },/* monocle*/
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },/* grid */
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[4]} },/* centeredmaster*/
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },/* centeredfloatingmaster*/
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
/*  { MODKEY,                       XK_f,      togglefullscr,  {0} },  Real fullscreen, dwm.c aanpassen zie lukesmith github*/
	{ MODKEY,                       XK_s,      togglesticky,   {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} }, 
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
