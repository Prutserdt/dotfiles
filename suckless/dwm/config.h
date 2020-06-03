/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;                        /* border pixel of windows */
static const unsigned int snap      = 32;                       /* snap pixel */
static const unsigned int gappih    = 10;                       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;                       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;                       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;                       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 1;                        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;                        /* 0 means no bar */
static const int topbar             = 1;                        /* 0 means bottom bar */
static const double defaultopacity  = 0.75;                     /* Set the opacity of windows */
static const char *fonts[]          = { "monospace:size=8" };   /* Font of statusbar */
static const char dmenufont[]       = "monospace:size=10";      /* Font of dmenu*/
static const char normbgcol[]       = "#000000";                /* Color of background*/
static const char normbordercol[]   = "#111111";                /* Color of not selected borders */
static const char normfgcol[]       = "#999999";                /* Color of foreground, menubar text color not selected, incl rigth */
static const char selfgcol[]        = "#eeeeee";                /* Color of selected foreground*/
static const char selbgcol[]        = "#111111";                /* Color of menubar*  */
static const char selbordercol[]    = "#770000";                /* Color of selected window border */

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { normfgcol, normbgcol, normbordercol },
	[SchemeSel]  = { selfgcol,  selbgcol,  selbordercol },      /* Als ik de kleuren laat zoals nu dan kan dit vereenvoudigd worden...*/
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
static const float mfact     = 0.4; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#include "layouts.c"
#include "vanitygaps.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },                   /* first entry is default */
	{ "><>",      NULL },                   /* no layout function means floating behavior */
	{ "[M]",      monocle },                /* All windows on top of eachother */
	{ "HHH",      grid },                   /* Windows in grid layout*/
	{ "|M|",      centeredmaster },         /* Master in middle, slaves on sides */
	{ ">M>",      centeredfloatingmaster }, /* Same but master floats*/
	{ "TTT",      bstack },                 /* Master on top half, slave on bottom horizontally*/
	{ "|||",      col },

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
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcol, "-nf", normfgcol, "-sb", selbgcol, "-sf", selbordercol, NULL };

