#!/usr/bin/env bash

# ==================================> header <==================================
readonly SCRIPT_PATH=$(realpath "$0")
readonly SCRIPT_NAME=$(basename "$SCRIPT_PATH")
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
readonly REPO_ROOT=$(realpath "$SCRIPT_DIR/..")
readonly LIB_DIR="$REPO_ROOT/lib"
readonly PROFILE_DIR="$REPO_ROOT/profile"

source "$PROFILE_DIR/bash.profile"
# ==============================================================================

function link_files() {
  local src_dir="$1"
  local dest_dir="$2"

  if [[ ! -d "$src_dir" ]]; then
    echo "$SCRIPT_NAME: line $LINENO: Source directory does not exist."
    return 1
  fi

  mkdir -p "$dest_dir"

  for entry in $(ls -A "$src_dir"); do
    local src_path="$src_dir/$entry"
    local dest_path="$dest_dir/$entry"

    if [[ -f "$src_path" ]] && [[ ! -L "$src_path" ]]; then
      ln -sF "$src_path" "$dest_path"
    elif [[ -d "$src_path" ]]; then
      link_files "$src_path" "$dest_path"
    fi
  done
}

readonly SRC_ROOT="$REPO_ROOT/home"
readonly DEST_ROOT="$HOME"

link_files "$SRC_ROOT" "$DEST_ROOT"
