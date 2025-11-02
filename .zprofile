emulate -L zsh

# ZPROFILE (zsh)
unset __resource __filename
typeset __resource="ZPROFILE"
typeset __filename=".zprofile"

# System Logging :: Sets Login Context
if [[ "${SYSTEM_LOGGER_CONTEXT:-}" != "STARTUP_LOGIN_SHELL" ]]; then
	system_logger_set_context "OTHER_LOGIN_SHELL" "$__filename"
fi
# System Logging :: Logs ZPROFILE Start
system_logger_entry "$__resource:START" "$__filename"

# Nothing here.

# System Logging :: Logs ZPROFILE Finish
system_logger_entry "$__resource:FINISH" "$__filename"
