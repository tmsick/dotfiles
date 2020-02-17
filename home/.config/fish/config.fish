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

set -q MANPATH
or set MANPATH ''
set -gx MANPATH "/usr/local/share/man" $MANPATH

set -q INFOPATH
or set INFOPATH ''
set -gx INFOPATH "/usr/local/share/info" $INFOPATH

set paths_candidates \
    # Go
    "$GOPATH/bin" "/usr/local/go/bin" \
    # Rust
    "$HOME/.cargo/bin" \
    # Ruby
    "/usr/local/opt/ruby/bin" \
    "/usr/local/lib/ruby/gems/2.7.0/bin" \
    # Miscellaneous
    "$HOME/bin" "/usr/local/bin" "/usr/local/sbin"
for p in $paths_candidates
    if test -d "$p"
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
alias go2univ "cd (univdir)"

# MacGPG included within GPGTools (https://gpgtools.org)
alias gpg gpg2
