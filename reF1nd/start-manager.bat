@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
title Sing-box Manager Launcher
color 0A

:: ===================================================
:: 1. 核心配置区 (路径设置)
:: ===================================================
set "TARGET_DIR=配置路径"
set "SCRIPT_NAME=singbox-manager.ps1"

:: ===================================================
:: 2. 自动提权模块 (VBS Method)
:: ===================================================
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo [INFO] 正在请求管理员权限...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    
    :: 切换到指定目录
    if exist "%TARGET_DIR%" (
        cd /d "%TARGET_DIR%"
    ) else (
        echo [ERROR] 找不到目录: %TARGET_DIR%
        pause
        exit
    )

:: ===================================================
:: 3. 启动逻辑 (带标题参数)
:: ===================================================

if not exist "%SCRIPT_NAME%" (
    echo [ERROR] 未找到 %SCRIPT_NAME%
    pause
    exit
)

echo [INFO] 正在启动 Sing-box Manager...

:: 检测 Windows Terminal
where wt.exe >nul 2>nul
if %errorlevel% equ 0 (
    start "" "wt.exe" -w 0 nt -p "Windows PowerShell" -d "%TARGET_DIR%" --title "Sing-box Manager" powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_NAME%"
    exit
) else (
    echo [INFO] 未检测到 Windows Terminal，使用经典控制台。
    title Sing-box Manager
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_NAME%"
    exit
)