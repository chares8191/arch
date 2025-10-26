#!/bin/sh

# XINITRC

# System Logging :: Sets Xinit Logger Context
if [ "${SYSTEM_LOGGER_CONTEXT:-}" = "STARTUP_LOGIN_SHELL" ]; then
	export SYSTEM_LOGGER_CONTEXT="STARTUP_XINIT_SHELL"
else
	export SYSTEM_LOGGER_CONTEXT="OTHER_XINIT_SHELL"
fi
# System Logging :: Loads System Logger Script
if [ -f "$SYSTEM_SHELL_LOGGER" ]; then . "$SYSTEM_SHELL_LOGGER"; fi
# System Logging :: Logs XINITRC Start
system_logger_entry "XINITRC:START" ".xinitrc"
# System Files :: Xrandr Tools
export XRANDR_TOOLS_DIR="$CHARES_BIN/xrandr-tools"
# System Path :: Xrandr Tools
if [[ -d "$XRANDR_TOOLS_DIR" && ":$PATH:" != *":$XRANDR_TOOLS_DIR:"* ]]; then
	export PATH="$PATH:$XRANDR_TOOLS_DIR"
fi
# System Files :: ThinkPad Screen Xresources File
export XRESOURCES_THINKPAD_FILE="$CHARES_HOME/.Xresources.thinkpad"
# System Files :: Common Xresources File
export XRESOURCES_COMMON_FILE="$CHARES_HOME/.Xresources.common"
# Startup Variables :: ThinkPad Screen Serial
export XINITRC_THINKPAD_SERIAL="MNE001EA1-4"
# Startup Variables :: 40B0 Left Monitor Serial
export XINITRC_40B0_LEFT_SERIAL="VKMT4735"
# Startup Variables :: 40B0 Right Monitor Serial
export XINITRC_40B0_RIGHT_SERIAL="VKMT5210"
# Startup Variables :: Xrandr State
export XINITRC_XRANDR_STATE="$(xrandr --verbose)"
# Startup Variables :: Connected Displays List
export XINITRC_CONNECTED_DISPLAY_NAMES="$(xr_connected_display_names)"
# Startup Variables :: 40B0 Dock State
export XINITRC_40B0_DOCK_STATE="$(boltctl list | grep -A 13 'ThinkPad Thunderbolt 4 Dock' | grep 'status:' | awk '{print $3}' | head -n 1)"

# Xrandr Output :: ThinkPad Screen
xrandr --output eDP-1 --auto
# X Server Startup :: Merges Laptop Screen Xresources
xrdb -merge "$XRESOURCES_THINKPAD_FILE"
# X Server Startup :: Merges Common Xresources
xrdb -merge "$XRESOURCES_COMMON_FILE"

dunst &  # TODO: What is this?
xremap "$CHARES_CONFIG/xremap/config.yml" &  # TODO: Should this be in a different file?
picom -b &  # TODO: What is this?
slstatus &  # TODO: What is this?
sh "$CHARES_HOME/.fehbg" & # TODO: Why is this executed here?

# System Logging :: Logs Window Manager Handoff Point
system_logger_entry "XINITRC:START_DWM" ".xinitrc"
# System Startup :: Clears dmenu Cache
rm -f "$CHARES_HOME/.cache/dmenu_run"
# System Logging :: Sets Interactive Log Context
system_logger_set_context "INTERACTIVE_SHELL" ".xinitrc"
# System Startup :: Starts Window Manager
while true; do
	dwm 2> "$CHARES_HOME/.dwm.log"
done
# System Logging :: Logs XINITRC Finish
system_logger_entry "XINITRC:FINISH" ".xinitrc"
