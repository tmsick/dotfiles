set -gx LANG en_US.UTF-8

set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths $HOME/bin $fish_user_paths

set -gx PIPENV_DIR $HOME/.local/share/virtualenvs

# GitHub's hub (https://github.com/github/hub)
if type -q hub
  eval ( hub alias -s )
end

# nodenv (https://github.com/nodenv/nodenv)
if type -q nodenv
  status --is-interactive; and source (nodenv init -|psub)
end

# rbenv (https://github.com/rbenv/rbenv)
if type -q rbenv
  status --is-interactive; and source (rbenv init -|psub)
end

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
if type -q mv2trash
  alias rm mv2trash
end
