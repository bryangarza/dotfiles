/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-lime-medium-r-*-*-*-110-*-*-*-*-iso8859-*";
#define NUMCOLORS 9 
static const char colors[NUMCOLORS][ColLast][9] = {
    // border foreground background
    { "#000000", "#777777", "#111111" }, // 0 = normal \x01
    //{ "#777777", "#ED0884", "#111111" }, // 1 = selected \x02 --- neon pink
    //{ "#777777", "#B7CE42", "#111111" }, // 1 = selected \x02
    { "#777777", "#AACCBB", "#111111" }, // 1 = selected \x02
    { "#212121", "#FFFFFF", "#111111" }, // 8 = white \x04
    { "#212121", "#D23D3D", "#000000" }, // 2 = red \x03
    { "#212121", "#BDE077", "#000000" }, // 3 = green \x05
    { "#212121", "#FFE863", "#000000" }, // 4 = yellow \x05
    { "#212121", "#AACCBB", "#000000" }, // 5 = blue \x06
    { "#212121", "#42717B", "#000000" }, // 6 = cyan \x07
    { "#212121", "#FF00CC", "#000000" }, // 7 = magenta \x08
};
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 15;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "dwm", "term", "etc", "web" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
//	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
	{ NULL,       NULL,       "term",     1 << 1,       False,       -1 },
	{ "Chromium", NULL,       NULL,       1 << 3,       False,       -1 },
	{ "Dwb",      NULL,       NULL,       1 << 3,       False,       -1 },
	{ "Tabbed",   NULL,       NULL,       1 << 3,       False,       -1 },
	{ "Gimp",     NULL,       NULL,       1 << 2,       False,       -1 },
	{ "Minitube", NULL,       NULL,       1 << 2,       False,       -1 },
	{ "Mplayer",  NULL,       NULL,       1 << 2,       False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

#include "gaplessgrid.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
    { "###",      gaplessgrid },
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char  *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[]  = { "urxvtc", "-title", "term", "-e", "tmux", "attach", "-d", "-t", "mysession", NULL };
static const char *webcmd[]  = { "dwb", NULL };

#include "push.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
    { MODKEY|ShiftMask,             XK_j,      pushdown,       {0} },
    { MODKEY|ShiftMask,             XK_k,      pushup,         {0} },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_o,      spawn,          {.v = webcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
//	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
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
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
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
