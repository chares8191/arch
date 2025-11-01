#!/bin/zsh

# ZSH_XINITRC (zsh)
# Loaded by: XINITRC

# System Logging :: Logs ZSH_XINITRC Start
system_logger_entry "ZSH_XINITRC:START" "zsh-xinitrc.zsh"

# System Variables :: 40B0 Left Monitor Serial
export XINITRC_40B0_LEFT_SERIAL="VKMT4735"
# System Variables :: 40B0 Right Monitor Serial
export XINITRC_40B0_RIGHT_SERIAL="VKMT5210"

# X Startup Variables :: Xrandr Startup State
export XINITRC_XRANDR_STATE="$(xrandr --verbose)"

# X Startup Variables :: Xrandr Connected Displays
export XINITRC_XRANDR_DISPLAYS="$(printf '%s\n' "$XINITRC_XRANDR_STATE" | xrandr-utils display_names --connected)"

# X Startup Variables :: Xrandr Startup Serials
export XINITRC_XRANDR_SERIALS="$(printf '%s\n' "$XINITRC_XRANDR_STATE" | xrandr-utils display_serial_map --values)"

# X Startup Variables :: 40B0 Dock State
export XINITRC_40B0_DOCK_STATE="$(boltctl list | grep -A 13 'ThinkPad Thunderbolt 4 Dock' | grep 'status:' | awk '{print $3}' | head -n 1)"

export XINITRC_40B0_DOCK_CONNECTED="$([ "$XINITRC_40B0_DOCK_STATE" = authorized ] && printf '1' || printf '0')"
export XINITRC_40B0_LEFT_CONNECTED="$(printf '%s\n' "$XINITRC_XRANDR_SERIALS" | grep -qi -- "$XINITRC_40B0_LEFT_SERIAL" && printf '1' || printf '0')"
export XINITRC_40B0_RIGHT_CONNECTED="$(printf '%s\n' "$XINITRC_XRANDR_SERIALS" | grep -qi -- "$XINITRC_40B0_RIGHT_SERIAL" && printf '1' || printf '0')"

# Xrandr Output
xrandr --output eDP-1 --auto --primary
# Xft DPI override before main Xresources merge
printf 'Xft.dpi: 192\n' | xrdb -merge -
# X Server Startup :: Merges  Xresources
xrdb -merge "$XRESOURCES_FILE"

dunst &  # TODO: What is this?
xremap "$CHARES_CONFIG/xremap/config.yml" &  # TODO: Should this be in a different file?
picom -b &  # TODO: What is this?
slstatus &  # TODO: What is this?
sh "$CHARES_HOME/.fehbg" & # TODO: Why is this executed here?

# System Logging :: Logs Window Manager Handoff Point
system_logger_entry "ZSH_XINITRC:START_DWM" "zsh-xinitrc.zsh"
# System Startup :: Clears dmenu Cache
rm -f "$CHARES_HOME/.cache/dmenu_run"
# System Logging :: Sets Interactive Log Context
system_logger_set_context "INTERACTIVE_SHELL" "zsh-xinitrc.zsh"
# System Startup :: Starts Window Manager
while true; do
	dwm 2> "$CHARES_HOME/.dwm.log"
done

# System Logging :: Logs ZSH_XINITRC Finish
system_logger_entry "ZSH_XINITRC:FINISH" "zsh-xinitrc.zsh"
