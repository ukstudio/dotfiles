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

alias tmux-changekey='tmux set-option -ag prefix C-t'
alias tmux-revertkey='tmux set-option -ag prefix C-a'
alias tchdir='tmux set-option default-path $PWD'

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
promptinit; prompt gentoo

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

# antigen
. $HOME/.antigen.zsh
antigen-lib

antigen-bundle git
antigen-bundle gitfast
antigen-bundle gem
antigen-bundle bundler
antigen-bundle vi-mode
antigen-bundle zsh-users/zsh-syntax-highlighting

antigen-theme gallois

antigen-apply

unsetopt correct_all
