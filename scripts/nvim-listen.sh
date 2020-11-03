#!/usr/bin/env bash

temp="$(dirname "$(mktemp -u)")"
socketdir="${temp}/tmux-nvr"
[ -d "$socketdir" ] || mkdir -p "$socketdir"
tmux set-environment NVIM_LISTEN_ADDRESS "$(mktemp -u "${socketdir}/XXXXXX")"
