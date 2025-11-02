#!/usr/bin/zsh

# CHARES_SHOTGUN (zsh)
unset __resource __filename
typeset __resource="CHARES_SHOTGUN"
typeset __filename="chares-shotgun.zsh"

typeset __output_folder="${SCREENSHOTS_FOLDER:-$HOME_DIR/Screenshots}"
typeset __output_filename="screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"

shotgun "$__output_folder/$__output_filename"

unset __output_folder __output_filename
