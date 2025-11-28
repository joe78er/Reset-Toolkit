@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting network settings.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting network settings ...
echo Progress: [                              ] 0%%		completed
netsh winsock reset >nul
netsh winhttp reset proxy >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f 2>nul
timeout /t 4 /nobreak >nul
cls

echo Resetting network settings ...
echo Progress: [=========                     ] 30%%		completed
netsh int ip reset >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting network settings ...
echo Progress: [==================            ] 60%%		completed
netsh advfirewall reset >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting network settings ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo Network settings have been successfully reset.
echo Progress: [==============================] 100%%		completed
echo Please restart your PC to apply changes.

echo.
pause
timeout /t 1 /nobreak >nul

rem Optional - Delete specific WLAN profile: 'netsh wlan delete profile name="ProfileName"'
rem Optional - Delete all WLAN profiles:     'netsh wlan delete profile name=*'