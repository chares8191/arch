#!/bin/zsh

# ZLOGIN

# System Logging :: Adjusts Login Context
if [[ "${SYSTEM_LOGGER_CONTEXT:-}" != "STARTUP_LOGIN_SHELL" ]]; then
	system_logger_set_context "OTHER_LOGIN_SHELL" ".zlogin"
fi
# System Logging :: Logs ZLOGIN Start
system_logger_entry "ZLOGIN:START" ".zlogin"
# System Startup :: Starts X Server
if [[ -z ${DISPLAY:-} && ${XDG_VTNR:-0} -eq 1 ]]; then
	# System Logging :: Logs X Server Handoff Point
	system_logger_entry "ZLOGIN:START_X" ".zlogin"
	exec startx
fi
# System Logging :: Logs ZLOGIN Finish
system_logger_entry "ZLOGIN:FINISH" ".zlogin"
