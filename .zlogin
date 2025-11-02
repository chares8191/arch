emulate -L zsh

# ZLOGIN (zsh)
unset __resource __filename
typeset __resource="ZLOGIN"
typeset __filename=".zlogin"

# System Logging :: Adjusts Login Context
if [[ "${SYSTEM_LOGGER_CONTEXT:-}" != "STARTUP_LOGIN_SHELL" ]]; then
	system_logger_set_context "OTHER_LOGIN_SHELL" "$__filename"
fi
# System Logging :: Logs ZLOGIN Start
system_logger_entry "$__resource:START" "$__filename"

# System Startup :: Starts X Server
if [[ -z ${DISPLAY:-} && ${XDG_VTNR:-0} -eq 1 ]]; then
	# System Logging :: Logs X Server Handoff Point
	system_logger_entry "$__resource:STARTX" "$__filename"
	exec startx
fi

# System Logging :: Logs ZLOGIN Finish
system_logger_entry "$__resource:FINISH" "$__filename"
