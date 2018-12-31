#!/bin/bash
# Install and configure TeX Live suite
# You may have to execute this script with `sudo`

source "$(dirname $0)/.bashrc"

readonly REPO_ROOT="$(cd $(dirname $0) && cd .. && pwd)"

# Use JAIST as a mirror site
readonly TEXLIVE_TLNET_URL="http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet"

# Generate a unique tmp working dir
TMP_DIR="/tmp/texlive_$(date | md5)"
while [[ -d "$TMP_DIR" ]]; do
  TMP_DIR="/tmp/texlive_$(echo $TMP_DIR | md5)"
done
declare -r TMP_DIR
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

# Download, extract, and execute the installer
curl -O "$TEXLIVE_TLNET_URL/install-tl-unx.tar.gz"
tar xvf "install-tl-unx.tar.gz"
cd "install-tl-$(TZ=UTC date '+%Y%m%d')"
./install-tl \
  --repository="$TEXLIVE_TLNET_URL" \
  --profile="$REPO_ROOT/config/texlive.profile"

# Remove the tmp dir
cd "$REPO_ROOT"
rm -r "$TMP_DIR"
