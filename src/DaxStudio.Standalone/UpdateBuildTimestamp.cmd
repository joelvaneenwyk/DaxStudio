@echo off
goto:$Main

:$Main
    setlocal
    set "_project_dir=%~dp0"
    call "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "((Get-Date).ToUniversalTime()).ToString() | Out-File "%_project_dir%Resources\BuildDate.txt" -NoNewline -Encoding ASCII"
endlocal & exit /b %errorlevel%

