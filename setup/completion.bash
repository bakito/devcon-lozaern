#!/usr/bin/env bash
# Shell completion for devbox, including task names for `devbox run <TAB>`.
#
# Loaded automatically by `devbox shell` (see init_hook in devbox.json).
#
# Manual usage (bash or zsh):
#   source setup/completion.bash
# Or add it permanently to your ~/.bashrc / ~/.zshrc:
#   source /path/to/devcon-lozaern/setup/completion.bash

command -v devbox >/dev/null 2>&1 || return 0
# Skip shells without programmable completion (e.g. non-interactive or minimal bash builds)
type complete >/dev/null 2>&1 || return 0

if [[ -n "${ZSH_VERSION:-}" ]]; then
    # shellcheck disable=SC1090
    source <(devbox completion zsh)
    compdef _devbox devbox
else
    # shellcheck disable=SC1090
    source <(devbox completion bash)
fi

# Completion for the `dbr` / `dbrun` aliases (devbox run): complete devbox task names
_dbr_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local tasks
    tasks="$(devbox __complete run "${cur}" 2>/dev/null | grep -v '^:')"
    # shellcheck disable=SC2207
    COMPREPLY=($(compgen -W "${tasks}" -- "${cur}"))
}

if [[ -n "${ZSH_VERSION:-}" ]]; then
    autoload -U +X bashcompinit && bashcompinit
fi
complete -F _dbr_complete dbr dbrun
