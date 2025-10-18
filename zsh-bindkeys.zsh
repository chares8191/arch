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

forward-subword-deactivate() {
	local WORDCHARS="${WORDCHARS//[._\/-]/}"
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle .forward-word
}
zle -N forward-subword-deactivate

forward-subword-mark() {
	local WORDCHARS="${WORDCHARS//[._\/-]/}"
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle .forward-word
}
zle -N forward-subword-mark

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

backward-subword-deactivate() {
	local WORDCHARS="${WORDCHARS//[._\/-]/}"
	[[ $REGION_ACTIVE -ne 0 ]] && zle deactivate-region
	zle .backward-word
}
zle -N backward-subword-deactivate

backward-subword-mark() {
	local WORDCHARS="${WORDCHARS//[._\/-]/}"
	if [[ $REGION_ACTIVE -eq 0 ]]; then
		zle set-mark-command
	fi
	zle .backward-word
}
zle -N backward-subword-mark

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

# backward-delete-char() {
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle .backward-char
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle delete-region
# }
# zle -N backward-delete-char

# backward-delete-subword() {
# 	local WORDCHARS="${WORDCHARS//[._\/-]/}"
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle .backward-word
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle delete-region
# }
# zle -N backward-delete-subword

# backward-delete-word() {
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle backward-word
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle delete-region
# }
# zle -N backward-delete-word

# backward-delete-line() {
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle beginning-of-line
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle delete-region
# }
# zle -N backward-delete-line

# backward-cut-char() {
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle .backward-char
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle copy-region-as-kill
# 	zle delete-region
# }
# zle -N backward-cut-char

# backward-cut-subword() {
# 	local WORDCHARS="${WORDCHARS//[._\/-]/}"
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle .backward-word
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle copy-region-as-kill
# 	zle delete-region
# }
# zle -N backward-cut-subword

# backward-cut-word() {
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle backward-word
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle copy-region-as-kill
# 	zle delete-region
# }
# zle -N backward-cut-word

# backward-cut-line() {
# 	local initial_cursor=$CURSOR
# 	zle set-mark-command
# 	zle beginning-of-line
# 	if (( CURSOR == initial_cursor )); then
# 		zle deactivate-region
# 		return
# 	fi
# 	zle copy-region-as-kill
# 	zle delete-region
# }
# zle -N backward-cut-line

# [RightArrow]
bindkey '^[[C' forward-char-deactivate
# [Shift] + [RightArrow]
bindkey '^[[1;2C' forward-char-mark
# [Alt | Option] + [RightArrow]
bindkey '^[[1;3C' forward-subword-deactivate
# [Alt | Option] + [Shift] + [RightArrow]
bindkey '^[[1;4C' forward-subword-mark
# [Ctrl] + [RightArrow]
bindkey '^[[1;5C' forward-word-deactivate
# [Ctrl] + [Shift] + [RightArrow]
bindkey '^[[1;6C' forward-word-mark
# [Super] + [RightArrow]
bindkey '^[[1;9C' forward-line-deactivate
# [Super] + [Shift] + [RightArrow]
bindkey '^[[1;10C' forward-line-mark

# [LeftArrow]
bindkey '^[[D' backward-char-deactivate
# [Shift] + [LeftArrow]
bindkey '^[[1;2D' backward-char-mark
# [Alt | Option] + [LeftArrow]
bindkey '^[[1;3D' backward-subword-deactivate
# [Alt | Option] + [Shift] + [LeftArrow]
bindkey '^[[1;4D' backward-subword-mark
# [Ctrl] + [LeftArrow]
bindkey '^[[1;5D' backward-word-deactivate
# [Ctrl] + [Shift] + [LeftArrow]
bindkey '^[[1;6D' backward-word-mark
# [Super] + [LeftArrow]
bindkey '^[[1;9D' backward-line-deactivate
# [Super] + [Shift] + [LeftArrow]
bindkey '^[[1;10D' backward-line-mark

# [Delete]
# bindkey '^[[3~' backward-delete-char
# [Shift] + [Delete]
# bindkey '^[[3;2~' backward-cut-char
# [Alt | Option] + [Delete]
# bindkey '^[[3;3~' backward-delete-subword
# [Alt | Option] + [Shift] + [Delete]
# bindkey '^[[3;4~' backward-cut-subword
# [Ctrl] + [Delete]
# bindkey '^[[3;5~' backward-delete-word
# [Ctrl] + [Shift] + [Delete]
# bindkey '^[[3;6~' backward-cut-word
# [Super] + [Delete]
# bindkey '^[[3;9~' backward-delete-line
# [Super] + [Shift] + [Delete]
# bindkey '^[[3;10~' backward-cut-line

# System Logging :: Logs ZSH_BINDKEYS Finish
system_logger_entry "ZSH_BINDKEYS:FINISH" "zsh-bindkeys.zsh"
