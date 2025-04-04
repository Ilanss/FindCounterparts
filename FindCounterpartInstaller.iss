[Setup]
AppName=Find Counterpart Tool
AppVersion=1.0
DefaultDirName={autopf}\FindCounterparts
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=FindCounterpartInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "Find-Counterparts.ps1"; DestDir: "C:\Scripts"; Flags: ignoreversion
Source: "FindCounterparts.cmd"; DestDir: "C:\Scripts"; Flags: ignoreversion

[Icons]
Name: "{userappdata}\Microsoft\Windows\SendTo\Trouver les jpg"; Filename: "C:\Scripts\FindCounterparts.cmd"

[Code]
function InitializeSetup(): Boolean;
begin
  MsgBox('Cet installeur ajoute un raccourci dans le menu "Envoyer vers" pour trouver les jpg correspondant aux fichiers sélectionnés.', mbInformation, MB_OK);
  Result := True;
end;
