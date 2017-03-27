#!/bin/bash

[ -z "$SKEL_FINISHED" ] || return

# use windows shortcuts as symlinks
export CYGWIN="${CYGWIN}${CYGWIN:+ }winsymlinks"
export PATH="$PATH:/usr/libexec/busybox/bin:/usr/libexec/busybox/sbin"

# mount AppData on $HOME
if ! mount | grep -i "home" >/dev/null; then
    mkdir -p "$(cygpath $APPDATA)/Swan"
    mount -fo user "${APPDATA}\\Swan" "$HOME"
fi


# ensure skeleton files are updated for new packages
for bone in `find /etc/skel -type f -printf "%P\n"`; do
    if [ ! -e $HOME/$bone ]; then
        mkdir -p `dirname $HOME/$bone`
        cp /etc/skel/$bone $HOME/$bone
    fi
done
unset bone

export SKEL_FINISHED=1
