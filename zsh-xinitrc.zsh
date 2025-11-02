#!/usr/bin/zsh

# ZSH_XINITRC (zsh)
# Loaded by: XINITRC
unset __resource __filename
typeset __resource="ZSH_XINITRC"
typeset __filename="zsh-xinitrc.zsh"

# System Logging :: Logs ZSH_XINITRC Start
system_logger_entry "$__resource:START" "$__filename"

# X Startup Variables :: 40B0 Left Monitor Serial
export XINITRC_40B0_LEFT_SERIAL="VKMT4735"
# X Startup Variables :: 40B0 Right Monitor Serial
export XINITRC_40B0_RIGHT_SERIAL="VKMT5210"

# X Startup Variables :: Xrandr Startup State
export XINITRC_XRANDR_STATE="$(xrandr --verbose)"
# X Startup Variables :: Xrandr Connected Displays
export XINITRC_XRANDR_DISPLAYS="$(
	printf '%s\n' "$XINITRC_XRANDR_STATE" | xrandr-utils display_names --connected
)"
# X Startup Variables :: Xrandr Startup Serials
export XINITRC_XRANDR_SERIALS="$(
	printf '%s\n' "$XINITRC_XRANDR_STATE" | xrandr-utils display_serial_map --values
)"

# X Startup Variables :: 40B0 Dock State
export XINITRC_40B0_DOCK_STATE="$(
	boltctl list | grep -A 13 'ThinkPad Thunderbolt 4 Dock' | grep 'status:' | awk '{print $3}' | head -n 1
)"
export XINITRC_40B0_DOCK_CONNECTED="$(
	[[ "$XINITRC_40B0_DOCK_STATE" = "authorized" ]] && printf '1' || printf '0'
)"
export XINITRC_40B0_LEFT_CONNECTED="$(
	printf '%s\n' "$XINITRC_XRANDR_SERIALS" | grep -qi -- "$XINITRC_40B0_LEFT_SERIAL" && printf '1' || printf '0'
)"
export XINITRC_40B0_RIGHT_CONNECTED="$(
	printf '%s\n' "$XINITRC_XRANDR_SERIALS" | grep -qi -- "$XINITRC_40B0_RIGHT_SERIAL" && printf '1' || printf '0'
)"

# Xrandr Output
xrandr --output eDP-1 --auto --primary
# Xft DPI override before main Xresources merge
printf 'Xft.dpi: 192\n' | xrdb -merge -
# X Server Startup :: Merges  Xresources
xrdb -merge "${XRESOURCES_FILE:-$HOME_DIR/.Xresources}"

dunst &
xremap "$CONFIG_DIR/xremap/config.yml" &
picom -b &
slstatus &
zsh "$HOME_BIN/chares-fehbg.zsh" &

# System Logging :: Logs Window Manager Handoff Point
system_logger_entry "$__resource:START_DWM" "$__filename"
# System Startup :: Clears dmenu Cache
rm -f "$CACHE_DIR/dmenu_run"
# System Logging :: Sets Interactive Log Context
system_logger_set_context "INTERACTIVE_SHELL" "$__filename"
# System Startup :: Starts Window Manager
while true; do
	dwm 2> "$HOME_DIR/.dwm.log"
done

# System Logging :: Logs ZSH_XINITRC Finish
system_logger_entry "$__resource:FINISH" "$__filename"
