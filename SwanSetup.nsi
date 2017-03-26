# swan.nsi
# Used to compile the installer
# the installer downloads the cygwin setup program
# to perform package installation

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
#SetShellVarContext all
InstallDir $%programdata%\Swan
# installer icon
!define MUI_ICON "Swan.ico"
# use directory select page, and install page
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

# do the actual setup
Section ""
 Call DoSetup
SectionEnd

Function DoSetup
  # download directory
  StrCpy $2 "$INSTDIR\var\cache\spm"
  CreateDirectory $2
  # executable filename (downloaded)
  StrCpy $0 "$2\setup-x86_64.exe"
  # download cygwin setup executable
  inetc::get /caption "Cygwin Setup Download" /canceltext "Cancel" "https://cygwin.com/setup-x86_64.exe" "$0" /end
  Pop $1 # return value = exit code, "OK" means OK
  StrCmp $1 OK success
    # download failed
    SetDetailsView show
    DetailPrint "download failed: $0"
    Abort
  success:
    # download success, execute cygwin setup with parameters (mirrors,
    # swan-base package, download & install locations, etc.)
    ExecWait '"$0" -vgBqOn -l "$2" -P swan-base-experimental -R "$INSTDIR" \
    -s http://sirius.starlig.ht/ \
    -s http://cygwin.mirror.constant.com/ \
    -K http://sirius.starlig.ht/sirius.gpg'
FunctionEnd

