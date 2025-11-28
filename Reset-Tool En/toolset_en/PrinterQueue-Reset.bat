@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Press any key to start resetting the printer queue.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Resetting printer queue ...
echo Progress: [                              ] 0%%		completed
net stop spooler >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting printer queue ...
echo Progress: [=========                     ] 30%%		completed
del /Q /F %systemroot%\System32\spool\PRINTERS\* >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting printer queue ...
echo Progress: [==================            ] 60%%		completed
net start spooler >nul
timeout /t 4 /nobreak >nul

cls
echo Resetting printer queue ...
echo Progress: [============================= ] 99%%		completed
timeout /t 3 /nobreak >nul

cls
echo The printer queue has been successfully reset.
echo Progress: [==============================] 100%%		completed
echo Please restart your PC to apply changes.

echo.
pause
timeout /t 1 /nobreak >nul