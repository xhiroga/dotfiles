# for interactive shells

# CONFIG
source ~/.git-prompt.sh

export PS1='\n\[\e[37;100m\] \D{%Y-%m-%d %H:%M:%S} \[\e[30;47m\] \W $(__git_ps1 "\[\e[30;102m\] %s \[\e[0;92m\]")\[\e[m\] \$ '
# Apple gitだと表示がおかしくなるので注意

# enable ctrl + s for searching command history
stty stop undef

source ~/.git-completion.bash

eval "$(anyenv init -)"

if [ -x $(command -v aws) ]; then
    complete -C \'$(which aws_completer)\' aws
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# gh
eval "$(gh completion -s bash)"

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
