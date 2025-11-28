@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting DNS cache and network adapter.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting DNS cache and network adapter ...
echo Progress: [                              ] 0%%		completed
ipconfig /flushdns >nul
ipconfig /release >nul
ipconfig /renew >nul
timeout /t 2 /nobreak >nul

cls
echo Resetting DNS cache and network adapter ...
echo Progress: [=========                     ] 30%%		completed
netsh interface set interface "LAN Connection" admin=disable >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting DNS cache and network adapter ...
echo Progress: [==================            ] 60%%		completed
netsh interface set interface "LAN Connection" admin=enable >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting DNS cache and network adapter ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo DNS cache and network adapter have been successfully reset.
echo Progress: [==============================] 100%%		completed

echo.
pause
timeout /t 1 /nobreak >nul