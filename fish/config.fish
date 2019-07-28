# PATH
set -x PATH /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /Applications/Wireshark.app/Contents/MacOS
set -x PATH /usr/local/bin $PATH # for Homebrew
set -x PATH $HOME/.pyenv/shims $PATH # .pyenv should be head than other path to use pyenv
set -x PATH $PATH ~/.local/bin # for own tools
set -x ANDROID_HOME /Users/hiroaki/Library/Android/sdk
set -x ANDROID_NDK_HOME /Users/hiroaki/Library/Android/sdk/android-ndk-r13b
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home

# ALIAS
alias code="/usr/local/bin/code"
alias idea="open -a /Applications/IntelliJ\ IDEA\ CE.app"
alias jp="jupyter notebook"
alias lower="tr '[A-Z]' '[a-z]'"
alias upper="tr '[a-z]' '[A-Z]'"
alias vi='vim -u ~/.vimrc -N'

# for aws cli
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# fish
function fish_user_key_bindings
  bind \cr peco_select_history # Ctrl + r
  bind \x1b peco_z # Ctrl + [
end

set GHQ_SELECTOR peco
