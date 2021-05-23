# tmux-nvr.plugin.zsh
# Sets NVIM_LISTEN_ADDRESS and adds `nvr-tmux` to path

# Standardised $0 handling.
# See https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc#1-standardized-0-handling
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# If in tmux, set `NVIM_LISTEN_ADDRESS` using tmux-nvr
if [ -n "$TMUX" ]; then
    eval "$(command tmux show-environment -s NVIM_LISTEN_ADDRESS)"
else
    # -m 700 sets permissions so that only you have access to this directory
    mkdir -p -m 700 /tmp/nvr
    export NVIM_LISTEN_ADDRESS=/tmp/nvr/nvimsocket
fi

# Bail out early if `tmux` is not executable
(( $+commands[tmux] )) || return 0

# Strip all but the digits from `tmux -V`
tmux_version_digits="${$(command tmux -V 2> /dev/null)//[^0-9]/}"
tmux_compat_digits="32"

# Add `nvr-tmux` to path if tmux is new enough
if ! (( $+commands[nvr-tmux] )) && [[ "tmux_version_digits" -ge "$tmux_compat_digits" ]]; then
    path+="${0:h}/bin"
    export PATH
fi

# Don't leave temporary variables lying around
unset tmux_version_digits tmux_compat_digits
