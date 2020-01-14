export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH" # .pyenv should be head than other path to use pyenv
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$PATH:$HOME/.fastlane/bin"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/android-ndk-r13b"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"

export GIT_USER_NAME="Hiroaki Ogasawara"
export GIT_USER_EMAIL="hiroga1030@gmail.com"

export GOPATH="$HOME/.ghq"

# create .venv in project root, alternative to $HOME/.local/share/virtualenvs/
export PIPENV_VENV_IN_PROJECT=true
