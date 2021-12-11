#
# Author: @xhiroga
#
# Based on:
#   https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_steeef_setup
#

function prompt_steeef_precmd {
  # Check for untracked files or updated submodules since vcs_info does not.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    branch_format=" ${_prompt_front_colors[7]}%b%f%u%c${_prompt_front_colors[3]}●%f "
  else
    branch_format=" ${_prompt_front_colors[7]}%b%f%u%c "
  fi

  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"

  vcs_info 'prompt'

  if (( $+functions[python-info] )); then
    python-info
  fi
}

function prompt_steeef_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent sp subst)

  # Load required functions.
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  # Add hook for calling vcs_info before each command.
  add-zsh-hook precmd prompt_steeef_precmd

  # Tell prezto we can manage this prompt
  zstyle ':prezto:module:prompt' managed 'yes'

  # Use extended color pallete if available.
  if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    _prompt_front_colors=(
      "%F{81}"  # Turquoise
      "%F{166}" # Orange
      "%F{135}" # Purple
      "%F{161}" # Hotpink
      "%F{118}" # Limegreen
      "%F{233}" # Black
      "%F{254}" # White
    )
  else
    _prompt_front_colors=(
      "%F{cyan}"
      "%F{yellow}"
      "%F{magenta}"
      "%F{red}"
      "%F{green}"
      "%F{black}"
      "%F{white}"
    )
  fi

  if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    _prompt_back_colors=(
      "%K{21}" # Turquoise
      "%K{22}" # Mossgreen
      "%K{233}" # Black
      "%K{254}" # White
    )
  else
    _prompt_back_colors=(
      "%K{cyan}"
      "%K{green}"
      "%K{black}"
      "%K{white}"
    )
  fi

  # Formats:
  #   %b - branchname
  #   %u - unstagedstr (see below)
  #   %c - stagedstr (see below)
  #   %a - action (e.g. rebase-i)
  #   %R - repository path
  #   %S - path in the repository
  local branch_format="(${_prompt_front_colors[7]}%b%f%u%c)"
  local action_format="(${_prompt_front_colors[5]}%a%f)"
  local unstaged_format="${_prompt_front_colors[2]}●%f"
  local staged_format="${_prompt_front_colors[5]}●%f"

  # Set editor-info parameters.
  zstyle ':prezto:module:editor:info:keymap:primary' format '$'

  # Set vcs_info parameters.
  zstyle ':vcs_info:*' enable bzr git hg svn
  zstyle ':vcs_info:*:prompt:*' check-for-changes true
  zstyle ':vcs_info:*:prompt:*' unstagedstr "${unstaged_format}"
  zstyle ':vcs_info:*:prompt:*' stagedstr "${staged_format}"
  zstyle ':vcs_info:*:prompt:*' actionformats "${branch_format}${action_format}"
  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"
  zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

  # Set python-info parameters.
  zstyle ':prezto:module:python:info:virtualenv' format '(%v)'

  # Define prompts.
  PROMPT="
${_prompt_front_colors[7]}${_prompt_back_colors[2]} %* %f%k${_prompt_front_colors[6]}${_prompt_back_colors[4]} %1d %f%k${_prompt_back_colors[1]}"'${vcs_info_msg_0_}'"%f%k
"'$python_info[virtualenv]${editor_info[keymap]} '
  RPROMPT=''
}

function prompt_steeef_preview {
  local +h PROMPT=''
  local +h RPROMPT=''
  local +h SPROMPT=''

  editor-info 2> /dev/null
  prompt_preview_theme 'steeef'
}

prompt_steeef_setup "$@"
# vim: ft=zsh
