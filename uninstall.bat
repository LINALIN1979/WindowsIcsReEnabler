@echo off
set TaskName="IcsReEnabler"
schtasks /query /TN %TaskName% >NUL 2>&1
IF %errorlevel% EQU 0 (
    schtasks /Delete /TN %TaskName% /F
) ELSE (
    echo %TaskName% is already uninstalled.
)
