#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

tmux set-hook -ag session-created "run-shell $SCRIPTS_DIR/nvim-listen.sh"
