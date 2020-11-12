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

tmux-nvr also provides `nvr-tmux`, an executable which automates switching to
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
else
    export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
fi
```

The `else` statement is optional. Nevertheless, it is a good idea to include it.
`nvr` is known to produce errors [when it is used without this being set](https://github.com/mhinz/neovim-remote/issues/134#issuecomment-565840645). You may wish to check the permissions of `/tmp` if you
are on a multi-user system.

### Optional: Zsh Plugin Installation with OhMyZsh

If you use [OhMyZsh](https://ohmyz.sh), instead of using the snippet above, you
can use the packaged zsh plugin. First, symlink the tmux-nvr directory into
`$ZSH_CUSTOM` using

    ln -s ~/.tmux/plugins/tmux-nvr ~ZSH_CUSTOM/plugins

Your tmux plugins may be installed in a different location. One can
typically verify this location using `echo $TMUX_PLUGIN_MANAGER_PATH`.

Finally, add `tmux-nvr` to the `plugins` array in your `zshrc`.

    plugins=($plugins tmux-nvr)

The plugin will also add `nvr-tmux` to your `PATH`, if your version of tmux is
new enough.

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
array using the `@tmux-nvr-hook-index` option in `tmux.conf`. For example,

    set -g @tmux-nvr-hook-index 42

This is set to `0` by default. Thus, instead of setting `@tmux-nvr-hook-index`,
you may alternatively assign your `session-created` hooks to indices other than
`0`.

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

tmux-nvr may behave unpredictably if you script the creation of several tmux
sessions at a time. If this causes problems, please file an issue using the
link above.

### Wishlist
Here are improvements I hope to be able to work on (in no particular order):
1. Window-specific nvim instances
2. `nvr-tmux` backwards-compatibility
3. Simpler installation procedure
4. Vim-compatibility
5. tmux-nvr usage demo

Pull requests are welcome.

## Related Projects

https://github.com/daplay/tmux_nvr
