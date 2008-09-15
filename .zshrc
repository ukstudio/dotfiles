export TERM=xterm-256color
export LSCOLORS=cxfxcxdxbxegedabagacad


#alias gosh='rlwrap gosh'
alias ls="ls -G"
alias spec="spec -fs -c"
alias v='vim'

export PATH=/opt/local/ghc/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
