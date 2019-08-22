#!/bin/bash

set -Ceu -o pipefail

readonly IFS=$'\n'

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

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
                    echo "WARNING: '$dist/$item' already exists. Skip to link" \
                        "'$src/$item'" >&2
                    status="1"
                fi
            else
                if [[ -e "$dist" ]] && [[ ! -d "$dist" ]]; then
                    echo "WARNING: '$dist', which is not a directory exists." \
                        "Skip to link files under '$src'" >&2
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

symlink "$DIR_ABS/home" "$HOME"
