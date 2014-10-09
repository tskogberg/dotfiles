# My dotfiles

This is a fork of [Henrik's](https://github.com/henrik) dotfiles.

## Install

Clone this repo into `~/.dotfiles`:

    git clone git@github.com:tskogberg/dotfiles.git ~/.dotfiles

Then install the dotfiles:

    cd .dotfiles
    rake

This rake task will not replace existing files, but it will replace existing symlinks.

The dotfiles will be symlinked, e.g. `~/.zshrc` symlinked to `~/.dotfiles/zshrc`.

## Vim plugins

To update submodules you can run:

    git submodule foreach git pull

## tmux

Make it integrate with the OS X system clipboard:

    brew install reattach-to-user-namespace

## Extras

The `extras` directory contains additional configuration files that are not dotfiles:

 * `VibrantInk.itermcolors` is a colorscheme for [iTerm2](http://www.iterm2.com/) ([source](https://github.com/asanghi/vibrantinklion)).

 * On a new Mac, run `~/.dotfiles/extras/os_x_defaults.sh` in the Terminal to change some silly defaults.
