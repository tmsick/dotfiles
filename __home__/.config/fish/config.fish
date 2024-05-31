if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)

    set -x XDG_CONFIG_HOME "$HOME/.config"

    set -x GOHOME "$HOME/go"
    set -x GOBIN "$GOHOME/bin"

    set -x BAT_THEME Dracula
    set -x CLICOLOR 1
    set -x DOCKER_HIDE_LEGACY_COMMANDS 1
    set -x DOTFILES_HOME "$HOME/.dotfiles"
    set -x EDITOR vim
    set -x HOMEBREW_BUNDLE_FILE "$XDG_CONFIG_HOME/brew/Brewfile"
    set -x LANG "en_US.UTF-8"
    set -x PIPENV_VENV_IN_PROJECT 1
    set -x PIPENV_VERBOSITY -1
    set -x PIPX_HOME "$HOME/.pipx"
    set -x POETRY_VIRTUALENVS_IN_PROJECT 1
    set -x PYENV_ROOT "$HOME/.pyenv"
    set -x VOLTA_HOME "$HOME/.volta"

    set -a fish_function_path "$DOTFILES_HOME/fish/functions"

    fish_add_path -pm "$GOBIN"
    fish_add_path -pm "$VOLTA_HOME/bin"
    fish_add_path -pm "$HOME/.local/bin"
    fish_add_path -pm "$HOME/bin"
    fish_add_path -pm "$HOMEBREW_PREFIX/opt/fzf/bin"

    command -q bat && alias cat bat
    command -q grpcurl && alias gcurl grpcurl
    command -q less && alias less "less -i"
    command -q nvim && alias vim nvim

    # Starship (https://starship.rs)
    starship init fish | source

    # rbenv (https://github.com/rbenv/rbenv)
    source (rbenv init -|psub)

    # pyenv (https://github.com/pyenv/pyenv)
    pyenv init - | source

    # direnv (https://github.com/direnv/direnv)
    direnv hook fish | source

    # fzf (https://github.com/junegunn/fzf)
    fzf --fish | source
end
