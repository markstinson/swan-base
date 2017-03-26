# desktop shortcut
mkshortcut.exe -d 'Swan Console' -i /BlackSwan.ico -n 'Swan Console' -a '-i /BlackSwan.ico -' -D /bin/mintty
# start menu shortcut
mkshortcut.exe -d 'Swan Console' -i /BlackSwan.ico -n 'Swan/Swan Console' -a '-i /BlackSwan.ico -' -P /bin/mintty
# rm old uninstallable shortcut
rm -f "$(cygpath -P)/Swan Console.lnk"

