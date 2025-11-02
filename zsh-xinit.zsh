emulate -L zsh

# ZSH_XINIT (zsh)
unset __resource __filename
typeset __resource="ZSH_XINIT"
typeset __filename="zsh-xinit.zsh"

# System Logging :: Logs ZSH_XINITRC Start
system_logger_entry "$__resource:START" "$__filename"

# X Startup Variables :: Xrandr Startup State
export XINIT_XRANDR_STATE="$(xrandr --verbose)"
# X Startup Variables :: Xrandr Connected Displays
export XINIT_XRANDR_DISPLAYS="$(
	printf '%s\n' "$XINIT_XRANDR_STATE" | xrandr-utils display_names --connected
)"
# X Startup Variables :: Xrandr Startup Monitor Serials
export XINIT_XRANDR_SERIALS="$(
	printf '%s\n' "$XINIT_XRANDR_STATE" | xrandr-utils display_serial_map --values
)"

# X Startup Variables :: 40B0 Dock State
export XINIT_40B0_DOCK_STATE="$(
	boltctl list | grep -A 13 'ThinkPad Thunderbolt 4 Dock' | grep 'status:' | awk '{print $3}' | head -n 1
)"

# X Startup Variables :: 40B0 Dock Connected
export XINIT_40B0_DOCK_CONNECTED="$(
	[[ "$XINIT_40B0_DOCK_STATE" = "authorized" ]] && printf '1' || printf '0'
)"

# X Startup Variables :: 40B0 Left Monitor Serial
export XINIT_40B0_LEFT_SERIAL="VKMT4735"

# X Startup Variables :: 40B0 Right Monitor Serial
export XINIT_40B0_RIGHT_SERIAL="VKMT5210"

# X Startup Variables :: 40B0 Left Monitor Connected
export XINIT_40B0_LEFT_CONNECTED="$(
	printf '%s\n' "$XINIT_XRANDR_SERIALS" | grep -qi -- "$XINIT_40B0_LEFT_SERIAL" && printf '1' || printf '0'
)"

# X Startup Variables :: 40B0 Right Monitor Connected
export XINIT_40B0_RIGHT_CONNECTED="$(
	printf '%s\n' "$XINIT_XRANDR_SERIALS" | grep -qi -- "$XINIT_40B0_RIGHT_SERIAL" && printf '1' || printf '0'
)"

# System Logging :: Logs ZSH_XINIT Finish
system_logger_entry "$__resource:FINISH" "$__filename"
