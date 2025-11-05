@echo off
setlocal enabledelayedexpansion

set "delimiter=."
SET /P Network ID=Please enter your desired Network ID: (e.g 169.254.58.0) 
echo Scanning, %Network ID%! ...
echo ====================================

rem parse first three octets
for /f "tokens=1-4 delims=." %%a in ("%Network ID%") do (
    set "o1=%%a"
    set "o2=%%b"
    set "o3=%%c"
)

if "%o3%"=="" (
    echo Invalid input: %NetworkID%
    pause
    exit /b
)

set "base=%o1%.%o2%.%o3%"

for /L %%i in (2,1,255) do (
    set "IP=%base%.%%i"
    <nul set /p= Pinging !IP! ...   ::
    ping -n 1 -w 200 !IP! >nul
    if !errorlevel! equ 0 (
	echo [[32mUP[0m]
    ) else (
        echo [[31mDOWN[0m]
    )
)

echo ====================================
echo Scan complete.
pause





