@echo off
goto:$Main

:Build
    setlocal EnableDelayedExpansion

    set "command=%~1"
    set "config=%~2"
    if "!config!"=="" set "config=Release"

    set "_msbuild=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\msbuild.exe"
    if not exist "!_msbuild!" set "_msbuild=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe"
    if not exist "!_msbuild!" set "_msbuild=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild"

    "!_msbuild!" ^
       "%~dp0build.msproj" ^
       /p:Configuration="!config!" ^
       /m ^
       /v:M ^
       /fl /flp:LogFile="%~dp0msbuild_!command!.log;Verbosity=Normal" ^
       /nr:false ^
       /target:!command! ^
       /bl:LogFile="%~dp0output_!command!.binlog"
endlocal & (
   exit /b 0
)

:: build2.cmd
:: "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\msbuild.exe" build.msproj /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false /target:UnsignedBuild /bl:LogFile=output.binlog
:: build_signed.cmd
:: "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\msbuild.exe" build.msproj /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false /target:SignedInstaller
:: build_preview.cmd
:: "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\msbuild.exe" build.msproj /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false /target:Installer /p:DefineConstants="PREVIEW"
:: build_portable.cmd
:: "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe" build.msproj /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false /target:Portable

:$Main
setlocal EnableDelayedExpansion
    set "target=%~1"
    if "!target!"=="" set "target=Build"

    set "config=%~2"
    if "!config!"=="" set "config=Release"

    call :Build "Restore"   "!config!"
    call :Build "!target!"  "!config!"
endlocal & exit /b
