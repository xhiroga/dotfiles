# 対話式のbashを起動するときに実行される。

# ALIAS
alias code="/usr/local/bin/code"
alias bp="code ~/.bash_profile"
alias dev="cd ~/Dev"
alias idea="open -a /Applications/IntelliJ\ IDEA\ CE.app"
alias jp="jupyter notebook"
alias lower="tr '[A-Z]' '[a-z]'"
alias pj="cd ~/Dev/pj"
alias sbp="source ~/.bash_profile"
alias upper="tr '[a-z]' '[A-Z]'"
alias vi='vim -u ~/.vimrc -N'
alias ydcl="code ~/Dev/pj/ydcl/Yadocali"

# CONFIG
source ~/.git-prompt.sh
# export PS1='\h:\W \u\$'
# https://qiita.com/hmmrjn/items/60d2a64c9e5bf7c0fe60
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

# gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/hiroaki/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# kube
source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
