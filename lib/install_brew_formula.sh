#!/usr/bin/env bash
source "$DOTFILES_PROFILE"

# Make sure brew is installed
if type brew > /dev/null 2>&1; then
  :
else
  cat 1>&2 <<EOS
$SCRIPT_NAME: line $LINENO: 'brew' could not be found in \$PATH. Install Homebrew
<https://brew.sh> then re-run the script.
EOS
  exit 1
fi

readonly formulae=$(brew list)

for formula; do
  if echo "$formulae" | grep "$formula" > /dev/null; then
    :
  else
    brew install "$formula"
  fi
done
