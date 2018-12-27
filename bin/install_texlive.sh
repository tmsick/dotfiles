#!/bin/bash
# Install and configure TeX Live suite
# You may have to execute this script with `sudo`

source "$(dirname $0)/.bashrc"

readonly REPO_ROOT="$(cd $(dirname $0) && cd .. && pwd)"


# Use JAIST as a mirror site
readonly TEXLIVE_TLNET_URL="http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet"

function install_texlive() {
  local -r texlive_tlnet_url="$1"

  # Generate a unique tmp working dir
  local tmp_dir="/tmp/texlive_$(date | md5)"
  while [[ -d "$tmp_dir" ]]; do
    tmp_dir="/tmp/texlive_$(echo $tmp_dir | md5)"
  done
  declare -r tmp_dir
  mkdir -p "$tmp_dir"
  cd "$tmp_dir"

  # Download, extract, and execute the installer
  curl -O "$texlive_tlnet_url/install-tl-unx.tar.gz"
  tar xvf "install-tl-unx.tar.gz"
  cd "install-tl-$(TZ=UTC date '+%Y%m%d')"
  ./install-tl \
    --repository="$texlive_tlnet_url" \
    --profile="$REPO_ROOT/config/texlive.profile"

  # Clean up the tmp dir
  cd "$REPO_ROOT"
  rm -r "$tmp_dir"
}

install_texlive "$TEXLIVE_TLNET_URL"
