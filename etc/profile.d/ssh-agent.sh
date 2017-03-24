#!/bin/bash

[ -z "$DESKTOP_SESSION" ] && [ "$TERM" != "cygwin" ] && [ "$SHLVL" = "1" ] || return

function _start_agent {
    # spawn ssh-agent
    eval `ssh-agent` >/dev/null
}

# Source SSH settings, if applicable
if find "$HOME/.ssh/" -name 'id_*' 2>/dev/null >&2; then
  _start_agent
  if [ "$ZSH_VERSION" ]
  then
    zshexit() { eval `ssh-agent -k >/dev/null`; }  # zsh specific
  else
    trap 'eval `ssh-agent -k >/dev/null`' EXIT     # POSIX
  fi
fi

