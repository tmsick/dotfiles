eval (/opt/homebrew/bin/brew shellenv)

set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx BAT_THEME Dracula
set -gx CLICOLOR 1
set -gx CLOUDSDK_PYTHON /usr/bin/python3
set -gx DOCKER_HIDE_LEGACY_COMMANDS 1
set -gx DOTFILES_HOME "$HOME/.dotfiles"
set -gx EDITOR vim
set -gx HOMEBREW_BUNDLE_FILE "$XDG_CONFIG_HOME/brew/Brewfile"
set -gx LANG "en_US.UTF-8"
set -gx PNPM_HOME "$HOME/Library/pnpm"

set -a fish_function_path "$DOTFILES_HOME/fish/functions"

fish_add_path -gpm "$HOMEBREW_PREFIX/opt/fzf/bin"
fish_add_path -gpm "$PNPM_HOME"
fish_add_path -gpm "$HOME/.local/bin"
fish_add_path -gpm "$HOME/.local/share/mise/shims"
fish_add_path -gpm "$HOME/bin"
fish_add_path -gpm "$HOME/go/bin"

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
