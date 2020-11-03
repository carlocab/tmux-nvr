#!/usr/bin/env bash
# Creates an unused socket name in $TMPDIR/tmux-nvr
# Note that we don't want the `-g` flag for `set-environment`, since we want
# NVIM_LISTEN_ADDRESS to be set for each session.

temp="$(dirname "$(mktemp -u)")"
socketdir="${temp}/tmux-nvr"
[ -d "$socketdir" ] || mkdir -p "$socketdir"
tmux set-environment NVIM_LISTEN_ADDRESS "$(mktemp -u "${socketdir}/XXXXXX")"
