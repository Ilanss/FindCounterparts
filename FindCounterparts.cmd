@echo off
setlocal

set tempfile=%TEMP%\fc_args.txt

:: Clear and recreate the file
powershell.exe -NoProfile -Command "'' | Set-Content -Path '%tempfile%' -Encoding UTF8"

:: Loop through all arguments and append them to the file (UTF-8 safe)
:loop
if "%~1"=="" goto done
powershell.exe -NoProfile -Command "Add-Content -Path '%tempfile%' -Value '%~1' -Encoding UTF8"
shift
goto loop

:done
:: Now run the PowerShell script with the arg list
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "C:\Scripts\Find-Counterparts.ps1" -ArgListFile "%tempfile%"
