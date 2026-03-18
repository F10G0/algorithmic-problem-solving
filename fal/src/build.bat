@echo off
setlocal

gcc -O2 -Wall -Wextra -std=c11 -o fal.exe fal.c

if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

echo Build succeeded: fal.exe
endlocal
