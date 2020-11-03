# tmux-nvr
A [tmux](https://tmux.github.io) plugin for using session-specific
[Neovim](https://neovim.io) instances with
[neovim-remote](https://github.com/mhinz/neovim-remote)

---

neovim-remote allows you to control nvim processes from the shell using `nvr`.
You might then want `nvr` to control nvim processes in your current tmux session,
rather than another one. This requires setting a unique `NVIM_LISTEN_ADDRESS` for
each of your sessions.

**tmux-nvr** automates the creation of session-specific values for
`NVIM_LISTEN_ADDRESS` so that `nvr` will always refer to an nvim process in your
current session.

tmux-nvr also provides an executable `nvr-tmux`, which automates switching to
the nvim process controlled by `nvr`.

## Requirements

- tmux
    * `nvr-tmux` requires tmux 3.2+
- Neovim
- neovim-remote

## Installation Using TPM

Install tmux-nvr using the [tmux plugin manager](https://github.com/tmux-plugins/tpm).
Add the following line to your `tmux.conf`.

    set -g @plugin 'carlocab/tmux-nvr'

Press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugin.

Next, add this snippet to your `zshrc` or `bashrc`.

```bash
if [ -n "$TMUX" ]; then
    eval "$(tmux show-environment -s NVIM_LISTEN_ADDRESS)"
fi
```

If you use [OhMyZsh](https://ohmyz.sh), instead of using the snippet above, you
can use the packaged zsh plugin. First, symlink the tmux-nvr directory into
`$ZSH_CUSTOM` using

    ln -s ~/.tmux/plugins/tmux-nvr ~ZSH_CUSTOM/plugins

Your tmux plugins may be installed in a different location. One can
typically verify this location using `echo $TMUX_PLUGIN_MANAGER_PATH`.

Finally, add `tmux-nvr` to the `plugins` array in your `zshrc`.

    plugins=($plugins tmux-nvr)

The plugin will also add `nvr-tmux` to your `PATH`.

## Manual Installation

Clone this repository using

    git clone https://github.com/carlocab/tmux-nvr ~/path/to/tmux-nvr

Add the following line to your `tmux.conf`.

    run-shell ~/path/to/tmux-nvr/nvr.tmux

Then, follow the instructions for your `*rc` files in the previous
section.

## Usage

It should just work, unless you have existing `session-created` tmux hooks.

If this applies, you need to specify an unused index in the `session-created`
array using the `@tmux-nvr-hook-index` option. For example,

    set -g @tmux-nvr-hook-index 42

## nvr-tmux

`nvr-tmux` is an executable found in the `bin` directory. It automates
switching to `nvim` whenever there is an existing instance of `nvim` connected
to `NVIM_LISTEN_ADDRESS`.

It passes all its arguments to `nvr`, so it can be used in exactly the same way.
For example, to edit a file in an existing instance of `nvim` using `nvr`, you
would run

    nvr file.txt

This opens `file.txt` in `nvim`, but leaves you in the shell you called `nvr`
from. To immediately switch the current pane to `nvim` as it opens the file, run

    nvr-tmux file.txt

`nvr-tmux` can serve as a drop-in replacement for `nvr`, even if you are not
running tmux.

To use `nvr-tmux`, either add the `bin` directory to your `PATH`, or symlink
`bin/nvr-tmux` to a directory in your `PATH`. This is done automatically by the
packaged zsh plugin.

**nvr-tmux requires tmux 3.2 or above.**

## Miscellaneous

For bug reports or questions, please file an issue [here](https://github.com/carlocab/tmux-nvr/issues).

tmux-nvr may behave inappropriately if you script the creation of several tmux
sessions at a time. If this causes problems, please file an issue using the
link above.

### Wishlist
Here are improvements I hope to be able to work on:
1. Window-specific nvim instances
2. `nvr-tmux` backwards-compatibility
3. Simpler installation procedure
4. Vim-compatibility

Pull requests are welcome.

## Related Projects

https://github.com/daplay/tmux_nvr
