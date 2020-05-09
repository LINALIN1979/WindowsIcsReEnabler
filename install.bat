@echo off
set TaskName="IcsReEnabler"
schtasks /query /TN %TaskName% >NUL 2>&1
IF %errorlevel% NEQ 0 (
    schtasks /create /tn %TaskName% /sc onstart /delay 0000:30 /rl highest /ru system /tr "powershell.exe -file C:\Windows\ics_reenabler.ps1"
) ELSE (
    echo %TaskName% is already installed.
)
