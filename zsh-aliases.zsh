emulate -L zsh

# ZSH_ALIASES (zsh)
unset __resource __filename
typeset __resource="ZSH_ALIASES"
typeset __filename="zsh-aliases.zsh"

# System Logging :: Logs ZSH_ALIASES Start
system_logger_entry "$__resource:START" "$__filename"

# Interactive Shell Alias :: Regular Sudo
alias rsudo="sudo"
# Interactive Shell Alias :: Sudo + Env
alias sudo="sudo -E"
# Interactive Shell Alias :: Default ls pattern
alias ll="ls -alF --color=auto"
# Interactive Shell Alias :: nvidia prime-run
alias nv="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia prime-run"
# Interactive Shell Alias :: pbcopy
alias pbcopy="xclip -selection clipboard"
# Interactive Shell Alias :: pbpaste
alias pbpaste="xclip -selection clipboard -o"
# Interactive Shell Alias :: grok_cli
# alias grok_cli="bun /home/chares/src/grok-cli/dist/index.js"

# System Logging :: Logs ZSH_ALIASES Finish
system_logger_entry "$__resource:FINISH" "$__filename"
