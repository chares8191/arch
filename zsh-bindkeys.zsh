#!/bin/zsh

# ZSH_BINDKEYS
# Loaded by ZSHRC

# System Logging :: Logs ZSH_BINDKEYS Start
system_logger_entry "ZSH_BINDKEYS:START" "zsh-bindkeys.zsh"

forward-char-deactivate() {
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle forward-char
}
zle -N forward-char-deactivate

forward-char-mark() {
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle forward-char
}
zle -N forward-char-mark

forward-word-deactivate() {
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle forward-word
}
zle -N forward-word-deactivate

forward-word-mark() {
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle forward-word
}
zle -N forward-word-mark

forward-line-deactivate() {
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle end-of-line
}
zle -N forward-line-deactivate

forward-line-mark() {
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle end-of-line
}
zle -N forward-line-mark

backward-char-deactivate() {
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle backward-char
}
zle -N backward-char-deactivate

backward-char-mark() {
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle backward-char
}
zle -N backward-char-mark

backward-word-deactivate() {
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle backward-word
}
zle -N backward-word-deactivate

backward-word-mark() {
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle backward-word
}
zle -N backward-word-mark

backward-line-deactivate() {
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle beginning-of-line
}
zle -N backward-line-deactivate

backward-line-mark() {
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle beginning-of-line
}
zle -N backward-line-mark

bindkey '^[[C' forward-char-deactivate
bindkey '^[[1;2C' forward-char-mark
bindkey '^[[1;3C' forward-word-deactivate
bindkey '^[[1;4C' forward-word-mark
bindkey '^[[1;9C' forward-line-deactivate
bindkey '^[[1;10C' forward-line-mark

bindkey '^[[D' backward-char-deactivate
bindkey '^[[1;2D' backward-char-mark
bindkey '^[[1;3D' backward-word-deactivate
bindkey '^[[1;4D' backward-word-mark
bindkey '^[[1;9D' backward-line-deactivate
bindkey '^[[1;10D' backward-line-mark


# System Logging :: Logs ZSH_BINDKEYS Finish
system_logger_entry "ZSH_BINDKEYS:FINISH" "zsh-bindkeys.zsh"
