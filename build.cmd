@echo off
goto:$Main

:SetError
setlocal
    set _error=%~1
endlocal & exit /b %_error%

:EnvCommand
setlocal EnableDelayedExpansion
    set "_command=%*"
    set "_command=!_command:   = !"
    set "_command=!_command:  = !"
    echo ##[cmd] !_command!
    call !_command!
endlocal & (
    set "__COMPAT_LAYER=%__COMPAT_LAYER%"
    set "__CONDA_OPENSLL_CERT_FILE_SET=%__CONDA_OPENSLL_CERT_FILE_SET%"
    set "__DOTNET_ADD_32BIT=%__DOTNET_ADD_32BIT%"
    set "__DOTNET_PREFERRED_BITNESS=%__DOTNET_PREFERRED_BITNESS%"
    set "__VCVARS_REDIST_VERSION=%__VCVARS_REDIST_VERSION%"
    set "__VSCMD_PREINIT_PATH=%__VSCMD_PREINIT_PATH%"
    set "DriverData=%DriverData%"
    set "ExtensionSdkDir=%ExtensionSdkDir%"
    set "EXTERNAL_INCLUDE=%EXTERNAL_INCLUDE%"
    set "FPS_BROWSER_APP_PROFILE_STRING=%FPS_BROWSER_APP_PROFILE_STRING%"
    set "FPS_BROWSER_USER_PROFILE_STRING=%FPS_BROWSER_USER_PROFILE_STRING%"
    set "Framework40Version=%Framework40Version%"
    set "FrameworkDir=%FrameworkDir%"
    set "FrameworkDir32=%FrameworkDir32%"
    set "FrameworkVersion=%FrameworkVersion%"
    set "FrameworkVersion32=%FrameworkVersion32%"
    set "FSHARPINSTALLDIR=%FSHARPINSTALLDIR%"
    set "NETFXSDKDir=%NETFXSDKDir%"
    set "PATH=%PATH%"
    set "PATHEXT=%PATHEXT%"
    set "QtMsBuild=%QtMsBuild%"
    set "SESSIONNAME=%SESSIONNAME%"
    set "SystemDrive=%SystemDrive%"
    set "SystemRoot=%SystemRoot%"
    set "UATDATA=%UATDATA%"
    set "UCRTVersion=%UCRTVersion%"
    set "UniversalCRTSdkDir=%UniversalCRTSdkDir%"
    set "VCIDEInstallDir=%VCIDEInstallDir%"
    set "VCINSTALLDIR=%VCINSTALLDIR%"
    set "VCPKG_ROOT=%VCPKG_ROOT%"
    set "VCToolsInstallDir=%VCToolsInstallDir%"
    set "VCToolsRedistDir=%VCToolsRedistDir%"
    set "VCToolsVersion=%VCToolsVersion%"
    set "VisualStudioVersion=%VisualStudioVersion%"
    set "VS170COMNTOOLS=%VS170COMNTOOLS%"
    set "VSCMD_ARG_app_plat=%VSCMD_ARG_app_plat%"
    set "VSCMD_ARG_HOST_ARCH=%VSCMD_ARG_HOST_ARCH%"
    set "VSCMD_ARG_TGT_ARCH=%VSCMD_ARG_TGT_ARCH%"
    set "VSCMD_DEBUG=%VSCMD_DEBUG%"
    set "VSCMD_VER=%VSCMD_VER%"
    set "VSINSTALLDIR=%VSINSTALLDIR%"
    set "VSSDK150INSTALL=%VSSDK150INSTALL%"
    set "VSSDKINSTALL=%VSSDKINSTALL%"
    set "WindowsLibPath=%WindowsLibPath%"
    set "WindowsSDK_ExecutablePath_x64=%WindowsSDK_ExecutablePath_x64%"
    set "WindowsSDK_ExecutablePath_x86=%WindowsSDK_ExecutablePath_x86%"
    set "WindowsSdkBinPath=%WindowsSdkBinPath%"
    set "WindowsSdkDir=%WindowsSdkDir%"
    set "WindowsSDKLibVersion=%WindowsSDKLibVersion%"
    set "WindowsSdkVerBinPath=%WindowsSdkVerBinPath%"
    set "WindowsSDKVersion=%WindowsSDKVersion%"
    exit /b %errorlevel%
)

:Command
    setlocal EnableDelayedExpansion
    goto:$CommandVar
    :CommandVar
        setlocal EnableDelayedExpansion
        set "_command=!%~1!"
        set "_command=!_command:      = !"
        set "_command=!_command:    = !"
        set "_command=!_command:   = !"
        set "_command=!_command:  = !"
        set _error_value=0
        :$RunCommand
        echo ##[cmd] !_command!
        call !_command!
        set _error_value=%ERRORLEVEL%

        :$CommandDone
        endlocal & (
            exit /b %_error_value%
        )
    :$CommandVar

    set "_command=%*"
    call :CommandVar "_command"
