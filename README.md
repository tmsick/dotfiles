# dotfiles

Initialization suite for macOS system

## Prerequisites

- Command Line Tools
- Git
- Homebrew
    - Python 3
    - Pipenv

## Installation

```
git clone <this repo> <anywhere you like>
cd <this repo>
pipenv install
pipenv run init.py
```

**DO NOT** place junk files under `home` directory as all files in it are regarded as valid config files and are symlinked in your system on installation.
