#!/bin/bash

umask 022

export LANG=$(/usr/bin/locale -uU)
export LC_CTYPE=$LANG
export LC_NUMERIC=$LANG
export LC_TIME=$LANG
export LC_COLLATE="C"
export LC_MONETARY=$LANG
export LC_MESSAGES=$LANG
if [[ "$PATH" != *"/sbin"* ]]; then
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/libexec/busybox/bin:/usr/libexec/busybox/sbin:$PATH"
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# common env variables
export EDITOR="nano"
export BROWSER="windows-browser"
export LESS="-erFX"

eval "$(dircolors -b /etc/dircolors)" || eval "$(dircolors -b)"

[[ "$SHELL" != "/bin/bash" ]] && return 0;

# use /etc/inputrc as global
[ -e /etc/inputrc ] && bind -f /etc/inputrc
[ -e ~/.inputrc ] && bind -f ~/.inputrc

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# force historical multi-line commands to one line
shopt -s cmdhist
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=2048
export HISTFILESIZE=2048

# truncate working directory in prompts
export PROMPT_DIRTRIM=3

# turn off flow-control
stty -ixon

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

