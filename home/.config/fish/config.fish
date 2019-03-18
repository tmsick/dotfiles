set -gx LANG en_US.UTF-8
set -gx PIPENV_VENV_IN_PROJECT true
set -gx GOPATH $HOME/go

set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths $HOME/bin $fish_user_paths
set -g fish_user_paths $GOPATH/bin $fish_user_paths


# GitHub's hub (https://github.com/github/hub)
eval ( hub alias -s )

# nodenv (https://github.com/nodenv/nodenv)
status --is-interactive; and source (nodenv init -|psub)

# rbenv (https://github.com/rbenv/rbenv)
status --is-interactive; and source (rbenv init -|psub)

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
alias rm mv2trash
