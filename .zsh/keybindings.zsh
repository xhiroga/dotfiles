bindkey -e

bindkey "^R" history-incremental-search-backward

function ghq_peco() {
    REPO=$(ghq list -p | peco)
    if [ "$REPO" ]; then
        cd "$REPO" || return
    fi
    zle accept-line
}
zle -N ghq_peco
bindkey "^g^g" ghq_peco

# Inspired by [GitHub謹製のghコマンドとpecoを組み合わせて、高速にPull Requestのブランチにチェックアウトする。 \- 文字っぽいの。](https://fromatom.hatenablog.com/entry/2020/03/31/135410)
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

## Regerences
#
# - [zsh: 18 Zsh Line Editor](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html)
