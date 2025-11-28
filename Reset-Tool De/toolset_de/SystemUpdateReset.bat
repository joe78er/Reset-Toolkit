@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)

echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen vom System Update fortzufahren.
echo.

pause >nul
timeout /t 1 /nobreak >nul
cls

echo Achtung: Dieser Prozess kann eine längere Zeit dauern! 
echo Falls der Prozess zwischendrin unterbrochen wird, könnten Probleme beim System Update entstehen.
echo.
echo Wenn das für Sie zutrifft, 
echo dann finden Sie hier Hilfe: https://support.microsoft.com/de-de/windows/behandeln-sie-probleme-beim-updaten-von-windows-188c2b0f-10a7-d72f-65b8-32d177eb136c
echo.
echo Drücken Sie eine beliebige Taste, um das Fortfahren des Prozesses zu bestätigen.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo System Update wird zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
net stop wuauserv
del /f /s /q %systemroot%\SoftwareDistribution\Download >nul
del /f /s /q %systemroot%\WindowsUpdate.log >nul
timeout /t 2 >nul /nobreak
cls

echo System Update wird zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
net stop cryptSvc >nul
net stop bits >nul
net stop msiserver >nul
timeout /t 2 >nul /nobreak
cls

echo System Update wird zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >nul
ren C:\Windows\System32\catroot2 catroot2.old >nul
timeout /t 1 >nul /nobreak
net start wuauserv >nul
net start cryptSvc >nul
net start bits >nul
net start msiserver >nul
timeout /t 1 >nul /nobreak
cls

cls
echo System Update wird zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul


cls
echo Die Einstellungen für Ihre Netzwerke wurden erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen
echo Bitte starten Sie Ihren PC neu, damit die Änderungen vorgenommen werden.

echo.
pause
timeout /t 1 /nobreak >nul
