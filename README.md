# dotfiles

Initialization suite for macOS system

## Prerequisites

- Command Line Tools
- Homebrew
    - Git
    - Python 3
    - Pipenv

## Installation

```
git clone <this repo> <anywhere you like>
cd <repo>
pipenv install
pipenv shell
./init.py
```

## Help

```
./init.py help
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked in your system on installation.
