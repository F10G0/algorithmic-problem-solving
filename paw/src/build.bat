@echo off
setlocal

gcc -O2 -Wall -Wextra -std=c11 -o paw.exe paw.c

if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

echo Build succeeded: paw.exe
endlocal
