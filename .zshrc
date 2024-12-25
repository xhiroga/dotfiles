# sourced in INTERACTIVE SHELLS.
# see [Startup Files](https://zsh.sourceforge.io/Intro/intro_3.html)

bindkey -e

## Aliases
source "$HOME/.aliases"

## [Completion](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)

autoload -Uz compinit && compinit

command -v uv >/dev/null 2>&1 && eval "$(uv generate-shell-completion zsh)"
command -v uvx >/dev/null 2>&1 && eval "$(uvx --generate-shell-completion zsh)"

## [Options](https://zsh.sourceforge.io/Doc/Release/Options.html)
HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zsh_history}"  # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.

setopt APPEND_HISTORY            # Not overwrite the history file.
setopt INC_APPEND_HISTORY        # Add commands to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # 履歴内の重複するコマンドは最新だけを残す。`HIST_IGNORE_DUPS`(連続する同じコマンドは最初のみ記録)や`HIST_EXPIRE_DUPS_FIRST`と共存させることも可能だが、ややこしいので避ける。
setopt HIST_IGNORE_SPACE         # スペースから始まるコマンドを記録しない。クレデンシャルなどを入力する際に便利。
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.

## Environment variables
# 環境変数の設定は`.path`に記載して`.zprofile`から呼ぶことを基本としているが、公式ドキュメントで`.zshrc`を用いるように指示があった場合はそれに従う。

command -v direnv &> /dev/null && eval "$(direnv hook zsh)"
command -v fnm &> /dev/null && eval "$(fnm env --use-on-cd)"

## Prompt
# 1) コマンド実行前後での時間計測
typeset -F SECONDS_START=0

preexec() {
  SECONDS_START=$EPOCHREALTIME
}

precmd() {
  if [[ -n "$SECONDS_START" ]]; then
    local now=$EPOCHREALTIME
    local elapsed=$(printf "%.2f" "$(bc <<< "$now - $SECONDS_START")")
    LAST_CMD_DURATION="$elapsed s"
  else
    LAST_CMD_DURATION=""
  fi
}

# 2) Git ブランチ取得用の簡易関数
function git_current_branch() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  echo "$branch"
}

# 3) Git ブランチをプロンプトに表示するヘルパー
function git_branch_prompt() {
  local branch=$(git_current_branch)
  [[ -n "$branch" ]] && echo " %F{green}[$branch]%f"
}

# 4) PROMPT の設定
PROMPT=''
PROMPT+='%K{blue}%F{white}'   # 青背景 + 白文字
PROMPT+=' %n@%m '            # 'ユーザ@ホスト'
PROMPT+='%k%f '              # 背景色/文字色解除
PROMPT+='%F{cyan}%~%f'       # カレントディレクトリ (シアン)
PROMPT+='$(git_branch_prompt)'  # gitブランチ (あれば)
PROMPT+=' %F{red}($LAST_CMD_DURATION)%f'  # 実行時間 (赤)
PROMPT+='\n%# '              # 改行後、%# (rootなら#、一般なら%)
