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

_zsh_bindkeys_clipboard_write() {
	emulate -L zsh
	local data="$1"

    if (( $+commands[xclip] )); then
		print -rn -- "$data" | xclip -selection clipboard
	elif (( $+commands[xsel] )); then
		print -rn -- "$data" | xsel --clipboard --input
	else
		return 1
	fi
}

_zsh_bindkeys_clipboard_read() {
	emulate -L zsh

    if (( $+commands[xclip] )); then
		xclip -selection clipboard -o
	elif (( $+commands[xsel] )); then
		xsel --clipboard --output
	else
		return 1
	fi
}

clipboard-cut-region() {
	emulate -L zsh

	if (( REGION_ACTIVE == 0 )); then return 1; fi

	zle kill-region
	_zsh_bindkeys_clipboard_write "$CUTBUFFER" 2>/dev/null || true
}
zle -N clipboard-cut-region

clipboard-copy-region() {
	emulate -L zsh

	if (( REGION_ACTIVE == 0 )); then return 1; fi

	zle copy-region-as-kill
	_zsh_bindkeys_clipboard_write "$CUTBUFFER" 2>/dev/null || true
}
zle -N clipboard-copy-region

clipboard-yank() {
	emulate -L zsh

	local clipboard
	if clipboard=$(_zsh_bindkeys_clipboard_read 2>/dev/null); then CUTBUFFER=$clipboard; fi

	zle yank
}
zle -N clipboard-yank

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

# [Ctrl] + [w]
bindkey '^W' clipboard-cut-region
# [Alt | Option] + [w]
bindkey '^[w' clipboard-copy-region
# [Ctrl] + [y]
bindkey '^Y' clipboard-yank

# System Logging :: Logs ZSH_BINDKEYS Finish
system_logger_entry "ZSH_BINDKEYS:FINISH" "zsh-bindkeys.zsh"
