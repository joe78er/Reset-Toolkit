@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: Ins Verzeichnis der Batchdatei wechseln (unabhängig von Benutzername oder Laufwerk)
pushd "%~dp0"

:: Admin-Prüfung
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Diese Batchdatei muss als Administrator ausgeführt werden.
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    popd
    exit /b
)

:Start
cls
echo ================================
echo   Wähle eine RESET-Kategorie:
echo ================================
echo [1] WLAN-Einstellungen
echo [2] DNS + Netzwerkadapter
echo [3] Firewall
echo [4] Explorer
echo [5] Windows Defender
echo [6] Systemupdate
echo [7] Microsoft Store
echo [8] Druckerwarteschlange
echo [0] Beenden
echo ================================
set /p kategorie=Deine Auswahl: 

if "%kategorie%"=="1" (
    cls
    call :findAndCall "WLAN-Reset.bat"
    goto Start
)

if "%kategorie%"=="2" (
    cls
    call :findAndCall "DNS-Cache + Netzwerkadapter-Reset.bat"
    goto Start
)

if "%kategorie%"=="3" (
    cls
    call :findAndCall "Firewall-Reset.bat"
    goto Start
)

if "%kategorie%"=="4" (
    cls
    call :findAndCall "Reboot Explorer.bat"
    goto Start
)

if "%kategorie%"=="5" (
    cls
    call :findAndCall "Defender-Reset.bat"
    goto Start
)

if "%kategorie%"=="6" (
    cls
    call :findAndCall "SystemUpdateReset.bat"
    goto Start
)

if "%kategorie%"=="7" (
    cls
    call :findAndCall "Microsoft-Store-Reset.bat"
    goto Start
)

if "%kategorie%"=="8" (
    cls
    call :findAndCall "Druckerwarteschlange-Reset.bat"
    goto Start
)

if "%kategorie%"=="0" (
    timeout /t 1 /nobreak >nul
    popd
    cls
    exit
)

goto Start

:: ---------------------------------
:: Hilfsroutine: Datei per Namen rekursiv suchen und ausführen
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
    echo Datei "%target%" wurde nicht gefunden.
    echo Stelle sicher, dass sie im gleichen Ordner oder einem Unterordner liegt.
    exit /b 1
)

call "%found%"

exit /b 0
