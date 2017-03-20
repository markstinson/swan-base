#!/bin/bash

[ -z "$DESKTOP_SESSION" ] && [ "$TERM" != "cygwin" ] && [ "$SHLVL" = "1" ] || return

function _start_agent {
    # spawn ssh-agent
    eval `ssh-agent` >/dev/null
    trap "kill $SSH_AGENT_PID" EXIT
}

# Source SSH settings, if applicable
if find "$HOME/.ssh/" -name 'id_*' 2>/dev/null >&2; then
    _start_agent
fi

