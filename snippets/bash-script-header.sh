#!/bin/bash

set -Ceu -o pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(dirname "$0")"
readonly SCRIPT_NAME_ABS="$PWD/$SCRIPT_DIR/$SCRIPT_NAME"
readonly SCRIPT_DIR_ABS="$PWD/$SCRIPT_DIR"
