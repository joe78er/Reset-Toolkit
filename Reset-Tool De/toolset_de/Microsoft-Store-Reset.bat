@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)

echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen vom Microsoft Store fortzufahren.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Microsoft Store wird zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
sc config ClipSVC start= auto >nul
sc config AppXSvc start= auto >nul
timeout /t 4 /nobreak >nul

cls
echo Microsoft Store wird zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
net start ClipSVC >nul
net start AppXSvc >nul
timeout /t 4 /nobreak >nul

cls
echo Microsoft Store wird zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
wsreset.exe >nul
timeout /t 4 /nobreak >nul

cls
echo Microsoft Store wird zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul

cls
echo Der Microsoft Store wurde erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen
echo Bitte starten Sie Ihren PC neu, damit die Änderungen vorgenommen werden.

echo.
pause
timeout /t 1 /nobreak >nul
