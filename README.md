# tmux-nvr
A [tmux](https://tmux.github.io) plugin for creating session-specific
[Neovim](https://neovim.io) instances using
[neovim-remote](https://github.com/mhinz/neovim-remote)

---

neovim-remote allows you to controll nvim processes from the shell using `nvr`.
You might then want `nvr` to control nvim processes in your current tmux session,
rather than another one. This requires setting a unique `NVIM_LISTEN_ADDRESS` for
each of your sessions.

**tmux-nvr** automates the creation of session-specific values for
`NVIM_LISTEN_ADDRESS` so that `nvr` will always refer to an nvim process in your
current session.

## Requirements

- tmux
- Neovim
- neovim-remote

## Installation Using tpm

Install tmux-nvr using the [tmux plugin manager](https://github.com/tmux-plugins/tpm).
Add the following line to your `tmux.conf`.

    set -g @plugin 'carlocab/tmux-nvr'

## Manual Installation

Clone this repository using

    git clone https://github.com/carlocab/tmux-nvr ~/path/to/tmux-nvr

Add the following line to your `tmux.conf`.

    run-shell ~/path/to/tmux-nvr/nvr.tmux

## Usage

It should just work.

## Miscellaneous

For bug reports or questions, please file an issue [here](https://github.com/carlocab/tmux-nvr/issues).