#include <X11/XF86keysym.h>
static Key keys[] = {
	/* modifier                     key        function        argument                                                         comment */
                                                                                                                                /****   XF86XK keys   ****/
	{ 0,			XF86XK_AudioRaiseVolume,   spawn,	       SHCMD("amixer -q set Master 5%+ & ~/.config/updatebar.sh") },    /* Volume up. Update statusbar */
	{ 0,			XF86XK_AudioLowerVolume,   spawn,	       SHCMD("amixer -q set Master 5%- & ~/.config/updatebar.sh") },    /* Volume down. Update statusbar */
	{ 0,			XF86XK_AudioMute,	       spawn,	       SHCMD("amixer -q set Master toggle, NULL") },                    /* Toggle mute */
    { 0,            XF86XK_Calculator,		   spawn,		   SHCMD("st -e bc -l") },                                          /* Calculator */
    { 0,            XK_Print,   		       spawn,		   SHCMD("xfce4-screenshooter") },                                  /* Print screen */

                                                                                                                                /* Right alt key to open textfiles */
	{ MENUFILE,                     XK_a,      spawn,          SHCMD("st -e vim ~/.config/applications.md") },                  /* txt: used application for my Arch linux build */
	{ MENUFILE,                     XK_b,      spawn,          SHCMD("st -e vim ~/.bashrc") },                                  /* txt: .bashrc */
	{ MENUFILE,                     XK_c,      spawn,          SHCMD("st -e vim ~/Stack/Command_line/commands.md") },           /* txt: personal notes and comments about Linux */
	{ MENUFILE,                     XK_d,      spawn,          SHCMD("st -e vim ~/suckless/dwm/config.h") },                    /* txt: dwm 'config* file */
	{ MENUFILE,                     XK_i,      spawn,          SHCMD("st -e vim ~/.config/i3/config") },                        /* txt: i3 config file */
	{ MENUFILE|ShiftMask,           XK_r,      spawn,          SHCMD("st -e vim ~/README.md") },                                /* txt: my github dotfiles README file */
	{ MENUFILE,                     XK_r,      spawn,          SHCMD("st -e vim ~/.config/ranger/rc.conf") },                   /* txt: ranger config file */
	{ MENUFILE,                     XK_s,      spawn,          SHCMD("st -e vim ~/suckless/st/config.h") },                     /* txt: st 'config' file */
	{ MENUFILE,                     XK_v,      spawn,          SHCMD("st -e vim ~/.config/vifm/vifmrc") },                      /* txt: vifm 'config' file */
	{ MENUFILE,                     XK_x,      spawn,          SHCMD("st -e vim ~/.xinitrc") },                                 /* txt: .xinitrc */

                                                                                                                                /****   Right super key to open applications   ****/
    { MENUKEY,                      XK_f,      spawn,          SHCMD("firefox") },                                              /* Application: Firefox */
	{ MENUKEY,                      XK_g,      spawn,          SHCMD("gimp") },                                                 /* Application: gimp */
	{ MENUKEY,                      XK_k,      spawn,          SHCMD("keepass") },                                              /* Application: keepass */
	{ MENUKEY,                      XK_m,      spawn,          SHCMD("mousepad") },                                             /* Application: mousepad */
	{ MENUKEY,                      XK_t,      spawn,          SHCMD("thunar") },                                               /* Application: thunar */
	{ MENUKEY,                      XK_u,      spawn,          SHCMD("~/.config/dmenuunicode.sh") },                            /* Application: Insert emojis */
	{ MENUKEY,                      XK_v,      spawn,          SHCMD("st -e vifm") },                                           /* Application: vifm */
	{ MENUKEY,                      XK_w,      spawn,          SHCMD("~/.config/dmenuwallpaper.sh") },                          /* Application: Change wallpaper by dmenu */

                                                                                                                                /****   Left super as modkey  ****/    
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },                                              /**/
	{ MODKEY,                       XK_b,      togglebar,      {0} },                                                           /**/
	{ MODKEY,                       XK_Return, spawn,	       SHCMD("st") },                                                   /**/

	{ MODKEY|ShiftMask,		        XK_s,	   spawn,	       SHCMD("transset-df -a --dec .1") },                              /**/
	{ MODKEY|ShiftMask,		        XK_d,	   spawn,	       SHCMD("transset-df -a --inc .1") },                              /**/
	{ MODKEY|ShiftMask,		        XK_f,	   spawn,	       SHCMD("transset-df -a .75") },                                   /**/
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },                                                    /**/
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },                                                    /* InPlaceRotate: */
	{ MODKEY|ShiftMask,             XK_j,      inplacerotate,  {.i = +1} },                                                     /* InPlaceRotate: */
	{ MODKEY|ShiftMask,             XK_k,      inplacerotate,  {.i = -1} },                                                     /* InPlaceRotate: */
	{ MODKEY|ShiftMask,             XK_h,      inplacerotate,  {.i = +2} },                                                     /* InPlaceRotate: */
	{ MODKEY|ShiftMask,             XK_l,      inplacerotate,  {.i = -2} },                                                     /* InPlaceRotate: */
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },                                                    /* nmastery, add master */
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },                                                    /* nmaster, remove master */
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.02} },                                                  /* */
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.02} },                                                  /* */
	{ MODKEY,                       XK_space,  zoom,           {0} },                                                           /* */
	{ MODKEY,                       XK_Tab,    view,           {0} },                                                           /* Switch to previous tag */
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },                                                           /**/
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },                                            /* Layout: title */
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[1]} },                                            /* Layout: */
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[2]} },                                            /* Layout: monocle */
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },                                            /* Layout: grid */
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[4]} },                                            /* Layout: centeredmaster */
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },                                            /* Layout: centeredfloatingmaster */
	{ MODKEY,                       XK_p,      setlayout,      {.v = &layouts[6]} },                                            /* Layout: bottomstack */
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[7]} },                                            /* Layout: column */
	{ MODKEY,                       XK_a,      setlayout,      {0} },                                                           /* Cycle layout: backward */
	{ MODKEY|ControlMask,		    XK_comma,  cyclelayout,    {.i = -1 } },                                                    /* Cycle layout: forward */
	{ MODKEY|ControlMask,           XK_period, cyclelayout,    {.i = +1 } },                                                    /**/
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },                                                           /**/
	{ MODKEY,                       XK_s,      togglesticky,   {0} },                                                           /**/
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },                                                   /**/
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },                                                   /**/
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },                                                    /**/
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },                                                    /**/
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },                                                    /**/
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },                                                    /**/
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },                                                           /* Exiting dwm */
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} },                                                           /* Exiting dwm, and restart inplacee */
	{ MODKEY,                       XK_equal,  incrgaps,       {.i = +2 } },                                                    /* Vanity gaps: increase gaps */
    { MODKEY,                       XK_minus,  incrgaps,       {.i = -2 } },                                                    /* Vanity gaps: decrease gaps */
	{ MODKEY,                       XK_0,      togglegaps,     {0} },                                                           /* Vanity gaps: toggle gaps on/of */

                                                                        /*Tagkeys*/
	TAGKEYS(                        XK_1,                      0)       /*1*/
	TAGKEYS(                        XK_2,                      1)       /*2*/
	TAGKEYS(                        XK_3,                      2)       /*3*/
	TAGKEYS(                        XK_4,                      3)       /*4*/
	TAGKEYS(                        XK_5,                      4)       /*5*/
	TAGKEYS(                        XK_6,                      5)       /*6*/
	TAGKEYS(                        XK_7,                      6)       /*7*/
	TAGKEYS(                        XK_8,                      7)       /*8*/
	TAGKEYS(                        XK_9,                      8)       /*9*/
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument                comments */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },                  /**/
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },   /**/
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },                  /**/
/*	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },  */  /*Ik weet eigenlijk niet de functionaliteit hiervan, weggehaald omdat ik termcmd niet gebruik*/
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },                  /**/
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },                  /**/
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },                  /**/
	{ ClkTagBar,            0,              Button1,        view,           {0} },                  /**/
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },                  /**/
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },                  /**/
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },                  /**/
};
