#!/bin/bash

set -o errexit \
    -o noclobber \
    -o nounset \
    -o pipefail

readonly SCRIPT_NAME="${0##*/}"
readonly SCRIPT_DIR=$(cd "${0%/*}" && pwd)

readonly __asni_reset__=$(printf '\033[0m')
readonly __asni_fg_red__=$(printf '\033[31m')
readonly __asni_fg_green__=$(printf '\033[32m')
readonly __asni_fg_yellow__=$(printf '\033[33m')

success() {
    echo "$__asni_fg_green__""$*""$__asni_reset__"
}

warn() {
    echo "$__asni_fg_yellow__""$*""$__asni_reset__" >&2
}

error() {
    echo "$__asni_fg_red__""$*""$__asni_reset__" >&2
}
