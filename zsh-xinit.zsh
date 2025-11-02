emulate -L zsh

# ZSH_XINIT (zsh)
unset __resource __filename
typeset __resource="ZSH_XINIT"
typeset __filename="zsh-xinit.zsh"

setopt pipefail

# System Logging :: Logs ZSH_XINITRC Start
system_logger_entry "$__resource:START" "$__filename"

# X Startup Variables :: Xrandr Startup State
export XINIT_XRANDR_STATE="$(xrandr --verbose)"
# X Startup Variables :: Xrandr Connected Display Names
export XINIT_XRANDR_DISPLAY_NAMES="$(echo "$XINIT_XRANDR_STATE" | xrandr-utils display_names --connected)"
# X Startup Variables :: Xrandr Startup Monitor Serials
export XINIT_XRANDR_MONITOR_SERIALS="$(echo "$XINIT_XRANDR_STATE" | xrandr-utils display_serial_map --values)"

# X Startup Variables :: 40B0 Dock State
export XINIT_40B0_DOCK_STATE="$(boltctl list | grep -A 13 'ThinkPad Thunderbolt 4 Dock' | grep 'status:' | awk '{print $3}' | head -n 1)"

# X Startup Variables :: 40B0 Left Monitor Serial
export XINIT_40B0_LEFT_SERIAL="VKMT4735"

# X Startup Variables :: 40B0 Right Monitor Serial
export XINIT_40B0_RIGHT_SERIAL="VKMT5210"

# X Startup Variables :: 40B0 Left Monitor Connected
export XINIT_40B0_LEFT_DISPLAY="$(printf '%s\n' "$XINIT_XRANDR_STATE" | xrandr-utils monitor_serial_get_displays --connected "$XINIT_40B0_LEFT_SERIAL" | head -n 1)"

# X Startup Variables :: 40B0 Right Monitor Connected
export XINIT_40B0_RIGHT_DISPLAY="$(printf '%s\n' "$XINIT_XRANDR_STATE" | xrandr-utils monitor_serial_get_displays --connected "$XINIT_40B0_RIGHT_SERIAL" | head -n 1)"

# X Startup Variables :: 40B0 Dual Display Available
if [[ -n $XINIT_40B0_DOCK_STATE && $XINIT_40B0_DOCK_STATE == "authorized" && -n $XINIT_40B0_LEFT_DISPLAY && -n $XINIT_40B0_RIGHT_DISPLAY ]]; then
    XINIT_40B0_DUAL_DISPLAY_AVAILABLE="true"
else
    XINIT_40B0_DUAL_DISPLAY_AVAILABLE="false"
fi
export XINIT_40B0_DUAL_DISPLAY_AVAILABLE

# System Logging :: Logs ZSH_XINIT Finish
system_logger_entry "$__resource:FINISH" "$__filename"
