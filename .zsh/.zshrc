#
# Executes commands at the start of an interactive session.
#

source "$HOME/.aliases"

source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/config.zsh"
source "$ZDOTDIR/keybindings.zsh"
source "$ZDOTDIR/prompt.zsh"

eval "$(anyenv init -)"

eval "$(fnm env --use-on-cd)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
