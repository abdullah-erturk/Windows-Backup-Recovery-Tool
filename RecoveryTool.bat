@echo off
title Windows Backup ^& Recovery Tool ^| made by Abdullah ERTURK
setlocal enabledelayedexpansion
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo.
    echo.
    echo      Yînetici yetkileriyle yeniden baülatçlçyor
    echo      Restarting with administrator privileges
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
echo.

cd /d "%~dp0"

REM ========================================================
REM Environment Detection
REM ========================================================
set "ENV=ONLINE"
reg query "HKLM\System\CurrentControlSet\Control\MiniNT" >nul 2>&1
if %errorlevel% equ 0 set "ENV=OFFLINE"

REM ========================================================
REM Language Detection
REM ========================================================
set "LANG=EN" REM Default to English

if "!ENV!"=="ONLINE" (
    REM Online: Use PowerShell detection
    powershell -NoProfile -Command "exit 0" >nul 2>&1
    if !errorlevel! equ 0 (
        powershell -NoProfile -Command "(Get-UICulture).Name" 2>nul | findstr /i "tr-TR" >nul
        if !errorlevel! equ 0 set "LANG=TR"
    )
) else (
    REM Offline (WinPE): Use Registry detection (No PowerShell)
    REM 041F is the LCID for Turkish
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage 2>nul | findstr "041F" >nul
    if !errorlevel! equ 0 set "LANG=TR"
)

REM ========================================================
REM Language Dictionary
REM ========================================================
if "!LANG!"=="TR" (
    set "TITLE_MAIN=Windows Backup and Recovery Tool"
    set "OPT_1=1. Windows'u Yedekle (WIM olustur)"
    set "OPT_2=2. Windows'u Geri YÅkle"
    set "OPT_3=3. ÄIKIû"
    set "MSG_CHOICE=Seáiminiz"
    set "ERR_FILE_NOT_FOUND=Hata: Dosya bulunamadç!"
    set "MSG_ENTER=Devam etmek iáin ENTER tusuna basçn..."
) else (
    set "TITLE_MAIN=Windows Backup and Recovery Tool"
    set "OPT_1=1. Backup Windows (Create WIM)"
    set "OPT_2=2. Restore Windows"
    set "OPT_3=3. EXIT"
    set "MSG_CHOICE=Your Choice"
    set "ERR_FILE_NOT_FOUND=Error: File not found!"
    set "MSG_ENTER=Press ENTER to continue..."
)

REM ========================================================
REM Main Menu Loop
REM ========================================================
:menu
cls
color e
echo.
echo.
echo =================================================================
echo            	!TITLE_MAIN!
echo =================================================================
echo.
echo     	erturk.netlify.app ^| github.com/abdullah-erturk
echo.
echo			!OPT_1!
echo.
echo			!OPT_2!
echo.
echo			!OPT_3!
echo.
echo =================================================================
echo.
<nul set /p="!MSG_CHOICE! (1-2-3): "
choice /c 123 /n >nul

if errorlevel 3 exit
if errorlevel 2 goto :restore
if errorlevel 1 goto :backup

goto :menu

REM ========================================================
REM Actions
REM ========================================================
:backup
cls
set "SCRIPT_PATH=bin\imagecapture.bat"
if not exist "!SCRIPT_PATH!" (
    echo.
    echo !ERR_FILE_NOT_FOUND!
    echo File: !SCRIPT_PATH!
    echo.
    echo !MSG_ENTER!
    pause >nul
    goto :menu
)
call "!SCRIPT_PATH!"
echo.
echo !MSG_ENTER!
pause >nul
goto :menu

:restore
cls
set "SCRIPT_PATH=bin\imagerestore.bat"
if not exist "!SCRIPT_PATH!" (
    echo.
    echo !ERR_FILE_NOT_FOUND!
    echo File: !SCRIPT_PATH!
    echo.
    echo !MSG_ENTER!
    pause >nul
    goto :menu
)
call "!SCRIPT_PATH!"
echo.
echo !MSG_ENTER!
pause >nul
goto :menu