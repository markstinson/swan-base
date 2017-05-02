# Used to compile the installer
# the installer downloads the cygwin setup program
# to perform package installation
!define UninstName "Uninstall"
# use modern gui
!include MUI2.nsh
# do NOT request admin privs
RequestExecutionLevel user

# name
Name "Swan"
VIProductVersion 1.0.0.0
VIAddVersionKey /LANG=0 "ProductName" "Swan"
VIAddVersionKey /LANG=0 "Comments" "GNU/Cygwin Xfce Desktop"
VIAddVersionKey /LANG=0 "CompanyName" "Starlight"
VIAddVersionKey /LANG=0 "LegalTrademarks" "MIT License"
VIAddVersionKey /LANG=0 "LegalCopyright" "© Starlight"
# output file
SetCompressor lzma
OutFile "SwanSetup.exe"
# default install directory
InstallDir $%programdata%\Swan
# installer icon
!define MUI_ICON "Swan.ico"
!define MUI_UNICON "BlackSwan.ico"
# use directory select page, and install page
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
;Uninstaller pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# do the actual setup
Section ""
 Call DoSetup
SectionEnd

Function DoSetup
  # download directory
  StrCpy $1 "$INSTDIR\var\cache\spm"
  # executable URL
  StrCpy $2 "https://cygwin.com/setup-x86_64.exe"
  # executable filename (downloaded)
  StrCpy $3 "$1\setup-x86_64.exe"
  # download cygwin setup executable
  CreateDirectory $1
  inetc::get /caption "Cygwin Setup Download" /canceltext "Cancel" "$2" "$3" /end
  Pop $0 # return value = exit code, "OK" means OK
  StrCmp $0 OK success
    # download not OK
    SetDetailsView show
    DetailPrint "Download error! $0: $2"
    Abort
  success:
    # download OK
    WriteUninstaller "$INSTDIR\UninstallSwan.exe"
    CreateDirectory "$SMPROGRAMS\Swan"
    CreateShortcut "$SMPROGRAMS\Swan\Uninstall Swan.lnk" "$INSTDIR\UninstallSwan.exe"
    # download success, execute cygwin setup with parameters (mirrors,
    # swan-base package, download & install locations, etc.)
    ExecWait '"$2" -vgBqOn -l "$1" -P swan-desktop -R "$INSTDIR" \
    -s http://sirius.starlig.ht/ \
    -s http://cygwin.mirror.constant.com/ \
    -K http://sirius.starlig.ht/sirius.gpg'
FunctionEnd

Section "Uninstall"
    RMDir /r "$INSTDIR"
    RMDir /r "$SMPROGRAMS\Swan"
    RMDir /r "$SMPROGRAMS\Cygwin-X"
    Delete "$DESKTOP\Swan Console.lnk"
    Delete "$DESKTOP\Swan Xfce4 Desktop.lnk"
SectionEnd
