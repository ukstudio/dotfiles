set -U EDITOR /usr/local/bin/vim

# Path to Oh My Fish install.
set -gx PATH ~/.rbenv/bin ~/gocode/bin $PATH
set -gx OMF_PATH /Users/ukstudio/.local/share/omf
set -g Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
set -gx GOPATH $HOME/gocode
set -gx NVM_DIR $HOME/.nvm

set -gx PR_RELEASE_GITHUB_TOKEN 'dc22caeae596437a64d67492dbb77061ef7a9677'

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

function find-pr
  set -l range $argv
  git log $range --merges --ancestry-path --reverse --oneline | head -n1
end

function find-pr-open
  set -l pr (find-pr $argv | awk '{print substr($5, 2)}')
  set -l repo (git config --get remote.origin.url | sed 's/git@github.com://' | sed 's/\.git$//')
  open "https://github.com/$repo/pull/$pr"
end

eval (thefuck --alias | tr '\n' ';')
