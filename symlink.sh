#!/bin/bash

set -Ceu -o pipefail

# ============================== PATH VARIABLES ================================
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(dirname "$0")"
readonly SCRIPT_NAME_ABS="$PWD/$SCRIPT_DIR/$SCRIPT_NAME"
readonly SCRIPT_DIR_ABS="$PWD/$SCRIPT_DIR"

# ============================= PRINT FUNCTIONS ================================
readonly __COLOR_SWITCH_GREEN__="$(printf '\033[32m')"
readonly __COLOR_SWITCH_YELLOW__="$(printf '\033[33m')"
readonly __COLOR_SWITCH_RED__="$(printf '\033[31m')"
readonly __COLOR_SWITCH_RESET__="$(printf '\033[m')"

function success() {
    echo $__COLOR_SWITCH_GREEN__"$@"$__COLOR_SWITCH_RESET__
}
function warn() {
    echo $__COLOR_SWITCH_YELLOW__"$@"$__COLOR_SWITCH_RESET__ >&2
}
function error() {
    echo $__COLOR_SWITCH_RED__"$@"$__COLOR_SWITCH_RESET__ >&2
}

# ============================== END OF HEADER =================================

function print_usage() {
    cat <<EOS
Usage
    - To link files:     ./$SCRIPT_NAME
    - To unlink files:   ./$SCRIPT_NAME --rm
    - To see this usage: ./$SCRIPT_NAME --help
EOS
}

function traverse() {
    local src="$1"
    local dest="$2"
    local callback=$3

    for item in $(IFS=$'\n' ls -A "$src"); do
        if [[ -f "$src/$item" ]]; then
            $callback "$src/$item" "$dest/$item"
        elif [[ -d "$src/$item" ]]; then
            traverse "$src/$item" "$dest/$item" $callback
        fi
    done
}

function __link__() {
    local src="$1"
    local dest="$2"

    if [[ "$(basename "$src")" == ".DS_Store" ]]; then
        return
    fi

    if [[ "$src" -ef "$dest" ]]; then
        return
    fi

    if [[ -e "$dest" ]]; then
        warn "'$dest' already exists. Skip linking '$src'."
        return
    fi

    local dest_dir="$(dirname "$dest")"
    if mkdir -p "$dest_dir"; then
        ln -s "$src" "$dest"
    else
        warn "Failed to make dir '$dest_dir'. Skip linking '$src'."
    fi
}

function __unlink__() {
    local src="$1"
    local dest="$2"

    if [[ "$src" -ef "$dest" ]]; then
        rm "$dest"
    fi
}

function main() {
    case $# in
    0)
        traverse "$SCRIPT_DIR_ABS/home" "$HOME" __link__
        return
        ;;
    1)
        case "$1" in
        help | -help | --help | -h)
            print_usage
            return
            ;;
        --rm)
            traverse "$SCRIPT_DIR_ABS/home" "$HOME" __unlink__
            return
            ;;
        *)
            print_usage >&2
            return 1
            ;;
        esac
        ;;
    *)
        print_usage >&2
        return 1
        ;;
    esac
}

main "$@"
