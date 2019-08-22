set -gx LANG "en_US.UTF-8"
set -gx HOMEBREW_PREFIX "/usr/local"
set -gx HOMEBREW_CELLAR "/usr/local/Cellar"
set -gx HOMEBREW_REPOSITORY "/usr/local/Homebrew"
set -gx GOPATH "$HOME/go"
set -gx PIPENV_VENV_IN_PROJECT "1"
set -gx FZF_DEFAULT_OPTS "--ansi"

set -q MANPATH
or set MANPATH ''
set -gx MANPATH "/usr/local/share/man" $MANPATH

set -q INFOPATH
or set INFOPATH ''
set -gx INFOPATH "/usr/local/share/info" $INFOPATH

set -g fish_user_paths \
    "$HOME/bin" \
    "$GOPATH/bin" \
    "$HOME/.cargo/bin" \
    "/usr/local/opt/curl/bin" \
    "/usr/local/bin" \
    "/usr/local/sbin" \
    $fish_user_paths

# GitHub's hub (https://github.com/github/hub)
eval (hub alias -s)

# rbenv (https://github.com/rbenv/rbenv)
status --is-interactive
and source (rbenv init -|psub)

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
alias "trash" "mv2trash"
