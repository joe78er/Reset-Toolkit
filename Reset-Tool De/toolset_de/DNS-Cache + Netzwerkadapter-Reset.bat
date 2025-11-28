@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)


echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen von der DNS-Cache und dem Netzwerkadapter fortzufahren.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo DNS-Cache und Netzwerkadapter werden zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
ipconfig /flushdns >nul
ipconfig /release >nul
ipconfig /renew >nul
timeout /t 2 /nobreak >nul

cls
echo DNS-Cache und Netzwerkadapter werden zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
netsh interface set interface "LAN-Verbindung" admin=disable >nul
timeout /t 4 /nobreak >nul

cls
echo DNS-Cache und Netzwerkadapter werden zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
netsh interface set interface "LAN-Verbindung" admin=enable >nul
timeout /t 4 /nobreak >nul

cls
echo DNS-Cache und Netzwerkadapter werden zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul

cls
echo Die DNS-Cache und das Netzwerkadapter wurden erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen

echo.
pause
timeout /t 1 /nobreak >nul
