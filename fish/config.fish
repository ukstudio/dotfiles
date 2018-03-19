set -g fish_key_bindings fish_hybrid_key_bindings

alias t tmux
alias tc 'tmux list-sessions | peco | awk -F: \'{print $1}\' | read s; and tmux switch-client -t $s'

alias g git
alias gclean 'git fetch; and git branch --merged origin/master | grep -v "^\s*master" | grep -v "^*" | xargs git branch -D'

alias r rails
alias be 'bundle exec'

alias dc docker-compose

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
  bind -M insert \cr 'peco_select_history (commandline -b)'
end

function find-pr
  set -l range $argv
  git log $range --merges --ancestry-path --reverse --oneline | head -n1
end

function find-pr-open
  set -l pr (find-pr $argv | awk '{print substr($5, 2)}')
  set -l repo (git config --get remote.origin.url | sed 's/.*github.com//' | sed 's/\.git$//')
  open "https://github.com/$repo/pull/$pr"
end

eval (direnv hook fish)
