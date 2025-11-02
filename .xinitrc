#!/usr/bin/zsh

# XINITRC (zsh)
unset __resource __filename
typeset __resource="XINITRC"
typeset __filename=".xinitrc"

# System Logging :: Sets Xinit Logger Context
if [ "${SYSTEM_LOGGER_CONTEXT:-}" = "STARTUP_LOGIN_SHELL" ]; then
    system_logger_set_context "STARTUP_XINIT_SHELL" "$__filename"
else
    system_logger_set_context "OTHER_XINIT_SHELL" "$__filename"
fi
# System Logging :: Logs XINITRC Start
system_logger_entry "$__resource:START" "$__filename"

# X Startup :: Sources ZSH_XINIT_FILE File
if [[ -f "$ZSH_XINIT_FILE" ]]; then source "$ZSH_XINIT_FILE"; fi

# X Startup :: Xrandr Output
xrandr --output eDP-1 --auto --primary
# X Server Startup :: Merges DPI Setting
printf 'Xft.dpi: 192\n' | xrdb -merge -
# X Server Startup :: Merges XRESOURCES_FILE
xrdb -merge "${XRESOURCES_FILE:-$HOME_DIR/.Xresources}"

# System Logging :: Logs Window Manager Handoff Point
system_logger_entry "$__resource:START_DWM" "$__filename"
# System Logging :: Sets Interactive Log Context
system_logger_set_context "INTERACTIVE_SHELL" "$__filename"

# System Startup :: Starts Window Manager
dunst &
picom -b &
slstatus &
xremap "/home/chares/.config/xremap/config.yml" &
zsh "/home/chares/bin/chares-fehbg.zsh" &
while true; do
	rm -f "/home/chares/.cache/dmenu_run"
	dwm 2> "/home/chares/.dwm.log"
done

# System Logging :: Logs XINITRC Finish
system_logger_entry "$__resource:FINISH" "$__filename"
