# ZSHRC

# System Logging :: Logs ZSHRC Start
system_logger_entry "ZSHRC:START" ".zshrc"
# System Files :: ZSH Bindkeys File
export ZSH_BINDKEYS_FILE="$HOME/zsh-bindkeys.zsh"
# Interactive Shell Startup :: Loads ZSH Bindkeys File
if [[ -f "$ZSH_BINDKEYS_FILE" ]]; then
	. "$ZSH_BINDKEYS_FILE"
fi
# System Files :: ZSH Aliases File
export ZSH_ALIASES_FILE="$HOME/zsh-aliases.zsh"
# Interactive Shell Startup :: Loads ZSH Aliases File
if [[ -f "$ZSH_ALIASES_FILE" ]]; then
	. "$ZSH_ALIASES_FILE"
fi
# System Files :: User ENV File
export USER_ENV_FILE="$HOME/.env"
# Interactive Shell Startup :: Loads User ENV File
eval "export $(cat $USER_ENV_FILE)"  # TODO: Is this necessary?
# Terminal Configuration :: Ghostty Shell Integration
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
	autoload -Uz -- "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
	ghostty-integration
	unfunction ghostty-integration
fi
# System Logging :: Logs ZSHRC Finish
system_logger_entry "ZSHRC:FINISH" ".zshrc"
