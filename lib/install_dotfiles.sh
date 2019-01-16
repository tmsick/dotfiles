#!/usr/bin/env bash
source "$DOTFILES_PROFILE"

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
