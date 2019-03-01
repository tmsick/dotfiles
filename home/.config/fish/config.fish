set -gx LANG en_US.UTF-8

set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths $HOME/bin $fish_user_paths

# Ruby
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths

# GitHub's hub (https://github.com/github/hub)
if type -q hub
  eval ( hub alias -s )
end

# Dan Kogai's mv2trash (https://github.com/dankogai/osx-mv2trash)
if type -q mv2trash
  alias rm mv2trash
end
