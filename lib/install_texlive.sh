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

# The normal user who executed this script
readonly NORMAL_USER="$(last | head -n 1 | cut -d ' ' -f 1)"

readonly MACOS_VERSION="$(sw_vers | grep -E '^ProductVersion' | cut -f 2 \
  | cut -d '.' -f 2)"
if [[ $MACOS_VERSION -gt 14 || $MACOS_VERSION -lt 11 ]]; then
  cat <<EOS 1>&2
$SCRIPT_NAME: line $LINENO: Your macOS system version (10.$MACOS_VERSION) is not
suported. Supported versions are El Capitan (10.11), Sierra (10.12),
High Sierra (10.13), and Mojave (10.14).
EOS
  exit 1
fi

function is_sudo() {
  tmpfile="/tmp_$(date | md5)"
  if [[ -f "$tmpfile" ]]; then
    tmpfile="/tmp_(echo $tmpfile | md5)"
  fi
  if touch "$tmpfile" 2> /dev/null; then
    rm "$tmpfile"
    return 0
  else
    return 1
  fi
}

function print_help() {
  cat <<EOS
Usage: $SCRIPT_NAME [OPTION]
Install TeX Live to macOS system

  -r REPOSITORY  use REPOSITORY as a TeX Live file source
  -p PROFILE     use PROFILE as a installation profile

  -h             display this hint and exit

Example:
  $SCRIPT_NAME -r http://ftp.yz.yamagata-u.ac.jp/pub/CTAN/systems/texlive/tlnet
  $SCRIPT_NAME -p ./config/texlive/2018/texlive.profile
EOS
}

# ===============> Process args and set repository and profile <================
# Use JAIST as a default mirror site
repository="http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet"
# Nothing is set as a default profile
profile=""
while getopts r:p:h option; do
  case "$option" in
    "r")
      repository="$OPTARG"
      ;;
    "p")
      profile="$(realpath $OPTARG)"
      ;;
    "h")
      print_help
      exit 0
      ;;
  esac
done

# ===============================> Confirm sudo <===============================
if is_sudo; then
  :
else
  echo "$SCRIPT_NAME: line $LINENO: This script have to be run with 'sudo'" 1>&2
  exit 2
fi

# ====================> Generate a unique tmp working dir <=====================
TMPDIR="/tmp/texlive_$(date | md5)"
while [[ -d "$TMPDIR" ]]; do
  TMPDIR="/tmp/texlive_$(echo $TMPDIR | md5)"
done
declare -r TMPDIR
mkdir -p "$TMPDIR"
cd "$TMPDIR"

# ==============> Download, extract, and run TeX Live installer <===============
curl -O "$repository/install-tl-unx.tar.gz"
tar xvf "install-tl-unx.tar.gz"
cd "$(ls -F | grep -E '/$')"
# If no profile is specified, generate it and copy it to this repo
if [[ -n "$profile" ]]; then
  TEXDIR="$(cat $profile | grep -E '^TEXDIR ' | cut -d ' ' -f 2)"
else
  profile_src=""
  while [[ ! -f "$profile_src" ]]; do
    echo "======> Configure settings then press <P> to generate texlive.profile <======="
    ./install-tl --repository="$repository"
    profile_src="$(realpath ./texlive.profile)"
  done
  TEXDIR="$(cat $profile_src | grep -E '^TEXDIR ' | cut -d ' ' -f 2)"
  year="$(echo $TEXDIR | grep -o -E '[0-9]{4}')"
  profile_dir="$REPO_ROOT/config/texlive/$year"
  mkdir -p "$profile_dir"
  profile="$profile_dir/texlive_$(date '+%Y%m%d%H%M%S').profile"
  cp "$profile_src" "$profile"
  chown -R "$NORMAL_USER" "$REPO_ROOT/config"
fi
declare -r TEXDIR
echo "TEXDIR: $TEXDIR"
exit 0
# Execute installation
./install-tl \
  --repository="$repository" \
  --profile="$profile"

# ===========================> Initialize TeX Live <============================
cd "$TMPDIR"
if [[ ! -d "$TEXDIR" ]]; then
  echo "$SCRIPT_NAME: line $LINENO: A valid TEXDIR cannot be detected from $profile" 1>&2
  cd "$REPO_ROOT"
  rm -r "$TMPDIR"
  exit 3
fi
readonly TLCONTRIB_REPO="http://contrib.texlive.info/current"
readonly TLCONTRIB_TAG="tlcontrib"
$TEXDIR/bin/x86_64-darwin/tlmgr path add
tlmgr update --self --all
if tlmgr repository list | grep -q "$TLCONTRIB_REPO"; then
  :
else
  tlmgr repository add "$TLCONTRIB_REPO" "$TLCONTRIB_TAG"
fi
tlmgr pinning add tlcontrib '*'
tlmgr install japanese-otf-nonfree \
  japanese-otf-uptex-nonfree \
  ptex-fontmaps-macos \
  cjk-gs-integrate-macos
cjk-gs-integrate --link-texmf --cleanup
curl -O https://raw.githubusercontent.com/texjporg/cjk-gs-support/master/cjk-gs-integrate-macos.pl
chmod +x ./cjk-gs-integrate-macos.pl
./cjk-gs-integrate-macos.pl --link-texmf
mktexlsr
# El Capitan or Sierra
if [[ $MACOS_VERSION -eq 11 || $MACOS_VERSION -eq 12 ]]; then
  kanji-config-updmap-sys --jis2004 hiragino-elcapitan-pron
# High Sierra or Mojave
elif [[ $MACOS_VERSION -eq 13 || $MACOS_VERSION -eq 14 ]]; then
  kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron
fi

# ========================> Remove the tmp working dir <========================
cd "$REPO_ROOT"
rm -r "$TMPDIR"
