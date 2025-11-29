@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: Switch to the directory of this batch file (works on any user account or drive)
pushd "%~dp0"

:: Admin check
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This batch file must be run as Administrator.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    popd
    exit /b
)

:Start
cls
echo ================================
echo   Choose a RESET category:
echo ================================
echo [1] WLAN settings
echo [2] DNS + Network Adapter
echo [3] Firewall
echo [4] Explorer
echo [5] Windows Defender
echo [6] System Update
echo [7] Microsoft Store
echo [8] Printer Queue
echo [0] Exit
echo ================================
set /p category=Your choice: 

if "%category%"=="1" (
    cls
    call :findAndCall "WLAN-Reset.bat"
    goto Start
)

if "%category%"=="2" (
    cls
    call :findAndCall "DNS-Cache + Network-Adapter-Reset.bat"
    goto Start
)

if "%category%"=="3" (
    cls
    call :findAndCall "Firewall-Reset.bat"
    goto Start
)

if "%category%"=="4" (
    cls
    call :findAndCall "Reboot Explorer.bat"
    goto Start
)

if "%category%"=="5" (
    cls
    call :findAndCall "Defender-Reset.bat"
    goto Start
)

if "%category%"=="6" (
    cls
    call :findAndCall "SystemUpdateReset.bat"
    goto Start
)

if "%category%"=="7" (
    cls
    call :findAndCall "Microsoft-Store-Reset.bat"
    goto Start
)

if "%category%"=="8" (
    cls
    call :findAndCall "PrinterQueue-Reset.bat"
    goto Start
)

if "%category%"=="0" (
    timeout /t 1 /nobreak >nul
    cls
    popd
    exit
)

goto Start

:: ---------------------------------
:: Helper routine: search and run batch file by name
:: ---------------------------------
:findAndCall
set "target=%~1"
set "found="

for /r "%~dp0" %%F in (*) do (
    if /i "%%~nxF"=="%target%" (
        set "found=%%~fF"
        goto :foundBreak
    )
)

:foundBreak
if not defined found (
    echo File "%target%" was not found.
    echo Make sure it is located in the same folder or a subfolder.
    exit /b 1
)

call "%found%"

exit /b 0
