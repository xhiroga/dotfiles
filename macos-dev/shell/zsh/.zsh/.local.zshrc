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
