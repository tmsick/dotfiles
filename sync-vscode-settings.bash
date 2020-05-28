#!/bin/bash

set -o errexit \
    -o noclobber \
    -o nounset \
    -o pipefail

readonly SCRIPT_DIR=$(cd "${0%/*}" && pwd)

readonly VSCODE_CONFIG_BACKUP_DIR="$SCRIPT_DIR/vscode"
readonly VSCODE_CONFIG_DEST_DIR="$HOME/Library/Application Support/Code/User"
readonly VSCODE_CONFIG_FILES=("settings.json" "keybindings.json")

readonly __ansi_reset__=$(printf '\033[0m')
readonly __ansi_fg_yellow__=$(printf '\033[33m')

warn() {
    echo "$__ansi_fg_yellow__""$*""$__ansi_reset__" >&2
}

main() {
    local status=0

    for file in "${VSCODE_CONFIG_FILES[@]}"; do
        local backup_filepath="$VSCODE_CONFIG_BACKUP_DIR/$file"
        local dest_filepath="$VSCODE_CONFIG_DEST_DIR/$file"

        if [[ -f "$backup_filepath" && -f "$dest_filepath" ]]; then
            # Do nothing if the two files are the same
            diff "$backup_filepath" "$dest_filepath" >/dev/null && continue

            # Overwrite with the newer one
            local backup_timestamp
            local dest_timestamp
            backup_timestamp=$(stat -f '%a' "$backup_filepath")
            dest_timestamp=$(stat -f '%a' "$dest_filepath")
            if [[ $backup_timestamp -eq $dest_timestamp ]]; then
                echo -n "$__ansi_fg_yellow__"
                cat <<EOS
The timestamps of the below files are the same but their contents are different.
This script does not know how to handle this situation and has done nothing with
them.
    - $backup_filepath
    - $dest_filepath
EOS
                echo -n "$__ansi_reset__"
                status=1
            elif [[ $backup_timestamp -gt $dest_timestamp ]]; then
                cp "$backup_filepath" "$dest_filepath"
            else
                cp "$dest_filepath" "$backup_filepath"
            fi
        elif [[ -f "$backup_filepath" ]]; then
            cp "$backup_filepath" "$dest_filepath"
        elif [[ -f "$dest_filepath" ]]; then
            cp "$dest_filepath" "$backup_filepath"
        else
            warn "'$file' does not exist"
            status=10
        fi
    done

    return $status
}

main
