/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
  "Space Mono:size=14:antialias=true:autohint=true",
  "monospace:size=14:antialias=true:autohint=true"  /* Fallback */
};

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

static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { gruvbox_bright_green, gruvbox_dark_2 },
	[SchemeSel] = { gruvbox_faded_blue, gruvbox_light_3 },
	[SchemeOut] = { "#000000", "#00ffff" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
