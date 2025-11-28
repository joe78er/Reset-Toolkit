@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting Windows Update.
echo.

pause >nul
timeout /t 1 /nobreak >nul
cls

echo Warning: This process may take a while!
echo If interrupted, Windows Update may break.
echo.
echo For help, visit: https://support.microsoft.com/en-us/windows/troubleshoot-problems-updating-windows-188c2b0f-10a7-d72f-65b8-32d177eb136c
echo.
echo Press any key to confirm and continue.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting Windows Update ...
echo Progress: [                              ] 0%%		completed
net stop wuauserv
del /f /s /q %systemroot%\SoftwareDistribution\Download >nul
del /f /s /q %systemroot%\WindowsUpdate.log >nul
timeout /t 2 /nobreak >nul
cls

echo Resetting Windows Update ...
echo Progress: [=========                     ] 30%%		completed
net stop cryptSvc >nul
net stop bits >nul
net stop msiserver >nul
timeout /t 2 /nobreak >nul
cls

echo Resetting Windows Update ...
echo Progress: [==================            ] 60%%		completed
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >nul
ren C:\Windows\System32\catroot2 catroot2.old >nul
timeout /t 1 /nobreak >nul
net start wuauserv >nul
net start cryptSvc >nul
net start bits >nul
net start msiserver >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting Windows Update ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo Windows Update has been successfully reset.
echo Progress: [==============================] 100%%		completed
echo Please restart your PC to apply changes.

echo.
pause
timeout /t 1 /nobreak >nul