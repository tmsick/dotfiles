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

    fish_add_path -P --move \
        # General
        "$HOME/.local/bin" \
        # MacGPG2
        /usr/local/MacGPG2/bin \
        # pyenv
        "$PYENV_ROOT/bin" \
        # Golang
        "$HOME/go/bin" \
        # fzf
        "$HOMEBREW_PREFIX/opt/fzf/bin" \
        # Miscellaneous
        "$HOMEBREW_PREFIX/sbin"

    set -a fish_function_path "$DOTFILES_HOME/fish/functions"

    # Starship (https://starship.rs)
    starship init fish | source

    # nodenv (https://github.com/nodenv/nodenv)
    source (nodenv init -|psub)

    # rbenv (https://github.com/rbenv/rbenv)
    source (rbenv init -|psub)

    # pyenv (https://github.com/pyenv/pyenv)
    pyenv init - | source

    # https://github.com/fish-shell/fish-shell/issues/6270#issuecomment-548515306
    # function __fish_describe_command
    # end

    # Google Cloud SDK installed via Homebrew cask
    # source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

    # direnv (https://github.com/direnv/direnv)
    direnv hook fish | source

    # Ignore case when searching with less
    alias less "less -i"
end
