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
