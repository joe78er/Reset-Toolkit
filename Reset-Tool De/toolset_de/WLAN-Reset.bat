@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)

echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen von den Netzwerk-Einstellungen fortzufahren.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Netzwerk-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
netsh winsock reset >nul
netsh winhttp reset proxy >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f 2>nul
timeout /t 4 /nobreak >nul
cls

echo Netzwerk-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
netsh int ip reset >nul
timeout /t 4 /nobreak >nul

cls
echo Netzwerk-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
netsh advfirewall reset >nul
timeout /t 4 /nobreak >nul

cls
echo Netzwerk-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul

cls
echo Die Einstellungen für Ihre Netzwerke wurden erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen
echo Bitte starten Sie Ihren PC neu, damit die Änderungen vorgenommen werden.

echo.
pause
timeout /t 1 /nobreak >nul

rem Optional - WLAN-Profile löschen:		'netsh wlan delete profile name="Profilname"'
rem Optional - Alle WLAN-Profile löschen:	'netsh wlan delete profile name=*'
