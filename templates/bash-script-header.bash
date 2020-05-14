#!/bin/bash

set -o errexit \
    -o noclobber \
    -o nounset \
    -o pipefail

readonly SCRIPT_NAME="${0##*/}"
readonly SCRIPT_DIR=$(cd "${0%/*}" && pwd)

readonly __ansi_reset__=$(printf '\033[0m')
readonly __ansi_fg_red__=$(printf '\033[31m')
readonly __ansi_fg_green__=$(printf '\033[32m')
readonly __ansi_fg_yellow__=$(printf '\033[33m')

success() {
    echo "$__ansi_fg_green__""$*""$__ansi_reset__"
}

warn() {
    echo "$__ansi_fg_yellow__""$*""$__ansi_reset__" >&2
}

error() {
    echo "$__ansi_fg_red__""$*""$__ansi_reset__" >&2
}
