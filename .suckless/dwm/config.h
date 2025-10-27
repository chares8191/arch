/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = {
  "Space Mono:size=14:antialias=true:autohint=true",
  "monospace:size=14"  /* Fallback */
};
static const char dmenufont[]       = "Space Mono:size=14:antialias=true:autohint=true";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";

static const char gruvbox_dark_0_hard[] = "#1D2021";
static const char gruvbox_dark_0_medm[] = "#282828";
static const char gruvbox_dark_0_soft[] = "#32302F";
static const char gruvbox_dark_1[] = "#3C3836";
static const char gruvbox_dark_2[] = "#504945";
static const char gruvbox_dark_3[] = "#665C54";
static const char gruvbox_dark_4[] = "#7C6F64";
static const char gruvbox_gray[] = "#928374";
static const char gruvbox_light_0_hard[] = "#F9F5D7";
static const char gruvbox_light_0_medm[] = "#FBF1C7";
static const char gruvbox_light_0_soft[] = "#F2E5BC";
static const char gruvbox_light_1[] = "#EBDBB2";
static const char gruvbox_light_2[] = "#D5C4A1";
static const char gruvbox_light_3[] = "#BDAE93";
static const char gruvbox_light_4[] = "#A89984";
static const char gruvbox_bright_red[] = "#FB4934";
static const char gruvbox_bright_green[] = "#B8BB26";
static const char gruvbox_bright_yellow[] = "#FABD2F";
static const char gruvbox_bright_blue[] = "#83A598";
static const char gruvbox_bright_purple[] = "#D3869B";
static const char gruvbox_bright_aqua[] = "#8EC07C";
static const char gruvbox_bright_orange[] = "#FE8019";
static const char gruvbox_neutral_red[] = "#CC241D";
static const char gruvbox_neutral_green[] = "#98971A";
static const char gruvbox_neutral_yellow[] = "#D79921";
static const char gruvbox_neutral_blue[] = "#458588";
static const char gruvbox_neutral_purple[] = "#B16286";
static const char gruvbox_neutral_aqua[] = "#689D6A";
static const char gruvbox_neutral_orange[] = "#D65D0E";
static const char gruvbox_faded_red[] = "#9D0006";
static const char gruvbox_faded_green[] = "#79740E";
static const char gruvbox_faded_yellow[] = "#B57614";
static const char gruvbox_faded_blue[] = "#076678";
static const char gruvbox_faded_purple[] = "#8F3F71";
static const char gruvbox_faded_aqua[] = "#427B58";
static const char gruvbox_faded_orange[] = "#AF3A03";

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { gruvbox_light_1, gruvbox_dark_1, gruvbox_light_4 },
	[SchemeSel]  = { gruvbox_dark_1, gruvbox_light_1, gruvbox_dark_4 },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "Brave", NULL, "wants to open", 0, 1, -1 },
	{ "GtkFileChooserDialog", NULL, NULL, 0, 1, -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", gruvbox_dark_2, "-nf", gruvbox_bright_green, "-sb", gruvbox_light_3, "-sf", gruvbox_faded_blue, NULL };
static const char *termcmd[]  = { "ghostty", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_b,      spawn,          SHCMD("~/.fehbg") },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_F9,     spawn,          SHCMD("xrandr-utils single_display_output eDP-1") },
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
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
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
