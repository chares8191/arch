#!/bin/zsh

# ZSHENV (zsh)

# System Startup :: Startup Timestamp
if [[ -z "${SYSTEM_STARTUP_TIMESTAMP:-}" ]]; then
	export SYSTEM_STARTUP_TIMESTAMP="$(date '+%Y-%m-%dT%H:%M:%S%z')"
fi

# System Files :: Exports SYSTEM_SHELL_LOGGER File
export SYSTEM_SHELL_LOGGER="/home/chares/bin/system-logger.zsh"
# System Logging :: Initializes Context for Startup Shells
if [[ -z "${SYSTEM_LOGGER_CONTEXT:-}" ]]; then
	export SYSTEM_LOGGER_CONTEXT="STARTUP_LOGIN_SHELL"
fi
# System Startup :: Loads System Logger Script
if [[ -f "$SYSTEM_SHELL_LOGGER" ]]; then . "$SYSTEM_SHELL_LOGGER"; fi

# System Logging :: Logs ZSHENV Start
system_logger_entry "ZSHENV:START" ".zshenv"

# System Directories :: Exports HOME_DIR Directory
export HOME_DIR="${HOME_DIR:-/home/chares}"

# System Bin Locations :: Exports USR_BIN Bin Location
export USR_BIN="${USR_BIN:-/usr/bin}"
# System Bin Locations :: Exports HOME_BIN Bin Location
export HOME_BIN="${HOME_BIN:-$HOME_DIR/bin}"
# System Bin Locations :: Exports LOCAL_BIN Bin Location
export LOCAL_BIN="${LOCAL_BIN:-$HOME_DIR/.local/bin}"
# System Bin Locations :: Exports BUN_BIN Bin Location
export BUN_BIN="${BUN_BIN:-$HOME_DIR/.bun/bin}"

# System Path :: Prepends USR_BIN Location
if [[ ":$PATH:" != *":$USR_BIN:"* ]]; then
	PATH="$USR_BIN${PATH:+:$PATH}"
fi
# System Path :: Appends HOME_BIN Location
if [[ -d "$HOME_BIN" && ":$PATH:" != *":$HOME_BIN:"* ]]; then
	PATH="$PATH:$HOME_BIN"
fi
# System Path :: Appends LOCAL_BIN Location
if [[ -d "$LOCAL_BIN" && ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
	PATH="$LOCAL_BIN:$PATH"
fi
# System Path :: Appends BUN_BIN Location
if [[ -d "$BUN_BIN" && ":$PATH:" != *":$BUN_BIN:"* ]]; then
	PATH="$PATH:$BUN_BIN"
fi
# System Path :: Exports PATH
export PATH

# System Directories :: Exports CONFIG_DIR Directory
export CONFIG_DIR="${CONFIG_DIR:-$HOME_DIR/.config}"
# System Directories :: Exports EMACS_DIR Directory
export EMACS_DIR="${EMACS_DIR:-$HOME_DIR/.emacs.d}"
# System Directories :: Exports GRAPHICS_DIR Directory
export GRAPHICS_DIR="${GRAPHICS_DIR:-$HOME_DIR/.graphics}"
# System Directories :: Exports WALLPAPERS_DIR Directory
export WALLPAPERS_DIR="${WALLPAPERS_DIR:-$HOME_DIR/.wallpapers}"

# System Files :: Exports USR_ENV_FILE File
export USER_ENV_FILE="${USER_ENV_FILE:-$HOME_DIR/.env}"
# System Files :: Exports ZSHENV_FILE File
export ZSHENV_FILE="${ZSHENV_FILE:-$HOME_DIR/.zshenv}"
# System Files :: Exports ZPROFILE_FILE File
export ZPROFILE_FILE="${ZPROFILE_FILE:-$HOME_DIR/.zprofile}"
# System Files :: Exports ZSHRC_FILE File
export ZSHRC_FILE="${ZSHRC_FILE:-$HOME_DIR/.zshrc}"
# System Files :: Exports ZLOGIN_FILE File
export ZLOGIN_FILE="${ZLOGIN_FILE:-$HOME_DIR/.zlogin}"
# System Files :: Exports ZLOGOUT_FILE File
export ZLOGOUT_FILE="${ZLOGOUT_FILE:-$HOME_DIR/.zlogout}"
# System Files :: Exports XINITRC_FILE File
export XINITRC_FILE="${XINITRC_FILE:-$HOME_DIR/.xinitrc}"
# System Files :: Exports XRESOURCES_FILE File
export XRESOURCES_FILE="${XRESOURCES_FILE:-$HOME_DIR/.Xresources}"
# System Files :: Exports ZSH_BINDKEYS_FILE File
export ZSH_BINDKEYS_FILE="${ZSH_BINDKEYS_FILE:-$HOME_DIR/zsh-bindkeys.zsh}"
# System Files :: Exports ZSH_ALIASES_FILE File
export ZSH_ALIASES_FILE="${ZSH_ALIASES_FILE:-$HOME_DIR/zsh-aliases.zsh}"
# System Files :: Exports ZSH_XINITRC_FILE File
export ZSH_XINITRC_FILE="${ZSH_XINITRC_FILE:-$HOME_DIR/zsh-xinitrc.zsh}"

# Shell Configuration :: Editor
export EDITOR="emacs"

# System Logging :: Logs ZSHENV Finish
system_logger_entry "ZSHENV:FINISH" ".zshenv"
