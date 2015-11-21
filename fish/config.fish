# Path to Oh My Fish install.
set -gx PATH $PATH ~/.rbenv/bin
set -gx OMF_PATH /Users/ukstudio/.local/share/omf
set -g Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /Users/ukstudio/.config/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias t tmux

alias g git
alias gclean 'git fetch; and git branch --merged origin/master | grep -v "^\s*master" | grep -v "^*" | xargs git branch -D'

alias r rails
alias be 'bundle exec'

function cd
  builtin cd $argv
  ls -ah
end

function fish_user_key_bindings
  fish_vi_key_bindings
  bind -M insert \cr 'peco_select_history (commandline -b)'
end

