# My dotfiles

Your dotfiles are how you personalize your system. These are mine.

I was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. I realized I could split a lot of things
up into the main areas I used (Ruby, git, system libraries, and so on), so I
structured the project accordingly.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read @holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## 🏷️ Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `scripts/bootstrap`.

## 🎁 What's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/RemiBardon/dotfiles/fork), remove what you don't
use, and build on what you do use.

## 🗂️ Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `scripts/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `scripts/bootstrap`.
- **topic/\*.symlink.destination**: For every file ending in `*.symlink`, `scripts/bootstrap` checks
  for a custom symlink destination file with the same name plus `.destination`. In such file, you can write
  a file path and it will be used to create the symlink. You can also use variables in it, they will be expanded.
- **topic/symlinks.destination**: When most files from a topic should be symlinked to a place that's not `$HOME/.<file>`,
  you can use a `symlinks.destination` file to point to a destination directory.
  This file works like `*.symlink.destination` files, but should point to a directory.

## ⬇️ Install

Run this:

```sh
git clone https://github.com/RemiBardon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
scripts/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## 🪳 Bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as _my_ dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/RemiBardon/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## 🙏🏻 Thanks

A decent amount of the code in these dotfiles stem or are
inspired from [@holman's dotfiles](https://github.com/holman/dotfiles).

> [@holman](https://github.com/holman)'s original thanks:
> I forked [Ryan Bates](http://github.com/ryanb)' excellent
> [dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
> weight of my changes and tweaks inspired me to finally roll my own. But Ryan's
> dotfiles were an easy way to get into bash customization, and then to jump ship
> to zsh a bit later. A decent amount of the code in these dotfiles stem or are
> inspired from Ryan's original project.
