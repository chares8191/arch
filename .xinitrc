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
XRANDR_TOOLS_DIR="$HOME_BIN_DIRECTORY/xrandr-tools"
export XRANDR_TOOLS_DIR
# System Path :: Xrandr Tools
export PATH="$XRANDR_TOOLS_DIR:$PATH"

# TODO: Confirm that the xrandr tools are actally available here first.

# export XINIT_XRANDR_OUTPUT="$(xrandr --verbose)"
# export XINIT_SERIAL_MAP="$(xr_display_serial_map "$XINIT_XRANDR_OUTPUT")" # TODO: Is this xr_display_serial_map function actually available?
# export XINIT_CONNECTED_DISPLAYS="$(xr_display_state_map "$XINIT_XRANDR_OUTPUT" | awk -F= '$2 == "connected" {print $1}' | tr '\n' ' ' | sed 's/ $//')"
# export XINIT_40B0_STATUS="$(boltctl list | grep -A 10 'ThinkPad Thunderbolt 4 Dock' | grep 'status:' | awk '{print $3}' | head -n 1)"

# System Files :: ThinkPad Screen Xresources File
XRESOURCES_THINKPAD_FILE="$HOME/.Xresources.thinkpad"
export XRESOURCES_THINKPAD_FILE
# System Files :: Common Xresources File
XRESOURCES_COMMON_FILE="$HOME/.Xresources.common"
export XRESOURCES_COMMON_FILE

# TODO: Adjust this logic to specifically check for XINIT_40B0_STATUS "connected" and specific monitor serials, else fallback to eDP-1.
# if [ "$XINIT_CONNECTED_DISPLAYS" = "eDP-1" ] || [ "$XINIT_40B0_STATUS" = "disconnected" ]; then

# Xrandr Output :: ThinkPad Screen
xrandr --output eDP-1 --auto
# X Server Startup :: Merges Laptop Screen Xresources
xrdb -merge "$XRESOURCES_THINKPAD_FILE"
# X Server Startup :: Merges Common Xresources
xrdb -merge "$XRESOURCES_COMMON_FILE"

dunst &  # TODO: What is this?
xremap "$HOME/.config/xremap/config.yml" &  # TODO: Should this be in a different file?
picom -b &  # TODO: What is this?
slstatus &  # TODO: What is this?
sh "$HOME/.fehbg" & # TODO: Why is this executed here?

# System Logging :: Logs Window Manager Handoff Point
system_logger_entry "XINITRC:START_DWM" ".xinitrc"
# System Startup :: Clears dmenu Cache
rm -f "$HOME/.cache/dmenu_run"
# System Logging :: Sets Interactive Log Context
system_logger_set_context "INTERACTIVE_SHELL" ".xinitrc"
# System Startup :: Starts Window Manager
while true; do
	dwm 2> "$HOME/.dwm.log"
done
# System Logging :: Logs XINITRC Finish
system_logger_entry "XINITRC:FINISH" ".xinitrc"
