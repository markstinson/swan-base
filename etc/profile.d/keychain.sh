#!/bin/bash

[ -z "$DESKTOP_SESSION" ] && [ "$TERM" != "cygwin" ] && [ "$SHLVL" = "1" ] || return

function _start_agent {
    if ! pgrep ssh-agent > /dev/null; then
	eval `ssh-agent` > /dev/null
    fi
}

# Source SSH settings, if applicable
if find "$HOME/.ssh/" -name 'id_*' 2>/dev/null >&2; then
    _start_agent
fi

