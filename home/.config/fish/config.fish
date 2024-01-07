if status is-interactive
    # Set PATH, MANPATH, etc., for Homebrew.
    eval (/opt/homebrew/bin/brew shellenv)

    set -x BAT_THEME Dracula
    set -x CLICOLOR 1
    set -x DOCKER_HIDE_LEGACY_COMMANDS 1
    set -x DOTFILES_HOME "$HOME/.dotfiles"
    set -x EDITOR vim
    set -x LANG "en_US.UTF-8"
    set -x PIPENV_VENV_IN_PROJECT 1
    set -x PIPENV_VERBOSITY -1
    set -x POETRY_VIRTUALENVS_IN_PROJECT 1
    set -x PYENV_ROOT "$HOME/.pyenv"
    set -x XDG_CONFIG_HOME "$HOME/.config"

    set -a fish_function_path "$DOTFILES_HOME/fish/functions"

    fish_add_path -pm "$HOMEBREW_PREFIX/sbin"
    fish_add_path -pm "$HOME/.local/bin"
    fish_add_path -pm "$PYENV_ROOT/bin"
    fish_add_path -pm "$HOME/go/bin"
    fish_add_path -pm "$HOMEBREW_PREFIX/opt/fzf/bin"

    alias less "less -i"
    alias vim nvim
    alias cat bat

    # Starship (https://starship.rs)
    starship init fish | source

    # nodenv (https://github.com/nodenv/nodenv)
    source (nodenv init -|psub)

    # rbenv (https://github.com/rbenv/rbenv)
    source (rbenv init -|psub)

    # pyenv (https://github.com/pyenv/pyenv)
    pyenv init - | source

    # direnv (https://github.com/direnv/direnv)
    direnv hook fish | source
end
