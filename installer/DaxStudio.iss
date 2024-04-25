; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "DAX Studio"
#define myAppMajor
#define myAppMinor
#define myAppRevision
#define myAppBuild
#define MyAppVersionFull GetVersionComponents('..\bin\Release\DaxStudio.exe', myAppMajor, myAppMinor, myAppRevision, myAppBuild)
#define MyAppVersion GetVersionNumbersString('..\bin\Release\DaxStudio.exe')
#define MyAppPublisher "DAX Studio"
#define MyAppURL "https://daxstudio.org"
#define MyAppExeName "DaxStudio.exe"
; Calculated Constants
#define MyAppFileVersion StringChange(MyAppVersion, ".", "_")
#define use_dotnetfx471
;#define use_sql2012sp1amo
;#define use_sql2012sp1adomdclient
;#define use_sql2016amo
;#define use_sql2016adomdclient

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{CE2CEA93-9DD3-4724-8FE3-FCBF0A0915C1}

#ifdef Preview
AppName={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision} ({#Preview})
#else
AppName={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision}
#endif

AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ArchitecturesAllowed=x86 x64 arm64
ArchitecturesInstallIn64BitMode=x64
ChangesAssociations=yes
ChangesEnvironment=yes
Compression=lzma
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableDirPage=auto
DisableProgramGroupPage=auto
InfoBeforeFile=infobefore.txt
LicenseFile=..\LICENSE
OutputBaseFilename=DaxStudio_{#myAppMajor}_{#myAppMinor}_{#myAppRevision}_setup
OutputDir=..\package
PrivilegesRequiredOverridesAllowed=dialog commandline
SetupIconFile=DaxStudio.ico
SolidCompression=yes
UninstallDisplayIcon={app}\daxstudio.exe
UseSetupLdr=Yes
VersionInfoVersion={#MyAppVersion}
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoCompany={#MyAppURL}
WizardImageFile=WizardImageFile.bmp
WizardSmallImageFile=WizardSmallImageFile.bmp


[Messages]
; define wizard title and tray status msg
; both are normally defined in innosetup's default.isl (install folder)
#ifdef Preview
SetupWindowTitle={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision} {#Preview}
#else
SetupWindowTitle={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision}
#endif

[Languages]
;Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"
;Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "blockallinternetaccess"; Description: "[NOT RECOMMENDED] Blocks all features requiring internet access including version checks, DAX formatting and crash reporting. This setting requires a re-install to change."; GroupDescription: "Privacy"; Flags: unchecked; Check: IsAdmin
Name: "modifypath"; Description: "&Add application directory to your environmental path";

[Files]
Source: "..\bin\Release\DaxStudio.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: Core
Source: "..\bin\Release\DaxStudio.vsto"; DestDir: "{app}\bin"; Flags: ignoreversion; Components: Core
Source: "..\bin\Release\DaxStudio.dll"; DestDir: "{app}\bin"; Flags: ignoreversion; Components: Core
Source: "..\bin\Release\DaxStudio.dll.manifest"; DestDir: "{app}\bin"; Flags: ignoreversion; Components: Core
Source: "..\bin\Release\*"; DestDir: "{app}"; Flags: replacesameversion recursesubdirs createallsubdirs ignoreversion; Components: Core; Excludes: "*.pdb,*.xml,DaxStudio.vshost.*,*.config,DaxStudio.dll,DaxStudio.exe,DaxStudio.vsto,daxstudio.pbitool.json;*.portable;Microsoft.Excel.*.dll"

; PBI Desktop integration (If installing in ALL USERS mode)
Source: "..\bin\Release\daxstudio.pbitool.json"; DestDir: "{commoncf32}\Microsoft Shared\Power BI Desktop\External Tools"; Components: Core; Check: IsAdminInstallMode;

;Standalone configs
Source: "..\bin\Release\DaxStudio.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Components: Core;
Source: "..\bin\Release\dscmd.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Components: Core;
;Excel Addin configs
Source: "..\bin\Release\DaxStudio.dll.xl2010.config"; DestDir: "{app}\bin"; DestName: "DaxStudio.dll.config"; Flags: ignoreversion; Components: Core; Check: IsExcel2010Installed
Source: "..\bin\Release\DaxStudio.dll.config"; DestDir: "{app}\bin"; Flags: ignoreversion; Components: Core; Check: Not IsExcel2010Installed
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

; TODO - ngen DaxStudio
;Filename: {win}\Microsoft.NET\Framework64\v4.0.30319\ngen.exe Parameters: "install ""{app}\{#MyAppExeName}"""; StatusMsg: Optimizing performance for your system ...; Flags: runhidden; Check: CheckFramework;

;[UninstallRun
;Filename: {win}\Microsoft.NET\Framework64\v4.0.30319\ngen.exe Parameters: "install ""{app}\{#MyAppExeName}"""; StatusMsg: Removing native images and dependencies ...; Flags: runhidden; Check: CheckFramework;

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Filename: "certutil.exe"; Parameters: "-addstore ""TrustedPublisher"" {app}\bin\DaxStudio.cer"; StatusMsg: "Adding trusted publisher..."; Components: Excel
;Filename: "eventcreate"; Parameters: "/ID 1 /L APPLICATION /T INFORMATION  /SO DaxStudio /D ""DaxStudio Installed"""; WorkingDir: "{sys}"; Flags: runascurrentuser runhidden; StatusMsg: "Registering DaxStudio Eventlog Source"; Components: Core
;Filename: {code:GetV4NetDir}ngen.exe; Parameters: "install ""{app}\{#MyAppExeName}"""; StatusMsg: Optimizing performance for your system ...; Flags: runhidden;
;Check: CheckFramework;

#include "scripts\products.iss"
#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"
#include "scripts\products\dotnetfxversion.iss"
#include "scripts\products\excelversion.iss"
#include "scripts\products\dotnetfx47.iss"
#include "scripts\products\dotnetassembly.iss"


[UninstallRun]
Filename: {code:GetV4NetDir}ngen.exe; Parameters: "uninstall ""{app}\{#MyAppExeName}""";  StatusMsg: Removing native images and dependencies ...; Flags: runhidden;  RunOnceId: "DaxStudio-ngen";
;Check: CheckFramework;

[Types]
Name: "full"; Description: "Full Install"
Name: "standalone"; Description: "DaxStudio Core"
Name: "custom"; Description: "Custom"; Flags: iscustom

[Registry]
Root: "HKA"; Subkey: "Software\DaxStudio"; Flags: uninsdeletekey; Components: Core; Permissions: users-read
Root: "HKA"; Subkey: "Software\DaxStudio"; ValueType: string; ValueName: "ExcelBitness"; ValueData: "64Bit"; Flags: uninsdeletekey; Components: Core; Permissions: users-read; Check: Is64BitExcelFromRegisteredExe
Root: "HKA"; Subkey: "Software\DaxStudio"; ValueType: string; ValueName: "ExcelBitness"; ValueData: "32Bit"; Flags: uninsdeletekey; Components: Core; Permissions: users-read; Check: Is32BitExcelFromRegisteredExe
Root: "HKA"; Subkey: "Software\DaxStudio"; ValueType: dword; ValueName: "BlockAllInternetAccess"; ValueData: 1; Flags: uninsdeletekey; Tasks: blockallinternetaccess

;Excel x86 Addin Keys - All Users
Root: "HKA32"; Subkey: "Software\DaxStudio"; ValueType: string; ValueName: "Path"; ValueData: """{app}\{#MyAppExeName}"""; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKA32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Description"; ValueData: "DAX Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKA32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "FriendlyName"; ValueData: "DAX Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKA32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Manifest"; ValueData: "{code:SwapSlashes|file:///{app}\bin\DaxStudio.vsto|vstolocal}"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKA32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: dword; ValueName: "LoadBehavior"; ValueData: "3"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
;Excel x64 Addin keys - All Users
Root: "HKA64"; Subkey: "Software\DaxStudio"; ValueType: string; ValueName: "Path"; ValueData: """{app}\{#MyAppExeName}"""; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKA64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Description"; ValueData: "DAX Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKA64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "FriendlyName"; ValueData: "DAX Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKA64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Manifest"; ValueData: "{code:SwapSlashes|file:///{app}\bin\DaxStudio.vsto|vstolocal}"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKA64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: dword; ValueName: "LoadBehavior"; ValueData: "3"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe

;add file association for .dax files
Root: "HKA"; Subkey: "Software\Classes\.dax"; ValueType: string; ValueData: "DAX file"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\DAX file"; ValueType: string; ValueData: "DAX Query File"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\DAX file\Shell\Open\Command"; ValueType: string; ValueData: """{app}\DaxStudio.exe"" -file ""%1"""; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\DAX file\DefaultIcon"; ValueType: string; ValueData: "{app}\bin\DaxStudio.FileIcons.dll,1"; Flags: uninsdeletevalue

;add file association for .daxx files
Root: "HKA"; Subkey: "Software\Classes\.daxx"; ValueType: string; ValueData: "DAXX file"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\DAXX file"; ValueType: string; ValueData: "DAXX Query File"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\DAXX file\Shell\Open\Command"; ValueType: string; ValueData: """{app}\DaxStudio.exe"" -file ""%1"""; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\DAXX file\DefaultIcon"; ValueType: string; ValueData: "{app}\bin\DaxStudio.FileIcons.dll,1"; Flags: uninsdeletevalue

;add file association for .vpax files
Root: "HKA"; Subkey: "Software\Classes\.vpax"; ValueType: string; ValueData: "VPAX file"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\VPAX file"; ValueType: string; ValueData: "Vertipaq Analyzer File"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\VPAX file\Shell\Open\Command"; ValueType: string; ValueData: """{app}\DaxStudio.exe"" -file ""%1"""; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\VPAX file\DefaultIcon"; ValueType: string; ValueData: "{app}\bin\DaxStudio.FileIcons.dll,2"; Flags: uninsdeletevalue

;add uri keys
Root: "HKA"; Subkey: "Software\Classes\daxstudio"; ValueType: string; ValueData: "URL:daxstudio Protocol"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\daxstudio"; ValueType: string; ValueName: "URL Protocol"; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\daxstudio\DefaultIcon"; ValueType: string; ValueData: "{app}\DaxStudio.exe,0" ; Flags: uninsdeletekey
Root: "HKA"; Subkey: "Software\Classes\daxstudio\Shell\Open\Command"; ValueType: string; ValueData: """{app}\DaxStudio.exe"" -uri ""%1"""; Flags: uninsdeletekey

;turn off URI warnings from office apps
Root: "HKA"; Subkey: "Software\Policies\Microsoft\office\16.0\common\Security\Trusted Protocols\All Applications\daxstudio:"; Flags: uninsdeletekey noerror

;Clean up beta Excel x86 Addin Keys
;Root: "HKLM32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio"; ValueType: none; Flags: deletekey dontcreatekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
;Clean up beta Excel x64 Addin keys
;Root: "HKLM64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio"; ValueType: none; Flags: deletekey dontcreatekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
;Clean up unused registry values
;Root: "HKCU"; Subkey: "Software\DaxStudio"; ValueType: none; Flags: deletevalue; ValueName: "ShowPreReleaseNotifications";

; Remove all users settings on uninstall
;Root: "HKCU"; Subkey: "Software\DaxStudio"; ValueType: none; Flags: uninsdeletekey


[CustomMessages]
win_sp_title=Windows %1 Service Pack %2

[Components]
Name: "Excel"; Description: "Excel Addin"; Types: full
Name: "Core"; Description: "DaxStudio Core (includes connectivity to SSAS Tabular)"; Types: full standalone custom; Flags: fixed
;Name: "Core\PBI"; Description: "Power BI Desktop External Tools integration"; Types: full standalone custom; Check: IsAdminInstallMode;
;Name: "ASAzureSupport"; Description: "Ensures that the pre-requisites for Analysis Services Azure are installed"


[InstallDelete]
; Make sure that local copies of the Excel files do not exist
Type: files; Name: "{app}\bin\Microsoft.Excel.Amo.dll"
Type: files; Name: "{app}\bin\Microsoft.Excel.AdomdClient.dll"
Type: files; Name: "{app}\Microsoft.Excel.Amo.dll"
Type: files; Name: "{app}\Microsoft.Excel.AdomdClient.dll"
; Make sure the .portable file does not exist
Type: files; Name: "{app}\bin\.portable"
Type: filesandordirs; Name: "{app}\*.dll"
Type: filesandordirs; Name: "{app}\*.exe"
Type: filesandordirs; Name: "{app}\*.vsto"
Type: filesandordirs; Name: "{app}\*.manifest"
Type: filesandordirs; Name: "{app}\*.config"
; remove any resource folders from the application root folder
; these should be in the /bin subfolder
Type: filesandordirs; Name: "{app}\ar"
Type: filesandordirs; Name: "{app}\bg"
Type: filesandordirs; Name: "{app}\ca"
Type: filesandordirs; Name: "{app}\ca-ES"
Type: filesandordirs; Name: "{app}\cs"
Type: filesandordirs; Name: "{app}\cs-CZ"
Type: filesandordirs; Name: "{app}\da"
Type: filesandordirs; Name: "{app}\de"
Type: filesandordirs; Name: "{app}\de-DE"
Type: filesandordirs; Name: "{app}\el"
Type: filesandordirs; Name: "{app}\en"
Type: filesandordirs; Name: "{app}\es"
Type: filesandordirs; Name: "{app}\es-ES"
Type: filesandordirs; Name: "{app}\et"
Type: filesandordirs; Name: "{app}\eu"
Type: filesandordirs; Name: "{app}\fi"
Type: filesandordirs; Name: "{app}\fr"
Type: filesandordirs; Name: "{app}\fr-FR"
Type: filesandordirs; Name: "{app}\gl"
Type: filesandordirs; Name: "{app}\he"
Type: filesandordirs; Name: "{app}\hi"
Type: filesandordirs; Name: "{app}\hi-IN"
Type: filesandordirs; Name: "{app}\hr"
Type: filesandordirs; Name: "{app}\hu"
Type: filesandordirs; Name: "{app}\id"
Type: filesandordirs; Name: "{app}\it"
Type: filesandordirs; Name: "{app}\it-IT"
Type: filesandordirs; Name: "{app}\ja"
Type: filesandordirs; Name: "{app}\ja-JP"
Type: filesandordirs; Name: "{app}\kk"
Type: filesandordirs; Name: "{app}\ko"
Type: filesandordirs; Name: "{app}\lt"
Type: filesandordirs; Name: "{app}\lv"
Type: filesandordirs; Name: "{app}\ms"
Type: filesandordirs; Name: "{app}\nl"
Type: filesandordirs; Name: "{app}\nl-BE"
Type: filesandordirs; Name: "{app}\nl-NL"
Type: filesandordirs; Name: "{app}\no"
Type: filesandordirs; Name: "{app}\pl"
Type: filesandordirs; Name: "{app}\pt"
Type: filesandordirs; Name: "{app}\pt-BR"
Type: filesandordirs; Name: "{app}\pt-PT"
Type: filesandordirs; Name: "{app}\ro"
Type: filesandordirs; Name: "{app}\ru"
Type: filesandordirs; Name: "{app}\ru-RU"
Type: filesandordirs; Name: "{app}\sk"
Type: filesandordirs; Name: "{app}\sl"
Type: filesandordirs; Name: "{app}\sr-Cyrl"
Type: filesandordirs; Name: "{app}\sr-Latn"
Type: filesandordirs; Name: "{app}\sv"
Type: filesandordirs; Name: "{app}\th"
Type: filesandordirs; Name: "{app}\tr"
Type: filesandordirs; Name: "{app}\uk"
Type: filesandordirs; Name: "{app}\vi"
Type: filesandordirs; Name: "{app}\zh-CHS"
Type: filesandordirs; Name: "{app}\zh-CHT"
Type: filesandordirs; Name: "{app}\zh-Hans"
Type: filesandordirs; Name: "{app}\zh-Hant"

[Code]
#include "scripts/clihelp.iss"


//If there is a command-line parameter "skipdependencies=true", don't check for them }
function ShouldInstallDependencies(): Boolean;
begin
  Result := True
  if ExpandConstant('{param:skipdependencies|false}') <> 'false' then begin
    Result := False;
  end;
end;

var maxCommonSsasAssemblyVersion: string;

function GetV4NetDir(version: string) : string;
var
  regkey, regval  : string;
begin

    // in case the target is 3.5, replace 'v4' with 'v3.5'
    // for other info, check out this link
    // https://stackoverflow.com/questions/199080/how-to-detect-what-net-framework-versions-and-service-packs-are-installed
    regkey := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'

    RegQueryStringValue(HKLM, regkey, 'InstallPath', regval);

    Result := regval;
end;

function SwapSlashes(const path:String):String;
var
   tmp:String;
begin
   tmp := path;
   StringChange(tmp, '\','/');
   Result:=tmp;
end;

//convert String from REG_BINARY to Pascal String
function ConvertToString(AString:AnsiString):String;
var
 i : Integer;
 iChar : Integer;
 outString : String;
begin
 outString :='';
 for i := 6 to (Length(AString)/2-1) do
 begin
  iChar := Ord(AString[i*2+1]); //get int value
  outString := outString + Chr(iChar);
 end;

 Result := outString;
end;

// check that DaxStudio is not in the "hard" disabled addins list and remove it if it is
procedure CleanDisabledItems;
var
  I: Integer;
  J: Integer;
  RegKeys: array[1..3] of string;
  RegKeyCnt: Integer;
  Names: TArrayOfString;
  ResultStr: AnsiString;
  keyName: String;
begin
  RegKeys[1] := 'Software\Microsoft\Office\14.0\Excel\Resiliency\DisabledItems';    // Excel 2010
  RegKeys[2] := 'Software\Microsoft\Office\15.0\Excel\Resiliency\DisabledItems';    // Excel 2013
  RegKeys[3] := 'Software\Microsoft\Office\16.0\Excel\Resiliency\DisabledItems';    // Excel 2016
  RegKeyCnt := 3; //GetArrayLength(RegKeys);

  // for each version of Excel
  //for I := 1 to RegKeyCnt do
  for I := 1 to GetArrayLength(RegKeys) do
  begin
    If  RegKeyExists(HKEY_CURRENT_USER, RegKeys[I]) then
    begin
      if RegGetValueNames(HKEY_CURRENT_USER, RegKeys[I], Names) then
      begin
        keyName := '';
        // loop through any disabled add-ins and delete
        // any keys that reference Dax Studio
        for J := 0 to GetArrayLength(Names)-1 do
        begin
          RegQueryBinaryValue(HKEY_CURRENT_USER, RegKeys[I], Names[J], ResultStr)
          keyName := Lowercase(ConvertToString(ResultStr));
          //MsgBox('List of values:'#13#10#13#10 + S, mbInformation, MB_OK);
          if Pos( 'daxstudio.vsto', keyName) > 0 then
              RegDeleteValue(HKEY_CURRENT_USER, RegKeys[i], Names[J])
        end;
      end else
      begin
        // add any code to handle failure here
      end;
    end;

  end;

end;

// var ExcelMode: TInputOptionWizardPage;
// procedure GetExcelMode;
// begin
//    ExcelMode := CreateInputOptionPage(wpSelectComponents,
//     'Excel Addin', 'How would you like the Excel Addin registered',
//     'Please specify how you would like the Excel Addin registered.',
//     True, False);
//   ExcelMode.Add('All Users (requires Admin rights to change)');
//   ExcelMode.Add('Current User Only (enable from the Options menu in DAX Studio)');
//   // default to All Users
//   ExcelMode.SelectedValueIndex := 0
// end;

// function IsExcelAllUsers: Boolean;
// begin
//   Result := ExcelMode.SelectedValueIndex = 0;
// end;

// function IsExcelCurrentUser: Boolean;
// begin
//   Result := ExcelMode.SelectedValueIndex = 1;
// end;

function GetMaxCommonSsasAssemblyVersion(): String;
begin
    Result := maxCommonSsasAssemblyVersion;
end;

// function ShouldSkipPage(PageID: Integer): Boolean;
// begin

//   { Skip pages that shouldn't be shown }
//   if (PageID = ExcelMode.ID) and Not IsComponentSelected('Excel') then
//     Result := True
//   else
//     Result := False;
// end;


procedure InitializeWizard;
var
	i: Integer;
begin
	// Check for help switch passed on installer command line
	if paramcount() > 0 then
		for i:=1 to paramcount() do
			if (Lowercase(Copy(ParamStr(i), 1, 2)) = '/?') OR ((Length(ParamStr(i)) = 2) AND (Lowercase(Copy(ParamStr(i), 1, 2)) = '/h')) OR (Lowercase(Copy(ParamStr(i), 1, 5)) = '/help') then
				DisplayHelp();


  { Create the pages }

  // GetExcelMode();
end;


function InitializeSetup(): boolean;
begin

  // clear DaxStudio from Excel Add-ins hard disabled items
  try
    Log('Clearing Disabled items from Excel Add-in registry location');
    CleanDisabledItems();


  except
    // Catch the exception, show it, and continue
    ShowExceptionMessage;
  end;

	//init windows version
	try
    Log('Checking Windows Version');
    initwinversion();
  except
    // Catch the exception, show it, and continue
    ShowExceptionMessage;
  end;



  //  Log('Checking the maximum SSAS assembly versions');
//  maxCommonSsasAssemblyVersion := GetMaxCommonSsasAssemblyVersionInternal();
//  Log('Max SSAS assembly versions ' + maxCommonSsasAssemblyVersion);
//  msgbox(GetMaxCommonSsasAssemblyVersion(), mbInformation,MB_OK);

//  if IsExcel2010Installed() then begin
//      msgbox('hello', mbInformation,MB_OK);
//  end;

//  if IsAssemblyInstalled('Microsoft.AnalysisServices', '11.0.0.0' ) then begin
//      msgbox('amo ok',mbInformation, MB_OK);
//  end  else begin
//      msgbox('amo NOT ok',mbInformation, MB_OK);
//  end;

//  if IsAssemblyInstalled('Microsoft.AnalysisServices.AdomdClient', '11.0.0.0' ) then begin
//      msgbox('adomd ok',mbInformation, MB_OK);
//  end  else begin
//      msgbox('adomd NOT ok',mbInformation, MB_OK);
//  end;

#ifdef use_msi20
	msi20('2.0');
#endif
#ifdef use_msi31
	msi31('3.1');
#endif
#ifdef use_msi45
	msi45('4.5');
#endif



if ShouldInstallDependencies() then
  Log('Checking for Dependencies')
else
  Log('WARNING: Skipping Dependency checks due to /skipdependencies=true');

// if no .netfx 4.0 is found, install the client (smallest)
#ifdef use_dotnetfx40
  Log('Checking if .Net 4.0 is installed');
	if (not netfxinstalled(NetFx40Client, '') and not netfxinstalled(NetFx40Full, '')) and ShouldInstallDependencies() then
		dotnetfx40client();
#endif

#ifdef use_dotnetfx45
    if ShouldInstallDependencies() then begin
      Log('Checking if .Net 4.5 is installed');
      dotnetfx45(0); // min allowed version is .netfx 4.5.0
    end;
#endif

#ifdef use_dotnetfx471
    if ShouldInstallDependencies() then begin
      Log('Checking if .Net 4.7.1 is installed');
      dotnetfx47(1); // min allowed version is .netfx 4.7.1
    end;
#endif


#ifdef use_vc2010
	vcredist2010();
#endif

	Result := true;
end;


// procedure CurPageChanged(CurPageID: Integer);
// begin
// Log('Processing custom page actions for ' + IntToStr(CurPageID));
//   if CurPageID = wpReady then begin
//      if IsExcelCurrentUser then Log('Installing Excel add-in for CurrentUser');
//      If IsExcelAllUsers then Log('Installing Excel add-in for AllUsers');
//   end;
// end;


// Check if Excel is x86 or x64
const
  // Constants for GetBinaryType return values.
  SCS_32BIT_BINARY = 0;
  SCS_64BIT_BINARY = 6;
  // There are other values that GetBinaryType can return, but we're
  // not interested in them.

// Declare Win32 function
function GetBinaryType(lpApplicationName: AnsiString; var lpBinaryType: Integer): Boolean;
external 'GetBinaryTypeA@kernel32.dll stdcall';

function Is64BitExcelFromRegisteredExe(): Boolean;
var
  excelPath: String;
  binaryType: Integer;
begin
  Result := True; // Default value - assume 64-bit unless we explicitly find the 32 bit exe.
  // RegQueryStringValue second param is '' to get the (default) value for the key
  // with no sub-key name, as described at
  // https://stackoverflow.com/questions/913938/
  if IsWin64() and RegQueryStringValue(HKEY_LOCAL_MACHINE,
      'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\excel.exe',
      '', excelPath) then begin
    // We've got the path to Excel.
    try
      if GetBinaryType(excelPath, binaryType) then begin
        Result := (binaryType = SCS_64BIT_BINARY);
      end;
    except
      // Ignore - better just to assume it's 64-bit and install both sets
      // of registry keys than to let the installation
      // fail.  This could fail because the GetBinaryType function is not
      // available.  I understand it's only available in Windows 2000
      // Professional onwards.
    end;
  end;
end;

function Is32BitExcelFromRegisteredExe(): boolean;
var
  excelPath: String;
  binaryType: Integer;
begin
  Result := True; // Default value - assume 32-bit unless proven otherwise.
  // RegQueryStringValue second param is '' to get the (default) value for the key
  // with no sub-key name, as described at
  // https://stackoverflow.com/questions/913938/
  if RegQueryStringValue(HKEY_LOCAL_MACHINE,
      'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\excel.exe',
      '', excelPath) then begin
    // We've got the path to Excel.
    try
      if GetBinaryType(excelPath, binaryType) then begin
        Result := (binaryType <> SCS_64BIT_BINARY);
      end;
    except
      // Ignore - better just to assume it's 32-bit than to let the installation
      // fail.  This could fail because the GetBinaryType function is not
      // available.  I understand it's only available in Windows 2000
      // Professional onwards.
    end;
  end;
end;


function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  //sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  //sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}');
  sUnInstPath := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' +
        ExpandConstant('{#SetupSetting("AppId")}') + '_is1';  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);

  //Msgbox('The following uninstall strig was found' + #13#10 +
  //    sUnInstallString, mbInformation, MB_OK);

  Result := sUnInstallString;
end;


/////////////////////////////////////////////////////////////////////
// Path functions

const EnvironmentKey = 'Environment';

procedure EnvAddPath(instlPath: string);
var
    Paths: string;
begin
    { Retrieve current path (use empty string if entry not exists) }
    if not RegQueryStringValue(HKEY_CURRENT_USER, EnvironmentKey, 'Path', Paths) then
        Paths := '';

    if Paths = '' then
        Paths := instlPath + ';'
    else
    begin
        { Skip if string already found in path }
        if Pos(';' + Uppercase(instlPath) + ';',  ';' + Uppercase(Paths) + ';') > 0 then exit;
        if Pos(';' + Uppercase(instlPath) + '\;', ';' + Uppercase(Paths) + ';') > 0 then exit;

        { Append App Install Path to the end of the path variable }
        Log(Format('Right(Paths, 1): [%s]', [Paths[length(Paths)]]));
        if Paths[length(Paths)] = ';' then
            Paths := Paths + instlPath + ';'  { don't double up ';' in env(PATH) }
        else
            Paths := Paths + ';' + instlPath + ';' ;
    end;

    { Overwrite (or create if missing) path environment variable }
    if RegWriteStringValue(HKEY_CURRENT_USER, EnvironmentKey, 'Path', Paths)
    then Log(Format('The [%s] added to PATH: [%s]', [instlPath, Paths]))
    else Log(Format('Error while adding the [%s] to PATH: [%s]', [instlPath, Paths]));
end;


procedure EnvRemovePath(instlPath: string);
var
    Paths: string;
    P, Offset, DelimLen: Integer;
begin
    { Skip if registry entry not exists }
    if not RegQueryStringValue(HKEY_CURRENT_USER, EnvironmentKey, 'Path', Paths) then
        exit;

    { Skip if string not found in path }
    DelimLen := 1;     { Length(';') }
    P := Pos(';' + Uppercase(instlPath) + ';', ';' + Uppercase(Paths) + ';');
    if P = 0 then
    begin
        { perhaps instlPath lives in Paths, but terminated by '\;' }
        DelimLen := 2; { Length('\;') }
        P := Pos(';' + Uppercase(instlPath) + '\;', ';' + Uppercase(Paths) + ';');
        if P = 0 then exit;
    end;

    { Decide where to start string subset in Delete() operation. }
    if P = 1 then
        Offset := 0
    else
        Offset := 1;
    { Update path variable }
    Delete(Paths, P - Offset, Length(instlPath) + DelimLen);

    { Overwrite path environment variable }
    if RegWriteStringValue(HKEY_CURRENT_USER, EnvironmentKey, 'Path', Paths)
    then Log(Format('The [%s] removed from PATH: [%s]', [instlPath, Paths]))
    else Log(Format('Error while removing the [%s] from PATH: [%s]', [instlPath, Paths]));
end;


/////////////////////////////////////////////////////////////////////
function IsUpgrade(): Boolean;
begin
  Result := (GetUninstallString() <> '');
end;


//function IsUpgrade: Boolean;
//var
//    Value: string;
//    UninstallKey: string;
//begin
//    UninstallKey := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' +
//        ExpandConstant('{#SetupSetting("AppId")}') + '_is1';
//    Result := (RegQueryStringValue(HKLM, UninstallKey, 'UninstallString', Value) or
//        RegQueryStringValue(HKCU, UninstallKey, 'UninstallString', Value)) and (Value <> '');
//end;

/////////////////////////////////////////////////////////////////////

function ShouldSkipPage(PageID: Integer): Boolean;
begin
if IsUpgrade then
  begin

    if PageID = wpWelcome then
      begin
        Log('ShouldSkipPage - Skipping Welcome');
        Result := true
      end;

    if PageID = wpLicense then
      begin
        Log('ShouldSkipPage - Skipping License');
        Result := true
      end;

    if PageID = wpInfoBefore then
      begin
        Log('ShouldSkipPage - Skipping InfoBefore page');
        Result := true;
      end;

    if PageID = wpSelectTasks then begin
      Log('ShouldSkipPage - Skipping Tasks');
      Result := true
    end
  end
  else
  begin
    Log('ShouldSkipPage - Initial Install');
    if PageID = wpInfoBefore then
    if IsAdminInstallMode() then
    begin
        Log('ShouldSkipPage - Skipping InfoBefore page');
        Result := true;
    end;
  end;
end;
/////////////////////////////////////////////////////////////////////
function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
// Return Values:
// 1 - uninstall string is empty
// 2 - error executing the UnInstallString
// 3 - successfully executed the UnInstallString

  // default return value
  Result := 0;

  // get the uninstall string of the old app
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    StringChange(sUninstallString, ' /I', ' /x');
    sUnInstallString := sUninstallString + ' /quiet /norestart'
    //MsgBox('About to run: ' + sUninstallString, mbInformation, MB_OK);
    if Exec('>', sUnInstallString,'', SW_SHOW, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;
/////////////////////////////////////////////////////////////////////

// Overwrite the daxstudio.pbitool.json file with the path where the user actually install DAX Studio
// incase this is not the default path
function WriteExternalToolsFile(): boolean;
var
  fileName : string;
  lines : TArrayOfString;
  exeName : string;
begin
  Result := true;
  fileName := ExpandConstant('{commoncf32}\Microsoft Shared\Power BI Desktop\External Tools\daxstudio.pbitool.json');
Log('pbitool FileName = ' + fileName);
  exeName := ExpandConstant('{app}\DaxStudio.exe');
  // escape a single backslash \  with double back slashes \\
  StringChangeEx(exeName, '\', '\\', True);
  // escape any double quotes " with backslash double quote \"
  StringChangeEx(exeName, '"', '\"', True);
Log('pbitool exeName = ' + exeName );

  SetArrayLength(lines, 8);
  lines[0] := '{';
  lines[1] := '  "version": "1.0",';
  lines[2] := '  "name": "DAX Studio",';
  lines[3] := '  "description": "Use DAX Studio for DAX authoring, diagnosis, performance tuning and analysis.",';
  lines[4] := '  "path": "' + exeName + '",';
  lines[5] := '  "arguments": "/server=\"%server%\" /database=\"%database%\"",';
  lines[6] := '  "iconData": "image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMTYiIGhlaWdodD0iMjE2IiB2aWV3Qm94PSIwIDAgMjE2IDIxNiI+PHBhdGggZD0iTTE1OS40NjkxLDYyLjAyOWwtMS4wMTg5LTcuNDFMMTIwLjkzODcsMjUuNzY0LDIzLjMxMjQsMzguNTg4NWw5LjA2NjgsNjguOTkzNWMuNTU5Mi0uMDIyNSwxLjExNzctLjA1MTEsMS42OC0uMDUxMUE0MS4yNCw0MS4yNCwwLDAsMSw1OC4yLDExNS4yODg4YTQyLjM0Myw0Mi4zNDMsMCwwLDEsMTQuMDg2Miw1MS4zODRoNjAuNzQ4bC45NjQ2LTIuNjM2NmMuNzc2OS0yLjEyMzMsMS41NzgxLTQuMzA1NCwyLjM4Ni02LjUwNTcsNC4xMy0xMS4yNDY2LDEwLjI3MzctMjcuOTc5MiwxMS4yODg0LTMyLjM4NzctLjQyNTUtMi40MTU0LTEuODk1NC01Ljg4MjgtMy4zMjEtOS4yNDU3LTMuODgyMS05LjE1NzMtOC43MTM1LTIwLjU1NC0zLjc4MjItMzIuNTY2MUE0My4yMjA3LDQzLjIyMDcsMCwwLDEsMTU5LjQ2OTEsNjIuMDI5Wk05NC4zMjc5LDE0NC4zOSw4NS4xOTA1LDc0Ljk3NzlsMTkuNzE3Ni0yLjU2NDkuOTYxOSw3LjA1MzRMOTQuNjQ4Niw4MC45MDkybDcuMjEzNyw1NS4xNDUyLDExLjIyMTQtMS40NDI4Ljk2MTksNy4wNTM1WiIgc3R5bGU9ImZpbGw6IzFhMWExYSIvPjxwb2x5Z29uIHBvaW50cz0iMTI1LjQyNyA1OC45NDcgMTU4LjYxMSA1NC42MTkgMTIxLjA5OSAyNS43NjQgMTI1LjQyNyA1OC45NDciIHN0eWxlPSJmaWxsOiMzNDkyZDAiLz48cGF0aCBkPSJNMTQxLjY0MjksMTY2LjgzMzFoMjYuMDU4OWM0LjMxOTItMTIuMDkzNiwxMC45MTMzLTI4LjEzMjgsMTIuNzg1LTMxLjU4ODEsMy41OTkyLTYuNDc4NywyNy4yMTA2LTguMDYyNCwzMi44MjU1LTIxLjc0YTM1LjI1ODEsMzUuMjU4MSwwLDAsMC03Ljc3NDUtMzguNTg0NWwtOC40OTQzLDIwLjU4OGMtMy44ODcyLDkuMzU4Mi05LjA3LDYuMTkwOC0xNS44MzY5LDMuNDU1M3MtMTIuNjY5NS00LjMxOTEtOC43ODIyLTEzLjY3NzNsOC40OTQzLTIwLjU4OGEzNS4xMjczLDM1LjEyNzMsMCwwLDAtMzIuODI1NiwyMS43NGMtNS42MTQ5LDEzLjY3NzMsNi43NjY3LDI4LjIxODQsNy43NzQ1LDM4LjU4NDRDMTU2LjMsMTI3LjMyNjUsMTQ4LjEyMTYsMTQ5LjEyNDYsMTQxLjY0MjksMTY2LjgzMzFaIiBzdHlsZT0iZmlsbDojMWExYTFhIi8+PHBvbHlnb24gcG9pbnRzPSI4MC4xNzkgMTc2LjQyMiA4OC4xNTIgMTg0LjUyOCA5My43NjcgMTkwLjIzNiAxNjkuMjYgMTkwLjIzNiAxNjkuMjYgMTc2LjQyMiA4MC4xNzkgMTc2LjQyMiIgc3R5bGU9ImZpbGw6IzM0OTJkMCIvPjxwYXRoIGQ9Ik0zNC4wODY5LDE4My4zMTY3YTM0LjUxNTIsMzQuNTE1MiwwLDAsMCwxOC44NTUyLTUuNzA4NUw2NS4yMjM5LDE5MC4yMzZIODIuMzQ5MmwtMjAuNzU4LTIxLjEwMzlhMzMuODgzOSwzMy44ODM5LDAsMSwwLTQ3LjIyNDQsOC4xMywzNC44ODc0LDM0Ljg4NzQsMCwwLDAsMTkuNzIsNi4wNTQ0Wm0wLTU3LjI1NzVBMjMuNDM5NCwyMy40Mzk0LDAsMSwxLDEwLjU2MTIsMTQ5LjU4NWEyMy40MDMxLDIzLjQwMzEsMCwwLDEsMjMuNTI1Ny0yMy41MjU4WiIgc3R5bGU9ImZpbGw6IzFhMWExYSIvPjwvc3ZnPg=="';
  lines[7] := '}';

  Result := SaveStringsToFile(filename,lines,False);
  if (Result) then Log('Success updating pbitool file');
  if (Result = False) then Log('Error updating pbitool file');

  exit;
end;

const
			ModPathName = 'modifypath';

function ModPathDir(): TArrayOfString;
		begin
			setArrayLength(Result, 1);
			Result[0] := ExpandConstant('{app}');
		end;

#include "modpath.iss"

/////////////////////////////////////////////////////////////////////
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if IsUpgrade() then
    begin
    //  UnInstallOldVersion();
    end;
  end;
  if (CurStep=ssPostInstall) then begin

    if IsAdminInstallMode() then
      begin
        Log('Writing Power BI Desktop External Tools File');
        WriteExternalToolsFile();
      end
    else
      begin
          Log('Skipping Power BI Desktop External Tools File - Current User install');
      end;

    if WizardIsTaskSelected(ModPathName) then begin
      Log('Adding to Path:' + ExpandConstant('{app}'));
			ModPath();
    end;

    Log('Clearing AutoSave Folder - ' + ExpandConstant('{userappdata}\DaxStudio\AutoSaveFiles\*.*'));
    DelTree(ExpandConstant('{userappdata}\DaxStudio\AutoSaveFiles\*.*'), False,True,False);

  end;
end;


procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
	if (CurUninstallStep  = usUninstall) then
			RemoveFromPath();
end;


