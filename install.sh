#!/bin/bash

set -Ceu -o pipefail

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

readonly RESET="$(printf '\033[m')"
readonly YELLOW="$(printf '\033[33m')"

function warn() {
    echo $YELLOW"$@"$RESET >&2
}

((status = 0))

# Install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
readonly BREWFILE_PATH="$DIR_ABS/Brewfile"
if ! (brew analytics off && brew update && brew bundle --path="$BREWFILE_PATH" && brew cleanup && brew doctor); then
    warn "Failed to bundle brew. Try manually running \`brew bundle --path='$BREWFILE_PATH'\`"
    ((status += 2 ** 0))
fi

# Install Fisher (https://github.com/jorgebucaran/fisher)
readonly FISHER_PATH="$XDG_CONFIG_HOME/fish/functions/fisher.fish"
if ! curl "https://git.io/fisher" --create-dirs -sLo "$FISHER_PATH"; then
    warn "Failed to install Fisher."
    ((status += 2 ** 1))
fi

# Initialize fzf (https://github.com/junegunn/fzf)
readonly FZF_BIN="/usr/local/opt/fzf"
readonly FZF_INIT_SCRIPT="$FZF_BIN/install"
if [[ -x "$FZF_INIT_SCRIPT" ]]; then
    if ! "$FZF_INIT_SCRIPT" --xdg --key-bindings --completion --no-update-rc --no-bash --no-zsh; then
        warn "Failed to initialize fzf. Try manually running \`$FZF_INIT_SCRIPT\`"
        ((status += 2 ** 2))
    fi
else
    warn "Executable '$FZF_INIT_SCRIPT' not exists. Examine 'https://github.com/junegunn/fzf' or re-install fzf and follow the instructions to finish installing fzf key bindings and completions."
    ((status += 2 ** 3))
fi

exit $status
