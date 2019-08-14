#!/bin/bash

set -o errexit
set -o noclobber
set -o nounset
set -o pipefail

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

function symlink() {
    local src="$1"
    local dist="$2"

    ls -A "$src" | while read item; do
        if [[ -f "$src/$item" ]] && [[ "$item" == ".DS_Store" ]]; then
            continue
        fi

        if [[ -f "$src/$item" ]]; then
            if [[ -e "$dist/$item" ]]; then
                if [[ -L "$dist/$item" ]] && [[ "$dist/$item" -ef "$src/$item" ]]; then
                    : # already linked; do nothing
                else
                    echo "\"$dist/$item\" already exists" >&2
                fi
            else
                mkdir -p "$dist"
                ln -s "$src/$item" "$dist/$item"
            fi
        elif [[ -d "$src/$item" ]]; then
            symlink "$src/$item" "$dist/$item"
        fi
    done
}

symlink "$DIR_ABS/home" "$HOME"
