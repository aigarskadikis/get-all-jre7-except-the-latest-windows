@echo off
set path=%path%;%~dp0
set t=%~dp0tmp
if exist "%t%" del "%t%" /Y
md "%t%"
wget http://www.oracle.com/technetwork/java/archive-139210.html -O"%t%\1.log"
for /f %%a in ('^
sed "s/\d034\|\d039\|(\|)/\n/g" "%t%\1.log" ^|
sed "/html/!d;/javase7/!d"') do (
wget http://www.oracle.com%%a -O"%t%\7.log"
)
for /f %%a in ('^
sed "s/\d034\|\d039\|(\|)/\n/g;s/otn/otn-pub/g" "%t%\7.log" ^|
sed "/http/!d;/jre/!d;/x64.exe\|i586.exe/!d"') do (
for /f "tokens=7 delims=/" %%b in ('echo %%a') do (
for /f "tokens=2 delims=-" %%c in ('echo %%b') do (
if not exist "%~dp07\%%c" md "%~dp07\%%c"
wget --no-check-certificate --no-cookies ^
--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" %%a -O "%~dp07\%%c\%%b"
)
)
)
pause
