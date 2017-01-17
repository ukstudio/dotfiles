set -U EDITOR /usr/local/bin/vim

# Path to Oh My Fish install.
set -gx PATH ~/.rbenv/bin ~/gocode/bin ~/local/bin $PATH
set -gx OMF_PATH /Users/ukstudio/.local/share/omf
set -g Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
set -gx GOPATH $HOME/gocode

source ~/.config/fish/config.local.fish

# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/ukstudio/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/ukstudio/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias t tmux
alias tc 'tmux list-sessions | peco | awk -F: \'{print $1}\' | read s; and tmux switch-client -t $s'

alias g git
alias gclean 'git fetch; and git branch --merged origin/master | grep -v "^\s*master" | grep -v "^*" | xargs git branch -D'

alias r rails
alias be 'bundle exec'

alias gcd 'ghq list -p | peco | read line ; cd $line'

function git-hash
  git log --oneline | peco | awk '{print $1}'
end

alias gfixup 'git-hash | read line; git commit --fixup=$line'
alias grebase 'git-hash | read line; git rebase -i $line^ --autosquash'
alias gco 'git branch -r | peco --query "$LBUFFER" | awk -F/ \'{print $2}\' | read b; and git checkout -b $b origin/$b'

function cd
  builtin cd $argv
  ls -ah
end

function peco_select_history
  history|peco|read slct
  if [ $slct ]
    commandline $slct
  else
    commandline ''
  end
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

