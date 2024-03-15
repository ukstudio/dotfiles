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

autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=1

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yuki-akamatsu/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(starship init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit ice wait='1'; zinit light zdharma-continuum/history-search-multi-word
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
