# tommodore dotfiles

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/tommodore/dotfiles?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Automates installation and configuration of your home directory dotfiles.
Works for various Linux distributions and MacOSX.

## Installation

### Initial setup

Run this:

```sh
git clone --recursive https://github.com/tommodore/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap.sh
```

This will:
* symlinks the appropriate files in `.dotfiles` to your home directory
* loads vim Plugin Manager Vundle as a submodule
* Install or update Vundle plugins configured in `.dofiles/vim/vimrc.symlink`
* Installs homebrew - if you're on a mac

### Update Vim Plugins only

Launch `vim` and run `:PluginInstall!`

To install or update from command line: `vim +PluginInstall! +qall`

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/tommodore/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/tommodore/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

Thanks to
---------

https://github.com/holman/dotfiles

https://github.com/sindresorhus/pure

https://github.com/gmarik/Vundle.vim

and all the plugin developers
