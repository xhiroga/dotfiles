# sourced in LOGIN SHELLS
# 元々は`.bash_profile`という名前で運用していたが、`rye`がデフォルトで`.profile`を作成するため、合わせる。

## Language

# for AWS CLI
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

## Paths

source "$HOME/.path"

## Source

if [ -f ~/.bashrc ]; then
  source $HOME/.bashrc
fi

## Environment variables

source "$HOME/.rye/env"
