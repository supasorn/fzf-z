#!/usr/bin/env zsh
#
# Based on https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
# (MIT licensed, as of 2016-05-05).

FZFZ_SCRIPT_PATH=${0:a:h}

fzfz-file-widget() {
    local selected accept=1
    selected=( $($FZFZ_SCRIPT_PATH/fzfz) )
    if [[ $selected[1] == ctrl-e ]]; then
      accept=0
      shift selected
    fi
    LBUFFER="${LBUFFER}$selected"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    if [[ $ret -eq 0 && -n "$BUFFER" && $accept = 1 ]]; then
        zle .accept-line
    fi
    return $ret
}

zle -N fzfz-file-widget
bindkey -M viins -r '^G'
bindkey -M vicmd -r '^G'
bindkey -M emacs -r '^G'

bindkey -M viins '^G' fzfz-file-widget
bindkey -M vicmd '^G' fzfz-file-widget
bindkey -M emacs '^G' fzfz-file-widget
