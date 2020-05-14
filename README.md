# dotfiles

Initialization suite for macOS system

## Prerequisite

- [Homebrew](https://brew.sh)

## Initialization

```bash
git clone <this repo> <anywhere you like>
cd <this repo>

# to install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
brew bundle

# to symlink dotfiles
./symlink.bash
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked on initialization without any warnings.
