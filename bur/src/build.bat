@echo off
setlocal

gcc -O2 -Wall -Wextra -std=c11 -o bur.exe bur.c

if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

echo Build succeeded: bur.exe
endlocal
