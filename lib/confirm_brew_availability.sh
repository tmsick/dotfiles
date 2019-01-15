#!/usr/bin/env bash

# =========================> start of library header <==========================
readonly SCRIPT_PATH=$(realpath "$0")
readonly SCRIPT_NAME=$(basename "$SCRIPT_PATH")
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
readonly REPO_ROOT=$(realpath "$SCRIPT_DIR/..")
readonly LIB_DIR="$REPO_ROOT/lib"
readonly PROFILE_DIR="$REPO_ROOT/profile"

source "$PROFILE_DIR/bash.profile"
# ==========================> end of library header <===========================

readonly COMMAND="brew"

function is_brew_available() {
  type "$COMMAND" > /dev/null 2>&1
}

function prompt_installation() {
  cat <<EOS
$SCRIPT_NAME: line $LINENO: Install Homebrew <https://brew.sh> then re-run the
script.
EOS
}

if is_brew_available; then
  :
else
  prompt_installation 1>&2
  exit 1
fi
