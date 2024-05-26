# sourced in INTERACTIVE SHELLS.
# see [Startup Files](https://zsh.sourceforge.io/Intro/intro_3.html)

## Aliases
source "$HOME/.aliases"

## Completion
# - [zsh: 20 Completion System](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)

autoload -Uz compinit && compinit

## Config
# - [dotfiles/config\.zsh at master · holman/dotfiles](https://github.com/holman/dotfiles/blob/master/zsh/config.zsh)

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.

HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zsh_history}"  # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.

## Environment varialbes
# 環境変数の設定は`.path`に記載して`.zprofile`から呼ぶことを基本としているが、公式ドキュメントで`.zshrc`を用いるように指示があった場合はそれに従う。

eval "$(fnm env --use-on-cd)"
