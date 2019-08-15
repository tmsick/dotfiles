# dotfiles

Initialization suite for macOS system

## Prerequisite

-   [Homebrew](https://brew.sh) (which is **NOT** automatically installed in the initialization scripts as its official installation method may change in the future)

## Initializing the environment

```bash
git clone <this repo> <anywhere you like>
cd <this repo>

# to symlink dotfiles
./symlink.sh

# to install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
./install.sh
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked in your system when initializing.
