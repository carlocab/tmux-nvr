# tmux-nvr.plugin.zsh
# Sets NVIM_LISTEN_ADDRESS and adds `nvr-tmux` to path

# Standardised $0 handling.
# See https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc#1-standardized-0-handling
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# If in tmux, set `NVIM_LISTEN_ADDRESS` using tmux-nvr
if [ -n "$TMUX" ]; then
    eval "$(command tmux show-environment -s NVIM_LISTEN_ADDRESS)"
fi

# Check if `nvr-tmux` is in $path, otherwise add it
if (( $+commands[nvr-tmux] )); then
    return 0
else
    path+=("${0:h}/bin")
    export PATH
fi
