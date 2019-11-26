#!/bin/bash

set -Ceu -o pipefail

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
readonly BREWFILE_PATH="$DIR_ABS/Brewfile"
readonly FISHER_PATH="$XDG_CONFIG_HOME/fish/functions/fisher.fish"
readonly FZF_BIN="/usr/local/opt/fzf"
readonly FZF_INIT_SCRIPT="$FZF_BIN/install"

function warn() {
    local reset="$(printf '\033[m')"
    local yellow="$(printf '\033[33m')"

    echo $yellow"$@"$reset >&2
}

function init_brew() {
    if ! (brew analytics off && brew update && brew bundle --path="$BREWFILE_PATH" && brew cleanup && brew doctor); then
        warn "Failed to bundle brew. Try manually running \`brew bundle --path='$BREWFILE_PATH'\`"
        return 1
    fi
}

function make_fish_default_shell() {
    if ! which fish; then
        warn "Failed to set fish as the default shell. 'fish' cannot be found in \$PATH."
        return 1
    fi

    local fish="$(which fish)"
    if [[ "$SHELL" != "$fish" ]]; then
        chsh -s "$fish"
    fi
}

function install_fisher() {
    if ! curl "https://git.io/fisher" --create-dirs -sLo "$FISHER_PATH"; then
        warn "Failed to install Fisher."
        return 1
    fi
}

function init_fzf() {
    if [[ -x "$FZF_INIT_SCRIPT" ]]; then
        if ! "$FZF_INIT_SCRIPT" --xdg --key-bindings --completion --no-update-rc --no-bash --no-zsh; then
            warn "Failed to initialize fzf. Try manually running \`$FZF_INIT_SCRIPT\`"
            return 1
        fi
    else
        warn "Executable '$FZF_INIT_SCRIPT' not exists. Examine 'https://github.com/junegunn/fzf' or re-install fzf and follow the instructions to finish installing fzf key bindings and completions."
        return 1
    fi
}

function main() {
    init_brew
    make_fish_default_shell
    install_fisher
    init_fzf
}

main >/dev/null
