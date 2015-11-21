export TERM=xterm-256color
export LSCOLORS=cxfxcxdxbxegedabagacad
export SVN_EDITOR=vim
export EDITOR=vim

export LANG=ja_JP.UTF-8
alias ls="ls -G -v"
alias v='vim'
alias :q='exit'
alias g='noglob git'
alias gff='noglob git flow feature'
alias r='rails'
alias o='xdg-open'
alias gs='gem search -r'
alias be='bundle exec '
alias ro='grep -E "describe|context" '

alias t='tmux new -s `basename \`pwd\``'
alias -g C='`git ls-files --cached | peco`'

export GREP_OPTIONS="--color=auto"

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

setopt autopushd

autoload -U compinit promptinit
compinit
#promptinit; prompt gentoo

autoload colors; colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

function chpwd() { ls }

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}


#コマンドラインバッファスタックをvimモードで
setopt noflowcontrol
bindkey '^Q' push-line-or-edit

unset RUBYOPT

[[ -s /home/ukstudio/.tmuxinator/scripts/tmuxinator ]] && source /home/ukstudio/.tmuxinator/scripts/tmuxinator

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

. $HOME/z.sh
alias j=z

function ghn-open() {
  local url=$(ghn list | peco --query "$LBUFFER")
  if [ -n "$url" ]; then
    open ${url}
  fi
}

function pivo-open() {
  local url="$(pivo stories all $1 --mywork ukstudio| peco --query "$LBUFFER" | awk '{print $NF}')"
  open ${url}
}

function p() { peco | while read LINE; do $@ $LINE; done }

function gcd() { ghq list -p | p cd }

function gem-jump { bundle show --paths | p cd }

function pf() {
  ${1:=$(pwd)}
  local selected=$(find $1 -maxdepth 2 | peco)
  if [[ -d $selected ]]; then
    pf $selected
  elif [[ -f $selected ]]; then
    xdg-open $selected
  fi
}

function find-pr() {
  local parent=$2||'master'
  git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

function find-pr-open() {
  local pr="$(find-pr $1 $2 | awk '{print substr($5, 2)}')"
  local br="$(git config --get remote.origin.url | sed 's/git@github.com://' | sed 's/\.git$//')"
  open "https://github.com/${br}/pull/${pr}"
}

# antigen
. $HOME/.antigen.zsh
antigen-use oh-my-zsh

antigen-bundle git
antigen-bundle gitfast
antigen-bundle gem
antigen-bundle bundler
antigen-bundle vi-mode
antigen-bundle zsh-users/zsh-syntax-highlighting

antigen-theme steeef

antigen-apply

unsetopt correct_all

# OPAM configuration
. /Users/ukstudio/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
