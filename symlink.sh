#!/bin/bash

set -Ceu -o pipefail

readonly IFS=$'\n'

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

readonly RESET="$(printf '\033[m')"
readonly GREEN="$(printf '\033[32m')"
readonly YELLOW="$(printf '\033[33m')"

function success() {
    echo $GREEN"$@"$RESET
}

function warn() {
    echo $YELLOW"$@"$RESET >&2
}

function symlink() {
    local status="0"

    local src="$1"
    local dist="$2"
    local item=""

    for item in $(ls -A "$src"); do
        if [[ -f "$src/$item" ]] && [[ "$item" == ".DS_Store" ]]; then
            continue
        fi

        if [[ -f "$src/$item" ]]; then
            if [[ -e "$dist/$item" ]]; then
                if [[ -L "$dist/$item" ]] &&
                    [[ "$dist/$item" -ef "$src/$item" ]]; then
                    : # already linked and do nothing
                else
                    warn "'$dist/$item' already exists." \
                        "Skip linking '$src/$item'"
                    status="1"
                fi
            else
                if [[ -e "$dist" ]] && [[ ! -d "$dist" ]]; then
                    warn "'$dist', which is not a directory, exists." \
                        "Skip linking files under '$src'"
                    return "1"
                fi

                mkdir -p "$dist"
                ln -s "$src/$item" "$dist/$item"
            fi
        elif [[ -d "$src/$item" ]]; then
            if ! symlink "$src/$item" "$dist/$item"; then
                status="1"
            fi
        fi
    done

    return "$status"
}

if symlink "$DIR_ABS/home" "$HOME"; then
    success "Successfully linked all the dotfiles." \
        'Now, consider running `fisher` to install Fisher packages.'
    exit "0"
else
    warn "There was a problem(s) linking some dotfiles." \
        "Consult warnings written above and solve them."
    exit "1"
fi
