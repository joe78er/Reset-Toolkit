@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)

echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen von der Druckerwarteschlange fortzufahren.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Druckerwarteschlange wird zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
net stop spooler >nul
timeout /t 4 /nobreak >nul

cls
echo Druckerwarteschlange wird zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
del /Q /F %systemroot%\System32\spool\PRINTERS\* >nul
timeout /t 4 /nobreak >nul

cls
echo Druckerwarteschlange wird zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
net start spooler >nul
timeout /t 4 /nobreak >nul

cls
echo Druckerwarteschlange wird zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul

cls
echo Die Druckerwarteschlange wurde erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen
echo Bitte starten Sie Ihren PC neu, damit die Änderungen vorgenommen werden.

echo.
pause
timeout /t 1 /nobreak >nul
