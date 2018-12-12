#!/bin/bash

set -o errexit \
  -o noclobber \
  -o nounset \
  -o pipefail

while true; do
  echo "Are you sure you want to install dotfiles? [Y/n]"
  read ans
  if [[ "$ans" == "Y" ]]; then
    break
  elif [[ "$ans" == "n" ]]; then
    exit 1
  fi
done

# Link files in a directory recursively
function link_files_recursively() {
  if [[ ! -d "$1" ]]; then
    echo "Error: Source directory passed to link_files does not exist" >&2
    return 1
  fi

  local -r SRC_DIR="$1"
  local -r DEST_DIR="$2"

  # Make sure $DEST_DIR exists
  mkdir -p "$DEST_DIR"

  for entry in $(ls -A "$SRC_DIR"); do
    if [[ -f "$SRC_DIR/$entry" ]]; then
      ln -sF "$SRC_DIR/$entry" "$DEST_DIR/$entry"
    elif [[ -d "$SRC_DIR/$entry" ]]; then
      link_files_recursively "$SRC_DIR/$entry" "$DEST_DIR/$entry"
    fi
  done
}

readonly SRC_ROOT="$(cd $(dirname $0) && pwd)/home"
readonly DEST_ROOT="$HOME"

link_files_recursively "$SRC_ROOT" "$DEST_ROOT"
