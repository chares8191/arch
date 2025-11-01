#!/bin/zsh

# ZSHENV (zsh)

# System Startup :: Startup Timestamp
if [[ -z "${SYSTEM_STARTUP_TIMESTAMP:-}" ]]; then
	export SYSTEM_STARTUP_TIMESTAMP="$(date '+%Y-%m-%dT%H:%M:%S%z')"
fi

# System Files :: System Logger Script
export SYSTEM_SHELL_LOGGER="/home/chares/bin/system-logger.zsh"
# System Logging :: Initializes Context for Startup Shells
if [[ -z "${SYSTEM_LOGGER_CONTEXT:-}" ]]; then
	export SYSTEM_LOGGER_CONTEXT="STARTUP_LOGIN_SHELL"
fi
# System Startup :: Loads System Logger Script
if [[ -f "$SYSTEM_SHELL_LOGGER" ]]; then . "$SYSTEM_SHELL_LOGGER"; fi

# System Logging :: Logs ZSHENV Start
system_logger_entry "ZSHENV:START" ".zshenv"

# System Files :: /usr/bin Directory
export USR_BIN="/usr/bin"
# System Path :: Prepends /usr/bin Directory
if [[ ":$PATH:" != *":$USR_BIN:"* ]]; then
	PATH="$USR_BIN${PATH:+:$PATH}"
fi

# System Variables :: Chares Home Directory
export CHARES_HOME="/home/chares"

# System Variables :: Chares Config Directory
export CHARES_CONFIG="/home/chares/.config"

# System Variables :: Chares Bin Directory
export CHARES_BIN="/home/chares/bin"
# System Path :: Appends Chares Bin
if [[ -d "$CHARES_BIN" && ":$PATH:" != *":$CHARES_BIN:"* ]]; then
	PATH="$PATH:$CHARES_BIN"
fi

# System Variables :: Local Bin Directory
export LOCAL_BIN="$CHARES_HOME/.local/bin"
# System Path :: Prepends Local Bin Directory
if [[ -d "$LOCAL_BIN" && ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
	PATH="$LOCAL_BIN:$PATH"
fi

# System Variables :: Bun Bin Directory
export BUN_BIN="/home/chares/.bun/bin"
# System Path :: Appends Bun Bin Directory
if [[ -d "$BUN_BIN" && ":$PATH:" != *":$BUN_BIN:"* ]]; then
	PATH="$PATH:$BUN_BIN"
fi

# System Path :: Exports Mutated Path
export PATH

# System Files :: ZSHENV File
export ZSHENV_FILE="$CHARES_HOME/.zshenv"
# System Files :: ZPROFILE File
export ZPROFILE_FILE="$CHARES_HOME/.zprofile"
# System Files :: ZSHRC File
export ZSHRC_FILE="$CHARES_HOME/.zshrc"
# System Files :: ZLOGIN File
export ZLOGIN_FILE="$CHARES_HOME/.zlogin"
# System Files :: ZLOGOUT File
export ZLOGOUT_FILE="$CHARES_HOME/.zlogout"
# System Files :: XINITRC File
export XINITRC_FILE="$CHARES_HOME/.xinitrc"
# System Files :: XRESOURCES File
export XRESOURCES_FILE="$CHARES_HOME/.Xresources"
# System Files :: ZSH_BINDKEYS File
export ZSH_BINDKEYS_FILE="$CHARES_HOME/zsh-bindkeys.zsh"
# System Files :: ZSH_ALIASES File
export ZSH_ALIASES_FILE="$CHARES_HOME/zsh-aliases.zsh"
# System Files :: ZSH_XINITRC File
export ZSH_XINITRC_FILE="$CHARES_HOME/zsh-xinitrc.zsh"
# System Files :: CHARES_ENV File
export CHARES_ENV_FILE="$CHARES_HOME/.env"

# Shell Configuration :: Editor
export EDITOR="emacs"

# System Logging :: Logs ZSHENV Finish
system_logger_entry "ZSHENV:FINISH" ".zshenv"
