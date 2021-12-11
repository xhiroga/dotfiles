#
# Executes commands at the start of an interactive session.
#

source "$HOME/.aliases"

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Customize to your needs...
# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

source "$HOME/.git-prompt.sh"
autoload -U colors && colors

function ghq_peco() {
    REPO=$(ghq list -p | peco)
    if [ "$REPO" ]; then
        cd "$REPO" || return
    fi
    zle accept-line
}
zle -N ghq_peco
bindkey "^g^g" ghq_peco

# https://fromatom.hatenablog.com/entry/2020/03/31/135410
function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-checkout-pull-request
bindkey "^g^p" peco-checkout-pull-request

function git_switch_peco() {
    BRANCH=$(git branch --format "%(refname:short)" | peco)
    if [ "$BRANCH" ]; then
        git switch "$BRANCH" || return
    fi
    zle accept-line
}
zle -N git_switch_peco
bindkey "^g^s" git_switch_peco

function open_peco() {
    open "$(/bin/ls -a | peco)"
}
zle -N open_peco
bindkey "^U" open_peco

eval "$(anyenv init -)"
autoload bashcompinit && bashcompinit

complete -C '/usr/local/bin/aws_completer' aws

# gh
eval "$(gh completion -s zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -r /Users/hiroga/.opam/opam-init/init.zsh && . /Users/hiroga/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

source $ZDOTDIR/prompt.zsh
