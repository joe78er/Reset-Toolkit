@echo off

cls
echo Beenden von Explorer.exe ...
taskkill /f /im explorer.exe >nul
del /f /q "%localappdata%\IconCache.db" >nul
timeout /t 1 /nobreak >nul

cls
echo Starten von Explorer.exe ...
start explorer.exe >nul
timeout /t 1 /nobreak >nul

cls
echo Explorer wurde erfolgreich neu gestartet.
pause
timeout /t 1 /nobreak >nul