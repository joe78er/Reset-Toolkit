@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting firewall settings.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting firewall settings ...
echo Progress: [                              ] 0%%		completed
netsh advfirewall reset >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting firewall settings ...
echo Progress: [=========                     ] 30%%		completed
netsh advfirewall set allprofiles state on >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting firewall settings ...
echo Progress: [==================            ] 60%%		completed
netsh advfirewall firewall delete rule name=all >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting firewall settings ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo Firewall settings have been successfully reset.
echo Progress: [==============================] 100%%		completed
echo Please restart your PC to apply changes.

echo.
pause
timeout /t 1 /nobreak >nul