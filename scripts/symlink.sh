#!/bin/bash

set -o errexit \
    -o noclobber \
    -o nounset \
    -o pipefail

readonly SCRIPT_NAME="${0##*/}"
readonly SCRIPT_DIR=$(cd "${0%/*}" && pwd)

readonly __ansi_reset__=$(printf '\033[0m')
readonly __ansi_fg_yellow__=$(printf '\033[33m')

warn() {
    echo "$__ansi_fg_yellow__""$*""$__ansi_reset__" >&2
}

print_usage() {
    cat <<EOS
Usage
    - To link files:     ./$SCRIPT_NAME
    - To unlink files:   ./$SCRIPT_NAME --rm
    - To see this usage: ./$SCRIPT_NAME --help
EOS
}

traverse() {
    local src="$1"
    local dest="$2"
    local cb="$3"

    local ifs=$IFS
    IFS=$'\n'
    for item in $(IFS=$'\n' command ls -A "$src"); do
        if [[ -f "$src/$item" ]]; then
            "$cb" "$src/$item" "$dest/$item"
        elif [[ -d "$src/$item" ]]; then
            "${FUNCNAME[1]}" "$src/$item" "$dest/$item" "$cb"
        fi
    done
    IFS=$ifs
}

__link__() {
    local src="$1"
    local dest="$2"

    echo "$src" "$dest"
    return

    test "$src" -ef "$dest" && return

    if [[ -e "$dest" ]]; then
        warn "$dest already exists. skip linking $src"
        return
    fi

    local dest_dir="${dest%/*}"
    if mkdir -p "$dest_dir" 2>/dev/null; then
        ln -s "$src" "$dest"
    else
        warn "failed to make dir $dest_dir. skip linking $src"
    fi
}

__unlink__() {
    local src="$1"
    local dest="$2"

    if [[ "$src" -ef "$dest" ]]; then
        rm "$dest"
    fi
}

main() {
    local home="$SCRIPT_DIR/home"

    case $# in
    0)
        traverse "$home" "$HOME" __link__
        return
        ;;
    1)
        case $1 in
        help | -help | --help | -h)
            print_usage
            return
            ;;
        --rm)
            traverse "$home" "$HOME" __unlink__
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
