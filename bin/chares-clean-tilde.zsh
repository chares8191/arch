#!/usr/bin/zsh

# CHARES_CLEAN_TILDE (zsh)
unset __resource __filename
typeset __resource="CHARES_CLEAN_TILDE"
typeset __filename="chares-clean-tilde.zsh"

setopt pipefail

typeset __cli_arg="${1:-}"
typeset __start_dir

if [[ -n "$__cli_arg" ]]; then
    if [[ -d "$__cli_arg" ]]; then
        __start_dir="$__cli_arg"
    else
        print -u2 -- "$__resource: Provided path '$__cli_arg' is not a directory."
        exit 1
    fi
else
    __start_dir="$PWD"
fi

typeset __absolute_start_dir
if ! __absolute_start_dir="$(cd "$__start_dir" && pwd)"; then
    print -u2 -- "$__resource: Failed to resolve start directory."
    exit 1
fi

if ! git -C "$__absolute_start_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    print -u2 -- "$__resource: '$__absolute_start_dir' is not inside a git repository."
    exit 1
fi

typeset -a __directories
while IFS= read -r __dir; do
    [[ -n "$__dir" ]] && __directories+=("$__dir")
done < <(
    git -C "$__absolute_start_dir" ls-files --recurse-submodules -z \
        --format="$__absolute_start_dir/%(path)" \
        | xargs -0 -n1 dirname \
        | sort -u
)

if (( ${#__directories} == 0 )); then
    print -- "$__resource: No tracked directories found."
    exit 0
fi

typeset __removed_any=0
for __dir in "${__directories[@]}"; do
    typeset -a __tilde_files=("$__dir"/*\~(N))
    if (( ${#__tilde_files} == 0 )); then
        continue
    fi

    rm -- "${__tilde_files[@]}"
    print -- "$__resource: Removed ${#__tilde_files} file(s) from $__dir."
    __removed_any=1

    unset __tilde_files
done

if (( ! __removed_any )); then
    print -- "$__resource: No backup files detected."
fi

unset __cli_arg __start_dir __absolute_start_dir __directories __dir __removed_any
