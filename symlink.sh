#!/bin/bash

set -Ceu -o pipefail

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

readonly RESET="$(printf '\033[m')"
readonly GREEN="$(printf '\033[32m')"
readonly YELLOW="$(printf '\033[33m')"
readonly RED="$(printf '\033[31m')"

function success() {
    echo $GREEN"$@"$RESET
}

function warn() {
    echo $YELLOW"$@"$RESET >&2
}

function error() {
    echo $RED"$@"$RESET >&2
}

function print_usage() {
    cat <<EOS
Usage
  - To link files:     ./$FILE
  - To unlink files:   ./$FILE --rm
  - To see this usage: ./$FILE --help
EOS
}

function dig() {
    local type="$1"
    local src="$2"
    local dest="$3"

    if [[ "$type" != "link" ]] && [[ "$type" != "unlink" ]]; then
        error "An invalid type '$type' was given to an internal function 'dig'. Check out code around line $LINENO."
        exit 100
    fi

    ls -A "$src" | while read item; do
        # Skip this turn if the source file is .DS_Store
        if [[ -f "$src/$item" ]] && [[ "$item" == ".DS_Store" ]]; then
            continue
        fi

        # If the pivot item is a regular file
        if [[ -f "$src/$item" ]]; then

            # If the destination is already occupied
            if [[ -e "$dest/$item" ]]; then

                # If the file is already linked
                if [[ -L "$dest/$item" ]] && [[ "$dest/$item" -ef "$src/$item" ]]; then
                    if [[ "$type" == "unlink" ]]; then
                        unlink "$dest/$item"
                    fi

                # If something unknown occupies the destination
                else
                    warn "'$dest/$item' already exists. Skip ${type}ing '$src/$item'"
                fi

            # If the destination is vacant and linkage is required
            elif [[ "$type" == "link" ]]; then
                if mkdir -p "$dest" >/dev/null 2>&1; then
                    ln -s "$src/$item" "$dest/$item"
                else
                    warn "Failed to make directory '$dest'. Skip linking files under '$src'"
                    return
                fi
            fi

        # If the pivot item is a directory
        elif [[ -d "$src/$item" ]]; then
            dig "$type" "$src/$item" "$dest/$item"

        # If the pivot item is something other than a regular file nor a directory
        else
            warn "'$src/$item', which is not a regular file, exists under '$src'"
        fi
    done
}

function main() {
    case $# in
    0)
        dig link "$DIR_ABS/home" "$HOME"
        return
        ;;
    1)
        local arg="$1"
        case "$arg" in
        help | -help | --help | -h)
            print_usage
            return
            ;;
        --rm)
            dig unlink "$DIR_ABS/home" "$HOME"
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
