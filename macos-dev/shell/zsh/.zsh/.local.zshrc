function ghq_peco() {
    REPO=$(ghq list -p | peco)
    if [ "$REPO" ]; then
        cd "$REPO" || return
    fi
    zle accept-line
}
zle -N ghq_peco
bindkey "^G" ghq_peco

function open_peco() {
    open "$(/bin/ls -a | peco)"
}
zle -N open_peco
bindkey "^U" open_peco

eval "$(anyenv init -)"
autoload bashcompinit && bashcompinit

complete -C '/usr/local/bin/aws_completer' aws
