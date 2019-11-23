#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

source ~/.git-prompt.sh
autoload -U colors && colors
PROMPT="
${fg[black]}${bg[green]} %* ${reset_color}${fg[black]}${bg[white]} %1d ${reset_color}${fg[black]}${bg[cyan]} $(__git_ps1 %s) ${reset_color} $ "

function ghq_peco() {
    cd $(ghq list -p | peco)
    zle accept-line
}
zle -N ghq_peco
bindkey "^G" ghq_peco

function open_peco() {
    open $(ls -a | peco)
}
zle -N open_peco
bindkey "^U" open_peco
