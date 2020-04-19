# for interactive shells

source "$HOME/.aliases"

# CONFIG
source ~/.git-prompt.sh

export PS1='\n\[\e[37;100m\] \D{%Y-%m-%d %H:%M:%S} \[\e[30;47m\] \W $(__git_ps1 "\[\e[30;102m\] %s \[\e[0;92m\]")\[\e[m\] \$ '
# Apple gitだと表示がおかしくなるので注意

# enable ctrl + s for searching command history
stty stop undef

# git
source ~/.git-completion.bash
if [ -x $(command -v aws) ]; then
    complete -C \'$(which aws_completer)\' aws
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

source "$HOME/.local.bashrc"
