set -gx LANG en_US.UTF-8

set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths $HOME/bin $fish_user_paths

# GitHub's hub (https://github.com/github/hub)
eval ( hub alias -s )

# rbenv (https://github.com/rbenv/rbenv)
if type -q rbenv
  status --is-interactive; and source (rbenv init -|psub)
end

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
alias rm mv2trash
