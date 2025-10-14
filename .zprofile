#!/bin/zsh

# ZPROFILE

# System Logging :: Sets Login Context
if [[ "${SYSTEM_LOGGER_CONTEXT:-}" != "STARTUP_LOGIN_SHELL" ]]; then
	system_logger_set_context "OTHER_LOGIN_SHELL" ".zprofile"
fi
# System Logging :: Logs ZPROFILE Start
system_logger_entry "ZPROFILE:START" ".zprofile"
# System Logging :: Logs ZPROFILE Finish
system_logger_entry "ZPROFILE:FINISH" ".zprofile"