endlocal & exit /b %errorlevel%

:Build
    setlocal EnableDelayedExpansion

    set "command=%~1"
    set "config=%~2"
    set "error_result=0"
    if "!config!"=="" set "config=Release"

    set "_msbuild=msbuild"
    where msbuild >nul 2>nul && goto:$RunBuild
    set "_msbuild=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\msbuild.exe"
    if not exist "!_msbuild!" set "_msbuild=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe"
    if not exist "!_msbuild!" set "_msbuild=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild"
    if not exist "!_msbuild!" goto:$BuildErrorMissingTools

    :$RunBuild
    cd /D "%~dp0"
    taskkill /im "DaxStudio.exe" >nul 2>&1

    if "!command!"=="Installer" (
        set "_args=/p:DefineConstants=PREVIEW"
    ) else (
        set "_args="
    )

    call :Command "!_msbuild!" !_args! ^
       "%~dp0build.msproj" ^
       /p:Configuration="!config!" ^
       /m ^
       /v:M ^
       /fl /flp:LogFile="%~dp0msbuild_!command!.log;Verbosity=Normal" ^
       /nr:false ^
       /target:!command! ^
       /bl:LogFile="%~dp0output_!command!.binlog"
   set "error_result=%ERRORLEVEL%"
   goto:$BuildDone

   :$BuildErrorMissingTools
   echo [ERROR] Failed to find MSBuild.
   set "error_result=80"
   goto:$BuildDone

   :$BuildDone
endlocal & (
   exit /b %error_result%
)

:BuildTarget
    set "target=%~1"
    if "!target!"=="" set "target=Build"

    set "config=%~2"
    if "!config!"=="" set "config=Release"

    call :Build "Restore"   "!config!"
    if errorlevel 1 exit /b %errorlevel%

    call :Build "!target!"  "!config!"
    if errorlevel 1 exit /b %errorlevel%
exit /b %errorlevel%

:$Main
setlocal EnableDelayedExpansion
    :: Assume build environment is already setup if msbuild can be located
    where msbuild >nul 2>nul && goto:$MainCommand

    :: Allow the path to vsdevcmd to be provided by our caller
    if exist "%vsdevcmd%" (
        goto:$LaunchDevCmd
    )
    :: If we're still running, must be no vsdevcmd

    if "%ProgramFiles(x86)%"=="" set "ProgramFiles(x86)=%ProgramFiles%"
    set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
    if not exist "%vswhere%" (
        echo [ERROR] "vswhere.exe" not found; unable to locate build tools.
        call :SetError 81
        goto:$MainDone
    )

    :: This should work for Visual Studio
    for /f "usebackq delims=" %%i in (`"%vswhere%" -latest -requires Microsoft.VisualStudio.Workload.NativeDesktop -find *\Tools\vsdevcmd.bat`) do (
        set "vsdevcmd=%%i"
        goto:$LaunchDevCmd
    )

    :: This should work with Visual Studio Build Tools
    for /f "usebackq delims=" %%i in (`"%vswhere%" -latest -products * -requires Microsoft.VisualStudio.Workload.VCTools -find *\Tools\vsdevcmd.bat`) do (
        set "vsdevcmd=%%i"
        goto:$LaunchDevCmd
    )

    :: As a last resort, try without specifying the required workload
    for /f "usebackq delims=" %%i in (`"%vswhere%" -latest -products * -find *\Tools\vsdevcmd.bat`) do (
        set "vsdevcmd=%%i"
        goto:$LaunchDevCmd
    )

    :: If we're still running, vsdevcmd wasn't executed
    echo [ERROR] Unable to locate build tools.
    call :SetError 80
    goto:$MainDone

    :$LaunchDevCmd
        set VSCMD_DEBUG=2
        echo Found Visual Studio build tools: "%vsdevcmd%"
        call :EnvCommand "%vsdevcmd%"
        goto:$MainCommand

    :$MainCommand
        :: This replaces 'build2.cmd', 'build_signed.cmd', 'build_preview.cmd', and 'build_portable.cmd' scripts.
        set "targets=%~1"
        if "!targets!"=="all" set "targets=Build Installer Portable SignedInstaller UnsignedBuild"
        if "!targets!"=="" set "targets=Build"

        for %%t in (!targets!) do (
          call :BuildTarget "%%t" "%~2"
          if errorlevel 1 goto:$MainError
        )
        goto:$MainDone

    :$MainError
        echo [ERROR] Build failed.
        goto:$MainDone

    :$MainDone
        set "RETURN_VALUE=%ERRORLEVEL%"
endlocal & (
    set "PATH=%PATH%"
    exit /b %RETURN_VALUE%
)
