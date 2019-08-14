#!/bin/bash

set -o errexit
set -o noclobber
set -o nounset
set -o pipefail

readonly DIR="${0%/*}"
readonly FILE="${0##*/}"
readonly DIR_ABS="$PWD/$DIR"
readonly FILE_ABS="$PWD/$DIR/$FILE"

brew analytics off &&
    brew update &&
    brew bundle --path="$DIR_ABS/Brewfile" &&
    brew cleanup &&
    brew doctor
