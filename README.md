# dotfiles

Initialization suite for macOS system

## Prerequisite

-   [Homebrew](https://brew.sh) (which is **NOT** automatically installed in the initialization scripts as its official installation method may change in the future)

## Initializing the environment

You should run `install.sh` before running `symlink.sh` since some dotfiles symlinked in the latter depend on apps installed in the former.

```bash
git clone <this repo> <anywhere you like>
cd <this repo>

# 1. to install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
./install.sh

# 2. to symlink dotfiles
./symlink.sh
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked on initialization without any warnings.

## Manually installed apps

| Name | Installer URL                           | Reason                                      |
| :--- | :-------------------------------------- | :------------------------------------------ |
| Rust | https://www.rust-lang.org/tools/install | Official installation script is recommended |
