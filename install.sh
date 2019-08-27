#!/bin/bash

set -Ceu -o pipefail

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

readonly FISHER_PATH="$XDG_CONFIG_HOME/fish/functions/fisher.fish"

readonly FZF_BIN="/usr/local/opt/fzf"
readonly FZF_INIT_SCRIPT="$FZF_BIN/install"

readonly RESET="$(printf '\033[m')"
readonly GREEN="$(printf '\033[32m')"
readonly YELLOW="$(printf '\033[33m')"

function success() {
    echo $GREEN"$@"$RESET
}

function warn() {
    echo $YELLOW"$@"$RESET >&2
}

((status = 0))

# Install Homebrew/Cask formulae and Mac App Store apps based on Brewfile
brew analytics off &&
    brew update &&
    brew bundle --path="$DIR_ABS/Brewfile" &&
    brew cleanup &&
    brew doctor

# Install Fisher (https://github.com/jorgebucaran/fisher)
if curl "https://git.io/fisher" --create-dirs -sLo "$FISHER_PATH"; then
    success "Successfully installed Fisher at '$FISHER_PATH'"
else
    warn "Failed to install Fisher."
    ((status += 1))
fi

# Initialize fzf (https://github.com/junegunn/fzf)
if [[ -x "$FZF_INIT_SCRIPT" ]]; then
    "$FZF_INIT_SCRIPT" --xdg --key-bindings --completion --no-update-rc \
        --no-bash --no-zsh >/dev/null
else
    warn "Executable '$FZF_INIT_SCRIPT' not exists. Examine" \
        "'https://github.com/junegunn/fzf' or re-install fzf and follow the" \
        "instructions to finish installing fzf key bindings and completions."
    ((status += 2))
fi

exit $status
