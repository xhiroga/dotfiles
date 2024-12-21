# sourced in INTERACTIVE SHELLS.

## Aliases
source "$HOME/.aliases"

## Completion

# TODO...
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi
# .git-completion.bash

## Config

# enable ctrl + s for searching command history
stty stop undef

## Prompt

# TODO...
# source ~/.git-prompt.sh
# export PS1='\n\[\e[37;100m\] \D{%Y-%m-%d %H:%M:%S} \[\e[30;47m\] \W $(__git_ps1 "\[\e[30;102m\] %s \[\e[0;92m\]")\[\e[m\] \$ '
# Apple gitだと表示がおかしくなるので注意

command -v direnv &> /dev/null && eval "$(direnv hook bash)"
command -v fnm &> /dev/null && eval "$(fnm env --use-on-cd)"
