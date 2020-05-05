set -gx LANG "en_US.UTF-8"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx DOTFILES_HOME "$HOME/.dotfiles"
set -gx HOMEBREW_PREFIX "/usr/local"
set -gx HOMEBREW_CELLAR "/usr/local/Cellar"
set -gx HOMEBREW_REPOSITORY "/usr/local/Homebrew"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx GOPATH "$HOME/go"
set -gx DOCKER_HIDE_LEGACY_COMMANDS 1
set -gx PIPENV_VENV_IN_PROJECT 1

set -l paths_candidates \
    # Go
    "$GOPATH/bin" "/usr/local/go/bin" \
    # Rust
    "$HOME/.cargo/bin" \
    # Miscellaneous
    "$HOME/bin" "$HOME/.local/bin" "/usr/local/bin" "/usr/local/sbin"
for p in $paths_candidates
    if test -d $p
        set -g fish_user_paths $fish_user_paths $p
    end
end

# GitHub's hub (https://github.com/github/hub)
if which hub >/dev/null
    eval (hub alias -s)
end

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
if which mv2trash >/dev/null
    alias trash mv2trash
end

# The Fuck (https://github.com/nvbn/thefuck)
if which thefuck >/dev/null
    thefuck --alias | source
end

# Go to univ dir of current semester
if which univdir >/dev/null
    alias go2univ "cd (univdir)"
end

# MacGPG included within GPGTools (https://gpgtools.org)
if which gpg2 >/dev/null
    alias gpg gpg2
end

# Starship (https://starship.rs)
if which starship >/dev/null
    starship init fish | source
end

# anyenv (https://github.com/anyenv/anyenv)
if which anyenv >/dev/null
    status --is-interactive; and source (anyenv init -|psub)
end

# pyenv bin have to be removed from $PATH when running brew
# ref: https://github.com/pyenv/pyenv/issues/106
if which brew >/dev/null && which pyenv >/dev/null
    function brew
        begin
            set -lx PATH (printenv PATH | sed s!(pyenv root)/shims:!!)
            command brew $argv
        end
    end
end
