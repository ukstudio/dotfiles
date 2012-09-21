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

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -v

#rvm
#if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

autoload -U compinit
compinit

autoload colors; colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  #[[ -n "`$HOME/.rvm/bin/rvm-prompt`" ]] && psvar[2]="[`$HOME/.rvm/bin/rvm-prompt`]"
}

PROMPT="%{${fg[green]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}%F{red}%2v%3v%F{cyan}%1v%f"

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


# 自動でbundle exec
BUNDLED_COMMANDS=(cucumber heroku rackup rails rake rspec ruby shotgun spec spork)

## Functions

bundler-installed()
{
    which bundle > /dev/null 2>&1
}

within-bundled-project()
{
    local dir="$(pwd)"
    while [ "$(dirname $dir)" != "/" ]; do
        [ -f "$dir/Gemfile" ] && return
        dir="$(dirname $dir)"
    done
    false
}

run-with-bundler()
{
    local command="$1"
    shift
    if bundler-installed && within-bundled-project; then
        bundle exec $command "$@"
    else
        $command "$@"
    fi
}

## Main program

for CMD in $BUNDLED_COMMANDS; do
    alias $CMD="run-with-bundler $CMD"
done

[[ -s /home/ukstudio/.tmuxinator/scripts/tmuxinator ]] && source /home/ukstudio/.tmuxinator/scripts/tmuxinator

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
