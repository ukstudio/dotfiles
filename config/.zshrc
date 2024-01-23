source ~/.zshrc.local

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

alias t=tmux

alias g=git
alias gcd='cd $(ghq list -p | peco)'
alias gfixup='git commit --fixup=$(git-hash)'
alias grebase='git rebase -i $(git-hash)^ --autosquash'
alias gclean='git fetch origin; git branch --merged origin/master | grep -v "^\s*master" | grep -v "^*" | xargs git branch -D'

export PATH=$HOME/local/bin:$PATH

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history

function git-hash() {
  git log --oneline | peco | awk '{print $1}'
}

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yuki-akamatsu/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
