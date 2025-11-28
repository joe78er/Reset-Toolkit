@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting Microsoft Store.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting Microsoft Store ...
echo Progress: [                              ] 0%%		completed
sc config ClipSVC start= auto >nul
sc config AppXSvc start= auto >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting Microsoft Store ...
echo Progress: [=========                     ] 30%%		completed
net start ClipSVC >nul
net start AppXSvc >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting Microsoft Store ...
echo Progress: [==================            ] 60%%		completed
wsreset.exe >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting Microsoft Store ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo Microsoft Store has been successfully reset.
echo Progress: [==============================] 100%%		completed
echo Please restart your PC to apply changes.

echo.
pause
timeout /t 1 /nobreak >nul