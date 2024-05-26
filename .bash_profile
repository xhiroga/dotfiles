# sourced in LOGIN SHELLS

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
