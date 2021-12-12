setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.

HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zsh_history}"  # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.

## Refernces
#
# - [prezto/modules at 1ff9421f7be746dd18304d264db0adff3136a9e8 · sorin\-ionescu/prezto](https://github.com/sorin-ionescu/prezto/tree/1ff9421f7be746dd18304d264db0adff3136a9e8/modules)
# - [dotfiles/config\.zsh at master · holman/dotfiles](https://github.com/holman/dotfiles/blob/master/zsh/config.zsh)
