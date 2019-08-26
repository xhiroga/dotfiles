# ログイン時に毎回実行される。

# PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH" # .pyenv should be head than other path to use pyenv
export PATH="~/.local/bin:$PATH"
export ANDROID_HOME="/Users/hiroga/Library/Android/sdk"
export ANDROID_NDK_HOME="/Users/hiroga/Library/Android/sdk/android-ndk-r13b"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home"
# for aws cli
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(rbenv init -)"

source ~/.bashrc
if [ -e ~/.localprofile ];then
    source ~/.localprofile
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/hiroga/.sdkman"
[[ -s "/Users/hiroga/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hiroga/.sdkman/bin/sdkman-init.sh"
