set -gx LANG en_US.UTF-8
set -gx PIPENV_VENV_IN_PROJECT 1
set -gx GOPATH $HOME/go

set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths /usr/local/opt/ruby/bin $fish_user_paths
set -g fish_user_paths $HOME/bin $fish_user_paths
set -g fish_user_paths $GOPATH/bin $fish_user_paths
set -g fish_user_paths $HOME/.cargo/bin $fish_user_paths

# GitHub's hub (https://github.com/github/hub)
eval ( hub alias -s )

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
alias rm mv2trash
