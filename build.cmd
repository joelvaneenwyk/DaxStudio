@echo off
goto:$Main

goto:$Command
:Command
    goto:$CommandVar
    :CommandVar
        setlocal EnableDelayedExpansion
        set "_command=!%~1!"
        set "_command=!_command:      = !"
        set "_command=!_command:    = !"
        set "_command=!_command:   = !"
        set "_command=!_command:  = !"
        set _error_value=0
        if "%MYCOSHIRO_CRITICAL_ERROR%"=="" goto:$RunCommand
        if "%MYCOSHIRO_CRITICAL_ERROR%"=="0" goto:$RunCommand

        :: Hit critical error so skip the command
        echo [ERROR] Critical error detected. Skipped command: !_command!
        set _error_value=%MYCOSHIRO_CRITICAL_ERROR%
        goto:$CommandDone

        :$RunCommand
        echo ##[cmd] !_command!
        call !_command!
        set _error_value=%ERRORLEVEL%

        :$CommandDone
        endlocal & (
            exit /b %_error_value%
        )
    :$CommandVar

    setlocal EnableDelayedExpansion
        set "_command=%*"
        call :CommandVar "_command"
    endlocal & exit /b
:$Command

:Build
    setlocal EnableDelayedExpansion

    set "command=%~1"
    set "config=%~2"
    set "error_result=0"
    if "!config!"=="" set "config=Release"

    set "_msbuild=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\msbuild.exe"
    if not exist "!_msbuild!" set "_msbuild=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe"
    if not exist "!_msbuild!" set "_msbuild=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild"
    if not exist "!_msbuild!" goto:$BuildErrorMissingTools

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
    :: build2.cmd
    :: {MSBUILD} {MSPROJ} /p:Configuration={CONFIG} {ARGS} /target:UnsignedBuild
    :: build_signed.cmd
    :: {MSBUILD} {MSPROJ} /p:Configuration={CONFIG} {ARGS} /target:SignedInstaller
    :: build_preview.cmd
    :: {MSBUILD} {MSPROJ} /p:Configuration={CONFIG} {ARGS} /target:Installer /p:DefineConstants="PREVIEW"
    :: build_portable.cmd
    :: {MSBUILD} {MSPROJ} /p:Configuration={CONFIG} {ARGS} /target:Portable
    if "%~1"=="all" (
      set "targets=Build Installer Portable SignedInstaller UnsignedBuild"
    ) else (
       set "targets=%~1"
    )

    for %%t in (!targets!) do (
      call :BuildTarget "%%t" "%~2"
      if errorlevel 1 goto:$MainError
    )
    goto:$MainDone

    :$MainError
    echo [ERROR] Build failed.
    goto:$MainDone

    :$MainDone
endlocal & exit /b
