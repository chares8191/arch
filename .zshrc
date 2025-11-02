emulate -L zsh

# ZSHRC (zsh)
unset __resource __filename
typeset __resource="ZSHRC"
typeset __filename=".zshrc"

# System Logging :: Logs ZSHRC Start
system_logger_entry "$__resource:START" "$__filename"

# Interactive Shell Startup :: Sources ZSH_BINDKEYS_FILE File
if [[ -f "$ZSH_BINDKEYS_FILE" ]]; then source "$ZSH_BINDKEYS_FILE"; fi
# Interactive Shell Startup :: Sources ZSH_ALIASES_FILE File
if [[ -f "$ZSH_ALIASES_FILE" ]]; then source "$ZSH_ALIASES_FILE"; fi
# Interactive Shell Startup :: Sources USER_ENV_FILE File
if [[ -f "$USER_ENV_FILE" ]]; then source "$USER_ENV_FILE"; fi

# Terminal Configuration :: Ghostty Shell Integration
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
	autoload -Uz -- "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
	ghostty-integration
	unfunction ghostty-integration
fi

# System Logging :: Logs ZSHRC Finish
system_logger_entry "$__resource:FINISH" "$__filename"
