export TERM=xterm-256color
export LSCOLORS=cxfxcxdxbxegedabagacad


#alias gosh='rlwrap gosh'
alias ls="ls -G"
alias spec="spec -fs -c"
alias v='vim'
alias mysql='mysql5'

export PATH=/opt/local/ghc/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

export RSPEC=true

bindkey -v

autoload colors
colors
PROMPT="%{${fg[white]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[white]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"

function chpwd() { ls }

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
