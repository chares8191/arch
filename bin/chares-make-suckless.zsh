#!/usr/bin/zsh

# CHARES_MAKE_SUCKLESS (zsh)
unset __resource __filename
typeset __resource="CHARES_MAKE_SUCKLESS"
typeset __filename="chares-make-suckless.zsh"

typeset __source_dir="${SUCKLESS_DIR:-/home/chares/.suckless}"
typeset __target_dir="${HOME_SRC:-/home/chares/src}"

suckless_reconfig() {
    __prog="${1:-}"

	if [[ -z "$__prog" ]]; then return 1; fi
	
	__prog_src_dir="$__source_dir/$__prog"
	__prog_tgt_dir="$__target_dir/$__prog"
    __prog_src_config="$__prog_src_dir/config.h"
    __prog_tgt_config="$__prog_tgt_dir/config.h"
    
    if [[ -f "$__prog_src_config" && -d "$__prog_tgt_dir" ]]; then
        if [[ -f "$__prog_tgt_config" && "$(stat -c '%U' "$__prog_tgt_config")" = "root" ]]; then
            sudo cp -f "$__prog_src_config" "$__prog_tgt_config"
            echo "$__resource: Copied $__prog_src_config to $__prog_tgt_config."
        else
            cp -f "$__prog_src_config" "$__prog_tgt_config"
            echo "$__resource: Copied $__prog_src_config to $__prog_tgt_config."
        fi
		(
			cd "$__prog_tgt_dir" || {
				echo "$__resource: Failed to cd to $__prog_tgt_dir.";
				return;
			}
			sudo make clean
			sudo make install
			echo "$__resource: Built and installed $__prog."
		)
    else
        echo "$__resource: Skipping $__prog: source file or target dir missing."
    fi

	unset __prog __prog_src_dir __prog_tgt_dir __prog_src_config __prog_tgt_config
}

suckless_reconfig "st"
suckless_reconfig "surf"
suckless_reconfig "slock"
suckless_reconfig "slstatus"
suckless_reconfig "dmenu"
suckless_reconfig "dwm"

unset __source_dir __target_dir
