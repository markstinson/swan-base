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
InstallDir C:\.swan-x86_64
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
  NSISdl::download "https://cygwin.com/setup-x86_64.exe" $0
  # check for successful download
  Pop $1
  StrCmp $1 success success
    # download failed
    SetDetailsView show
    DetailPrint "download failed: $0"
    Abort
  success:
    # download success, execute cygwin setup with parameters (mirrors,
    # swan-base package, download & install locations, etc.)
    ExecWait '"$0" -vgBqOdN -l "$2" -P swan-base -R "$INSTDIR" \
    -s http://sirius.starlig.ht/ \
    -s http://cygwin.mirror.constant.com/ \
    -s http://sourceware.mirrors.tds.net/pub/sourceware.org/cygwinports/ \
    -K http://sirius.starlig.ht/sirius.gpg \
    -K http://cygwinports.org/ports.gpg'

FunctionEnd

