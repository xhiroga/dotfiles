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
export PATH="$HOME/.pyenv/shims:$PATH"                              # .pyenv should be head than other path to use pyenv
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$PATH:$HOME/.fastlane/bin"
export PATH="/usr/local/opt/qt/bin:$PATH"                           # octave dependencies
export PATH="/usr/local/opt/texinfo/bin:$PATH"                      # octave dependencies

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
export GIT_USER_EMAIL="hiroga1030@gmail.com"

export GOPATH="$HOME/.ghq"

# octave dependencies
export LDFLAGS="-L/usr/local/opt/openblas/lib -L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/openblas/include -I/usr/local/opt/qt/include"
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig:/usr/local/opt/qt/lib/pkgconfig"

# create .venv in project root, alternative to $HOME/.local/share/virtualenvs/
export PIPENV_VENV_IN_PROJECT=true
