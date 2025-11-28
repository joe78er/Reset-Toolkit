@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Diese Batchdatei muss als Administrator ausgeführt werden.
	powershell -Command "Start-Process '%~f0' -Verb runAs"
	exit /b
)


echo Drücken Sie eine beliebige Taste, um mit dem Zurücksetzen vom Windows Defender fortzufahren.
pause >nul
timeout /t 1 /nobreak >nul
cls

echo Windows Defender wird zurückgesetzt ...
echo Fortschritt: [                              ] 0%%	abgeschlossen
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All >nul
timeout /t 4 /nobreak >nul

cls
echo Windows Defender wird zurückgesetzt ...
echo Fortschritt: [=========                     ] 30%%	abgeschlossen
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate >nul
timeout /t 3 /nobreak >nul

cls
echo Windows Defender wird zurückgesetzt ...
echo Fortschritt: [==================            ] 60%%	abgeschlossen
timeout /t 2 /nobreak >nul

cls
echo Windows Defender wird zurückgesetzt ...
echo Fortschritt: [============================= ] 99%%	abgeschlossen
timeout /t 3 /nobreak >nul

cls
echo Der Windows Defender wurde erfolgreich zurückgesetzt.
echo Fortschritt: [==============================] 100%%	abgeschlossen

echo.
pause
timeout /t 1 /nobreak >nul
