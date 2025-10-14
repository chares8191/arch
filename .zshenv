#!/bin/zsh

# ZSHENV

# System Startup :: Startup Timestamp
if [[ -z "${SYSTEM_STARTUP_TIMESTAMP:-}" ]]; then
	export SYSTEM_STARTUP_TIMESTAMP="$(date '+%Y-%m-%dT%H:%M:%S%z')"
fi
# System Files :: Home /bin Directory
export HOME_BIN_DIRECTORY="$HOME/bin"
# System Files :: System Logger Script
export SYSTEM_SHELL_LOGGER="$HOME_BIN_DIRECTORY/system-logger.zsh"
# System Logging :: Initializes Context for Startup Shells
if [[ -z "${SYSTEM_LOGGER_CONTEXT:-}" ]]; then
	export SYSTEM_LOGGER_CONTEXT="STARTUP_LOGIN_SHELL"
fi
# System Startup :: Loads System Logger Script
if [[ -f "$SYSTEM_SHELL_LOGGER" ]]; then . "$SYSTEM_SHELL_LOGGER"; fi
# System Logging :: Logs ZSHENV Start
system_logger_entry "ZSHENV:START" ".zshenv"
# System Files :: /usr/bin Directory
export USR_BIN_DIRECTORY="/usr/bin"
# System Path :: Prepends /usr/bin Directory
if [[ ":$PATH:" != *":/usr/bin:"* ]]; then
	PATH="/usr/bin${PATH:+:$PATH}"
fi
# System Path :: Appends Home /bin Directory
if [[ -d "$HOME_BIN_DIRECTORY" && ":$PATH:" != *":$HOME_BIN_DIRECTORY:"* ]]; then
	PATH="$PATH:$HOME_BIN_DIRECTORY"
fi
# System Files :: Bun /bin Directory
export BUN_BIN_DIRECTORY="$HOME/.bun/bin"
# System Path :: Appends Bun /bin Directory
if [[ -d "$BUN_BIN_DIRECTORY" && ":$PATH:" != *":$BUN_BIN_DIRECTORY:"* ]]; then
	PATH="$PATH:$BUN_BIN_DIRECTORY"
fi
# System Path :: Exports Path
export PATH
# System Files :: ZSHENV File
export ZSHENV_FILE="$HOME/.zshenv"
# System Files :: ZPROFILE File
export ZPROFILE_FILE="$HOME/.zprofile"
# System Files :: ZSHRC File
export ZSHRC_FILE="$HOME/.zshrc"
# System Files :: ZLOGIN File
export ZLOGIN_FILE="$HOME/.zlogin"
# System Files :: ZLOGOUT File
export ZLOGOUT_FILE="$HOME/.zlogout"
# System Files :: XINITRC File
export XINITRC_FILE="$HOME/.xinitrc"
# Shell Configuration :: Editor
export EDITOR="emacs"
# System Logging :: Logs ZSHENV Finish
system_logger_entry "ZSHENV:FINISH" ".zshenv"
