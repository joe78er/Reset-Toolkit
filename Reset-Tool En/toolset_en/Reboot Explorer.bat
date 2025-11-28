@echo off

cls
echo Terminating Explorer.exe ...
taskkill /f /im explorer.exe >nul
del /f /q "%localappdata%\IconCache.db" >nul
timeout /t 1 /nobreak >nul

cls
echo Starting Explorer.exe ...
start explorer.exe >nul
timeout /t 1 /nobreak >nul

cls
echo Explorer has been successfully restarted.
pause
timeout /t 1 /nobreak >nul