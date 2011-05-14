export TERM=xterm-256color
export LSCOLORS=cxfxcxdxbxegedabagacad
export SVN_EDITOR=vim
export EDITOR=vim

export LANG=ja_JP.UTF-8
alias ls="ls -G -v"
alias v='vim'
alias :q='exit'
alias g='noglob git'
alias r='rails'
alias o='gnome-open'

alias tmux-changekey='tmux set-option -ag prefix C-t'
alias tmux-revertkey='tmux set-option -ag prefix C-a'
alias tchdir='tmux set-option default-path $PWD'

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -v

#rvm
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

autoload colors; colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'

precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  [[ -n "$rvm_ruby_string" ]] && psvar[2]="[${rvm_ruby_string:-system}]"
}

PROMPT="%{${fg[green]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}%F{red}%2v%F{blue}%1v%f"

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

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
