#!/bin/bash

[ -z "$DESKTOP_SESSION" ] && [ "$TERM" != "cygwin" ] && [ "$SHLVL" = "1" ] || return

function _start_agent {
    SSH_ENV="$HOME/.ssh/.env"
    if ! pgrep ssh-agent >/dev/null; then
    	# spawn ssh-agent
        ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
        chmod 600 "$SSH_ENV"
    fi
    if [ -e "$SSH_ENV" ]; then
        . "$SSH_ENV" > /dev/null
    fi
}

# Source SSH settings, if applicable
if find "$HOME/.ssh/" -name 'id_*' 2>/dev/null >&2; then
    _start_agent
fi

