export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnutls/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-indent/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$PATH:$HOME/.fastlane/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/gawk/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/gnutls/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/gnu-indent/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/opt/gnu-getopt/share/man:$MANPATH"
export MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/android-ndk-r13b"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"

export GIT_USER_NAME="Hiroaki Ogasawara"
export GIT_USER_EMAIL="13391129+xhiroga@users.noreply.github.com"

export GOPATH="$HOME/.ghq"
export PATH="$GOPATH/bin:$PATH"

# create .venv in project root, alternative to $HOME/.local/share/virtualenvs/
export PIPENV_VENV_IN_PROJECT=1

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

for profile in ~/.profiles/*
do
    source "$profile"
done
