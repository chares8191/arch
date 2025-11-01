#!/bin/zsh

# CHARES_FEHBG (zsh)
emulate -L zsh
typeset resource_name="CHARES_FEHBG"

setopt pipefail

typeset wallpaper_dir
if [[ -n "$1" && -d "$1" ]]; then
	wallpaper_dir="$1"
else
	wallpaper_dir="${WALLPAPERS_DIR:-$HOME_DIR/.wallpapers}"
fi

# Wallpaper Files :: Populates Candidates Array
typeset -a wallpaper_files=("$wallpaper_dir"/*(.N))
if (( ${#wallpaper_files} == 0 )); then
	print -u2 -- "$resource_name: no wallpapers found in $wallpaper_dir"
	exit 1
fi

# Wallpaper Files :: Selects Random Wallpaper
typeset selected_wallpaper="${wallpaper_files[$((RANDOM % ${#wallpaper_files} + 1))]}"

feh --no-fehbg --bg-fill "$selected_wallpaper"

