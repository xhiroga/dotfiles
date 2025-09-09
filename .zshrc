# sourced in INTERACTIVE SHELLS.
# see [Startup Files](https://zsh.sourceforge.io/Intro/intro_3.html)

bindkey -e

## Aliases
source "$HOME/.aliases"

## [Completion](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit

  # You may also need to force rebuild `zcompdump`:
  rm -f ~/.zcompdump; compinit

  # Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting
  # to load these completions, you may need to run these commands:
  chmod go-w "$(brew --prefix)/share"
  chmod -R go-w "$(brew --prefix)/share/zsh"
else
  autoload -Uz compinit
  compinit
fi

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*:default' menu select

# Requires zsh-completions
zstyle ':completion:*:make:*' tag-order 'targets'
zstyle ':completion:*:make:*:targets' command 'grep -E "^[a-zA-Z0-9_-]+:" *.mk Makefile 2>/dev/null | sed "s/:.*//"'

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
setopt PROMPT_SUBST              # プロンプト内でコマンド置換を展開する。

## Environment variables
# 環境変数の設定は`.path`に記載して`.zprofile`から呼ぶことを基本としているが、公式ドキュメントで`.zshrc`を用いるように指示があった場合はそれに従う。
command -v direnv &> /dev/null && eval "$(direnv hook zsh)"
command -v fnm &> /dev/null && eval "$(fnm env --use-on-cd)"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/linuxbrew/.linuxbrew/Cellar/micromamba/2.3.2/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/hiroga/mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

## [Prompt](https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html)
function git_branch_prompt() {
  local branch=$(git branch --show-current 2>/dev/null)
  [[ -n "$branch" ]] && echo " $branch "
}

if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
  FG_BLACK='%F{233}'
  FG_WHITE='%F{255}'
  BG_MOSSGREEN='%K{22}'
  BG_TURQUOISE='%K{21}'
  BG_WHITE='%K{254}'
else
  FG_BLACK='%F{black}'
  FG_WHITE='%F{white}'
  BG_MOSSGREEN='%K{green}'
  BG_TURQUOISE='%K{cyan}'
  BG_WHITE='%K{white}'
fi

PROMPT_RESET_COLOR='%f%k'
PROMPT_USERNAME='%n'
PROMPT_HOST='%m'
PROMPT_CWD='%1~'
PROMPT_PRIVILEGED_STATE='%#'

# コマンド置換がプロンプト表示時に評価されるよう、シングルクォートを用いる必要がある。
PROMPT=''
PROMPT+='${BG_MOSSGREEN}${FG_WHITE} ${PROMPT_USERNAME}@${PROMPT_HOST} ${PROMPT_RESET_COLOR}'
PROMPT+='${BG_WHITE}${FG_BLACK} ${PROMPT_CWD} ${PROMPT_RESET_COLOR}'
PROMPT+='${BG_TURQUOISE}${FG_WHITE}$(git_branch_prompt)${PROMPT_RESET_COLOR}'
PROMPT+=' $PROMPT_PRIVILEGED_STATE '
