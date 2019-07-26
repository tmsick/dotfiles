# dotfiles

Initialization suite for macOS system

## Prerequisites

- [Homebrew](https://brew.sh) (which is **NOT** automatically installed in the installation script as its official installation method may change in the future)

## Initializing the environment

```
git clone <this repo> <wherever you like>
cd <this repo>
./init
```

---

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked in your system on installation.
