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

set -l paths_candidates \
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
    "/usr/local/sbin"
for p in $paths_candidates
    if test -d $p
        set -g fish_user_paths $fish_user_paths $p
    end
end

# GitHub's hub (https://github.com/github/hub)
if which hub >/dev/null
    eval (hub alias -s)

    # gitsh (https://github.com/thoughtbot/gitsh)
    if which gitsh >/dev/null
        alias gitsh "gitsh --git '/usr/bin/env hub'"
    end
end

# Go to univ dir of current semester
if which univdir >/dev/null
    alias go2univ "cd (univdir)"
end

# MacGPG included within GPGTools (https://gpgtools.org)
if which gpg2 >/dev/null
    alias gpg gpg2
end

if which tree >/dev/null
    alias tree "tree -C"
end

# Starship (https://starship.rs)
if which starship >/dev/null
    starship init fish | source
end
