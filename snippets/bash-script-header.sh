#!/bin/bash

set -Ceu -o pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(dirname "$0")"
readonly SCRIPT_NAME_ABS="$PWD/$SCRIPT_DIR/$SCRIPT_NAME"
readonly SCRIPT_DIR_ABS="$PWD/$SCRIPT_DIR"

readonly GREEN="$(printf '\033[32m')"
readonly YELLOW="$(printf '\033[33m')"
readonly RED="$(printf '\033[31m')"
readonly RESET="$(printf '\033[m')"

function success() {
    echo $GREEN"$@"$RESET
}

function warn() {
    echo $YELLOW"$@"$RESET >&2
}

function error() {
    echo $RED"$@"$RESET >&2
}

# ============================== END OF HEADER =================================
