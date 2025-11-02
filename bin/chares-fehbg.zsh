#!/usr/bin/zsh

# CHARES_FEHBG (zsh)
unset __resource __filename
typeset __resource="CHARES_FEHBG"
typeset __filename="chares-fehbg.zsh"

setopt pipefail

typeset __default_source="${WALLPAPERS_DIR:-$HOME_DIR/.wallpapers}"
typeset __cli_arg="${1:-}"

typeset __images_source
if [[ -n "$__cli_arg" && -d "$__cli_arg" ]]; then
	__images_source="$__cli_arg"
else
    __images_source="$__default_source"
fi

typeset -a __image_files=("$__images_source"/*(.N))
if (( ${#__image_files} == 0 )); then
	print -u2 -- "$__resource: No images found in $__images_source."
	exit 1
fi

typeset __selected_image="${__image_files[$((RANDOM % ${#__image_files} + 1))]}"

feh --no-fehbg --bg-fill "$__selected_image"

unset __default_source __cli_arg __images_source __image_files __selected_image

