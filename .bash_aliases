################################################################################
# fzf section
################################################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

__fzf_history__() (
  local line
  shopt -u nocaseglob nocasematch
  line=$(
    HISTTIMEFORMAT= history | sort -nr | sort -uk2 | sort -n |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac --sync -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
    command grep '^ *[0-9]') &&
    if [[ $- =~ H ]]; then
      sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
    else
      sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
    fi
)

################################################################################
# env section
################################################################################
export PIPENV_VENV_IN_PROJECT=1
export PATH="$HOME/.local/bin:$PATH"

################################################################################
# alias section
################################################################################
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ag="ag --color-path '38;5;141' --color-match '38;5;235;48;5;227' --color-line-number '38;5;81' --pager=\"less -XFR\""
