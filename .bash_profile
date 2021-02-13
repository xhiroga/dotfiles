# for login shells

# for aws cli
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source "$HOME/.profile"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
