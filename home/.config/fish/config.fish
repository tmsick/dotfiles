set -gx DOCKER_HIDE_LEGACY_COMMANDS 1
set -gx DOTFILES_HOME "$HOME/.dotfiles"
set -gx EDITOR vim
set -gx GOPATH "$HOME/go"
set -gx HOMEBREW_CELLAR "/usr/local/Cellar"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_PREFIX "/usr/local"
set -gx HOMEBREW_REPOSITORY "/usr/local/Homebrew"
set -gx LANG "en_US.UTF-8"
set -gx PIPENV_VENV_IN_PROJECT 1
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -g fish_user_paths \
    # Go
    $GOPATH/bin \
    "/usr/local/go/bin" \
    # Ruby
    "/usr/local/opt/ruby/bin" \
    # fzf
    "/usr/local/opt/fzf/bin" \
    # Miscellaneous
    "$DOTFILES_HOME/bin" \
    "$HOME/.local/bin" \
    "/usr/local/bin" \
    "/usr/local/sbin" \
    $fish_user_paths

set -g fish_function_path \
    "$DOTFILES_HOME/fish/functions" \
    $fish_function_path

alias git hub
alias gitsh "gitsh --git '/usr/bin/env hub'"
alias go2univ "cd (univdir)"
alias gpg gpg2
alias tree "tree -C"

starship init fish | source
