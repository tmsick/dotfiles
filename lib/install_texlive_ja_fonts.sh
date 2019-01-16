#!/usr/bin/env bash
source "$DOTFILES_PROFILE"

readonly TMP_DIR=$(generate_unique_tmp_entry_name "texlive")
readonly MACOS_VERSION=$(sw_vers | grep -E '^ProductVersion' | cut -f 2 |
  cut -d '.' -f 2)
readonly MAPFILES=(
  [11]="hiragino-elcapitan-pron"  # El Capitan
  [12]="hiragino-elcapitan-pron"  # Sierra
  [13]="hiragino-highsierra-pron" # High Sierra
  [14]="hiragino-highsierra-pron" # Mojave
)
readonly TLCONTRIB_REPO="http://contrib.texlive.info/current"
readonly TLCONTRIB_TAG="tlcontrib"
readonly INTEGRATION_SCRIPT="cjk-gs-integrate-macos.pl"
readonly SCRIPT_REPOSITORY="https://raw.githubusercontent.com/texjporg/cjk-gs-support/master"

function generate_unique_tmp_entry_name() {
  local prefix=""
  if [[ $# -gt 0 ]]; then
    prefix="${1}_"
  fi

  local tmp_dir="/tmp"
  local entry_path="$tmp_dir/$prefix$(date | md5)"

  while [[ -e "$entry_path" ]]; do
    entry_path="$tmp_dir/$prefix$(echo $entry_path | md5)"
  done

  echo "$entry_path"
}

function is_macos_version_supported() {
  for supported_version in "${!MAPFILES[@]}"; do
    if [[ $MACOS_VERSION -eq $supported_version ]]; then
      return 0
    fi
  done

  return 1
}

if is_macos_version_supported; then
  :
else
  echo "$SCRIPT_NAME: line $LINENO: Your macOS version is not supported." 1>&2
  exit 1
fi

mkdir -p "$TMP_DIR"
pushd "$TMP_DIR"

sudo tlmgr update --self --all

if tlmgr repository list | grep -q "$TLCONTRIB_REPO"; then
  :
else
  sudo tlmgr repository add "$TLCONTRIB_REPO" "$TLCONTRIB_TAG"
fi

sudo tlmgr pinning add "$TLCONTRIB_TAG" "*"

sudo tlmgr install japanese-otf-nonfree \
  japanese-otf-uptex-nonfree \
  ptex-fontmaps-macos \
  cjk-gs-integrate-macos
sudo cjk-gs-integrate --link-texmf --cleanup

curl -O "$SCRIPT_REPOSITORY/$INTEGRATE_SCRIPT"
chmod +x "$INTEGRATION_SCRIPT"
sudo "./$INTEGRATION_SCRIPT" --link-texmf

sudo mktexlsr

sudo kanji-config-updmap-sys --jis2004 "${MAPFILES[$MACOS_VERSION]}"

popd
rm -r "$TMP_DIR"
