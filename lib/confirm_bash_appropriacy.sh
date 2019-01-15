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

if [[ $# -eq 0 ]] || [[ ! -x "$1" ]]; then
  echo "$SCRIPT_NAME: line $LINENO: Bash executable path is required" 1>&2
  exit 1
fi

readonly BASH_PATH="$1"
readonly APPROPRIATE_VERSIONS=(4 5)

function is_bash_version_appropriate() {
  local current_version=$(echo 'echo $BASH_VERSION' | "$BASH_PATH" |
    cut -d '.' -f 1)

  for appropriate_version in ${APPROPRIATE_VERSIONS[@]}; do
    if [[ $current_version -eq $appropriate_version ]]; then
      return 0
    fi
  done

  return 1
}

function install_appropriate_bash() {
  "$LIB_DIR/confirm_brew_availability.sh"
  brew update
  brew install bash
}

if is_bash_version_appropriate; then
  :
else
  install_appropriate_bash
fi
