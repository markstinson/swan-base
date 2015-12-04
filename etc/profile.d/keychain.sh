#!/bin/bash

[ -z "$DESKTOP_SESSION" ] && [ "$TERM" != "cygwin" ] || return

function _start_agent {
    ids=$(ls "$HOME/.ssh/id_*" | grep -v '\.pub')
    eval `keychain -q -Q --eval --ignore-missing --agents ssh $ids`
}

# Source SSH settings, if applicable
if find "$HOME/.ssh/" -name 'id_*' 2>/dev/null >&2; then
    _start_agent
fi

