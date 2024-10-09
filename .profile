# sourced in LOGIN SHELLS
# 元々は`.bash_profile`という名前で運用していたが、`rye`がデフォルトで`.profile`を作成するため、合わせる。

## Paths

source "$HOME/.path"

## Source

if [ -f ~/.bashrc ]; then
  source $HOME/.bashrc
fi

## Environment variables

source "$HOME/.rye/env"
