#!/bin/sh

# XINITRC (sh)

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

# System Startup :: ZSH_XINITRC Handoff Point
if [ -r "$ZSH_XINITRC_FILE" ]; then
	exec zsh "$ZSH_XINITRC_FILE"
fi

# System Logging :: Logs XINITRC Finish
system_logger_entry "XINITRC:FINISH" ".xinitrc"
