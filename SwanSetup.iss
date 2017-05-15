
[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{0E87A443-2490-41E3-B92A-502F9F7A4A20}
AppName=Swan
AppVersion=1.0
;AppVerName=Swan 1.0
AppPublisher=Starlight
AppPublisherURL=http://www.starlig.ht
AppSupportURL=https://github.com/starlight/swan-desktop/issues
AppUpdatesURL=http://www.starlig.ht
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={%PROGRAMDATA|C:\ProgramData}\Swan
DefaultGroupName=Swan
LicenseFile=LICENSE
OutputBaseFilename=SwanSetup
SetupIconFile=Swan.ico
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest
ExtraDiskSpaceRequired=1536837509
OutputDir=.
UninstallDisplayIcon={app}\Swan.ico
WizardImageFile=SwanSetup.bmp
WizardSmallImageFile=Swan.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,Swan}"; Filename: "http://www.starlig.ht"        
Name: "{group}\{cm:UninstallProgram,Swan}"; Filename: "{uninstallexe}"; IconFilename: "{app}\BlackSwan.ico"

#include <idp.iss>
[Code]
procedure InitializeWizard();
begin
 // download the cygwin installer
 idpAddFileComp('http://cygwin.com/setup-x86_64.exe',expandconstant('{tmp}\setup-x86_64.exe'),'');
 idpDownloadAfter(wpReady);
end;

[Run]
Filename: "{tmp}\setup-x86_64.exe"; WorkingDir: "{tmp}"; Parameters: "-vgBqOn -P swan-desktop -R ""{app}"" -s ""http://sirius.starlig.ht/"" -s ""http://cygwin.mirror.constant.com/"" -K ""http://sirius.starlig.ht/sirius.gpg"""; Flags: waituntilterminated hidewizard runascurrentuser

[UninstallDelete]
Type: filesandordirs; Name: "{group}"
Type: files; Name: "{userdesktop}\Swan Console.lnk"
Type: files; Name: "{userdesktop}\Swan Xfce4 Desktop.lnk"
Type: filesandordirs; Name: "{app}"
