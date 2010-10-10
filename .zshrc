export TERM=xterm-256color
export LSCOLORS=cxfxcxdxbxegedabagacad
export SVN_EDITOR=vim
export EDITOR=vim

export LANG=ja_JP.UTF-8
alias ls="ls -G -v"
alias v='vim'
alias :q='exit'
alias g='git'
alias r='rails'


# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

export RSPEC=true
export AUTOFEATURE=true

bindkey -v

#rvm
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

autoload colors
colors
PROMPT="%{${fg[white]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[white]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}%F{red}[${rvm_ruby_string:-system}]%f"

function chpwd() { ls }

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}

#コマンドラインバッファスタックをvimモードで
setopt noflowcontrol
bindkey '^Q' push-line-or-edit

source ~/.zshrc.local
