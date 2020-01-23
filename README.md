# dotfiles

Initialization suite for macOS system

## Prerequisite

- [Homebrew](https://brew.sh)

## Initializing the environment

```bash
git clone <this repo> <anywhere you like>
cd <this repo>

# to install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
brew bundle

# to symlink dotfiles
./symlink.sh
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked on initialization without any warnings.

## Manually installed apps

| Name           | Installer URL                                           | Reason                              |
| :------------- | :------------------------------------------------------ | :---------------------------------- |
| VirtualBox 6.0 | https://www.virtualbox.org/wiki/Download_Old_Builds_6_0 | This version is required by Vagrant |
