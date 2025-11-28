@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting Windows Defender.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting Windows Defender ...
echo Progress: [                              ] 0%%		completed
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting Windows Defender ...
echo Progress: [=========                     ] 30%%		completed
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate >nul
timeout /t 3 /nobreak >nul

cls
echo Resetting Windows Defender ...
echo Progress: [==================            ] 60%%		completed
timeout /t 2 /nobreak >nul

cls
echo Resetting Windows Defender ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo Windows Defender has been successfully reset.
echo Progress: [==============================] 100%%		completed

echo.
pause
timeout /t 1 /nobreak >nul