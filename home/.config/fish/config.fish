set -x DOCKER_HIDE_LEGACY_COMMANDS 1
set -x DOTFILES_HOME "$HOME/.dotfiles"
set -x EDITOR vim
set -x GOPATH "$HOME/go"
set -x HOMEBREW_CELLAR "/usr/local/Cellar"
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_PREFIX "/usr/local"
set -x HOMEBREW_REPOSITORY "/usr/local/Homebrew"
set -x LANG "en_US.UTF-8"
set -x N_PREFIX "$HOME/n"
set -x PIPENV_VENV_IN_PROJECT 1
set -x PIPENV_VERBOSITY -1
set -x XDG_CONFIG_HOME "$HOME/.config"

set -p fish_user_paths \
    # MacGPG2
    "/usr/local/MacGPG2/bin" \
    # tj/n
    "$N_PREFIX/bin" \
    # Golang
    "$GOPATH/bin" \
    "/usr/local/go/bin" \
    # fzf
    "/usr/local/opt/fzf/bin" \
    # Miscellaneous
    "$DOTFILES_HOME/bin" \
    "$HOME/.local/bin" \
    "/usr/local/sbin"
set -p fish_function_path "$DOTFILES_HOME/fish/functions"

which -s hub && alias git hub
which -s starship && starship init fish | source
which -s pyenv && status --is-interactive; and source (pyenv init -|psub)
which -s rbenv && status --is-interactive; and source (rbenv init -|psub)
