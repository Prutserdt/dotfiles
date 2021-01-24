/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

/*
* ____  __  __ _____ _   _ _   _   ____             _                    _ _
*|  _ \|  \/  | ____| \ | | | | | |  _ \ _ __ _   _| |_ ___  ___ _ __ __| | |_
*| | | | |\/| |  _| |  \| | | | | | |_) | '__| | | | __/ __|/ _ \ '__/ _` | __|
*| |_| | |  | | |___| |\  | |_| | |  __/| |  | |_| | |_\__ \  __/ | | (_| | |_
*|____/|_|  |_|_____|_| \_|\___/  |_|   |_|   \__,_|\__|___/\___|_|  \__,_|\__|
*/

static int topbar = 1;                     /* -b  option; if 0, dmenu appears at bottom */
static int centered = 0;                   /* -c option; centers dmenu on screen */
static int min_width = 500;                /* minimum width when centered */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching */
/* -fn option overrides fonts[0]; default X11 font or font set */
//static const char *fonts[] = { "monospace:size=10" };
static const char *fonts[] = { "hack:size=10", "JoyPixels:pixelsize=10" };
//static const char *fonts[] = { "hack:size=10" };
static const char *prompt      = NULL;     /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
    [SchemeNorm] = { "#bbbbbb", "#000000" },/*?????,  background*/
	[SchemeSel] = { "#111111", "#8ec07c" }, /* second color: highlight of dmenu borders*/
//	[SchemeSel] = { "#eeeeee", "#777777" }, /* second color: highlight of dmenu borders*/
	[SchemeSelHighlight] = { "#ffc978", "#005577" },
	[SchemeNormHighlight] = { "#ffc978", "#222222" },
	[SchemeOut] = { "#111111", "#00ffff" },
/*	[SchemeOut] = { "#000000", "#00ffff" },*/
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 2;
