# dotfiles

Initialization suite for macOS

## Prerequisite

- [Homebrew](https://brew.sh)

## Initialization

```bash
$ git clone <this repo> <anywhere you like>
$ cd <this repo>

# to install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
$ brew bundle --all --no-lock

# to symlink dotfiles
#
# if you are initializing a vanilla macOS, it is recommended that you install
# brew dependencies before symlinking files, as many configs depend on apps
# installed via brew
$ ./bin/symlink.py

# to generate Brewfile based on the current system state
$ brew update && brew bundle dump --all --file=- | ./bin/format_brewfile.py > Brewfile
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked on initialization without any warning.

## Vim

`.vimrc` in this repo uses [vim-plug](https://github.com/junegunn/vim-plug) as the plugin manager. Install it to use vim comfortably.

## Vim on tmux

Set up appropriate TERMINFO in `~/.terminfo/` referring:

- https://apple.stackexchange.com/questions/266333/how-to-show-italic-in-vim-in-iterm2
- https://gist.github.com/iawaknahc/9a10c5610e14bc13c6a29547c5f5b987
- https://github.com/vim/vim/issues/993

The below code might work well but use it with caution.

```bash
$ mkdir -p ~/.terminfo &&
  cd ~/.terminfo &&
  curl -O https://invisible-island.net/datafiles/current/terminfo.src.gz &&
  gzip -d terminfo.src.gz &&
  tic -o . terminfo.src &&
  rm terminfo.src*
```

## iStats

It is recommended to install [iStats](https://github.com/Chris911/iStats) to `/usr/local/bin`.

```bash
$ gem install iStats -n /usr/local/bin
```

## JetBrains IDE

It is recommended to symlink `~/.vimrc` to `~/.ideavimrc` when you use IdeaVim on JetBrains IDEs.

```bash
$ ln -s ~/.vimrc ~/.ideavimrc
```
