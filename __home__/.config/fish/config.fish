if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)

    set -x XDG_CONFIG_HOME "$HOME/.config"

    set -x BAT_THEME Dracula
    set -x CLICOLOR 1
    set -x CLOUDSDK_PYTHON /usr/bin/python3
    set -x DOCKER_HIDE_LEGACY_COMMANDS 1
    set -x DOTFILES_HOME "$HOME/.dotfiles"
    set -x EDITOR vim
    set -x HOMEBREW_BUNDLE_FILE "$XDG_CONFIG_HOME/brew/Brewfile"
    set -x LANG "en_US.UTF-8"
    set -x PNPM_HOME "$HOME/Library/pnpm"
    set -x VOLTA_HOME "$HOME/.volta"
    set -x VOLTA_FEATURE_PNPM 1

    set -a fish_function_path "$DOTFILES_HOME/fish/functions"

    fish_add_path -pm "$HOME/.local/bin"
    fish_add_path -pm "$HOMEBREW_PREFIX/opt/fzf/bin"
    fish_add_path -pm "$VOLTA_HOME/bin"
    fish_add_path -pm "$PNPM_HOME"
    fish_add_path -pm "$HOMEBREW_PREFIX/opt/rustup-init/bin"
    fish_add_path -pm "$HOME/go/bin"
    fish_add_path -pm "$HOME/bin"

    command -q bat && alias cat bat
    command -q git && alias g git
    command -q grpcurl && alias gcurl grpcurl
    command -q less && alias less "less -i"
    command -q nvim && alias vim nvim

    # Starship (https://starship.rs)
    starship init fish | source

    # direnv (https://github.com/direnv/direnv)
    direnv hook fish | source

    # fzf (https://github.com/junegunn/fzf)
    fzf --fish | source
end
