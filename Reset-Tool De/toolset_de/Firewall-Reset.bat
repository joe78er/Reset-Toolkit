@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)

echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen von den Firewall-Einstellungen fortzufahren.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Firewall-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
netsh advfirewall reset >nul
timeout /t 4 /nobreak >nul

cls
echo Firewall-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
netsh advfirewall set allprofiles state on >nul
timeout /t 4 /nobreak >nul

cls
echo Firewall-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
netsh advfirewall firewall delete rule name=all >nul
timeout /t 4 /nobreak >nul

cls
echo Firewall-Einstellungen werden zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul

cls
echo Die Einstellungen für Ihre Firewall wurden erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen
echo Bitte starten Sie Ihren PC neu, damit die Änderungen vorgenommen werden.

echo.
pause
timeout /t 1 /nobreak >nul

rem Optional - Anzeigen von aktuellen Status der Firewall für alle Netzwerkprofile:"netsh advfirewall show allprofiles"
