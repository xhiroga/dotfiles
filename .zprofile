# sourced in LOGIN SHELLS, before `.zshrc`
# zsh公式ドキュメントには、`.zprofile`は`.zlogin`の代替だと記載されている。
# しかし、サードパーティのインストールの指示では`.zprofile`に言及していることが多いため、本dotfilesでも`.zprofile`を標準とする。
# see [Startup Files](https://zsh.sourceforge.io/Intro/intro_3.html)

## Editors

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

## Paths

source "$HOME/.path"

## Environment variables

source "$HOME/.rye/env"
