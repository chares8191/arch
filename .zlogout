emulate -L zsh

# ZLOGOUT (zsh)
unset __resource __filename
typeset __resource="ZLOGOUT"
typeset __filename=".zlogout"

# System Logging :: Sets Shutdown Context
system_logger_set_context "SHUTDOWN_LOGIN_SHELL" "$__filename"
# System Logging :: Logs ZLOGOUT Start
system_logger_entry "$__resource:START" "$__filename"

# No contents.

# System Logging :: Logs ZLOGOUT Finish
system_logger_entry "$__resource:FINISH" "$__filename"
