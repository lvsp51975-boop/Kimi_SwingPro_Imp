@echo off
chcp 65001 >nul
title KIMI_SWING_PRO - NSE Sector and Swing Trade Scanner
color 0A
cls

echo ============================================================
echo    KIMI_SWING_PRO - NSE Sector and Swing Trade Scanner
echo    God Mode Edition
echo ============================================================
echo    Output: C:\Deal\Kimi_Swing_Pro\KIMI_SWING_PRO_*.xlsx
echo.

:: Create output directory (try multiple locations)
set "OUTPUT_DIR=C:\Deal\Kimi_Swing_Pro"
if not exist "%OUTPUT_DIR%" (
    echo [SETUP] Creating output directory...
    mkdir "%OUTPUT_DIR%" 2>nul
    if errorlevel 1 (
        echo [WARN] Could not create C:\Deal\Kimi_Swing_Pro
echo [INFO] Trying user Documents folder...
        set "OUTPUT_DIR=%USERPROFILE%\Documents\Kimi_Swing_Pro"
        mkdir "%OUTPUT_DIR%" 2>nul
        if errorlevel 1 (
            echo [INFO] Falling back to current directory.
            set "OUTPUT_DIR=%CD%"
        ) else (
            echo [OK] Using: %OUTPUT_DIR%
        )
    ) else (
        echo [OK] Output directory ready: %OUTPUT_DIR%
    )
)
setx KIMI_SWING_OUTPUT "%OUTPUT_DIR%" >nul 2>&1
echo.

:: Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH!
    echo Please install Python 3.9+ from https://python.org
    echo.
    pause
    exit /b 1
)

echo [OK] Python detected.
python --version
echo.

:: Check if required packages are installed
echo [CHECK] Verifying dependencies...
python -c "import requests, bs4, pandas, numpy, yfinance, openpyxl" 2>nul
if errorlevel 1 (
    echo [INFO] Installing required packages...
    echo This may take a few minutes on first run...
    echo.
    python -m pip install --upgrade pip
    python -m pip install requests beautifulsoup4 pandas numpy yfinance lxml openpyxl
    if errorlevel 1 (
        echo [ERROR] Failed to install packages!
        echo Try running: pip install requests beautifulsoup4 pandas numpy yfinance lxml openpyxl
        pause
        exit /b 1
    )
) else (
    echo [OK] All dependencies satisfied.
)
echo.

:: Set working directory to script location
cd /d "%~dp0"

:: Run the scanner with default settings
echo ============================================================
echo    RUNNING KIMI_SWING_PRO
echo    (Full sector analysis + top swing trades)
echo ============================================================
echo.
python nse_sector_swing_scanner.py

echo.
echo ============================================================
echo    KIMI_SWING_PRO SCAN COMPLETE
echo ============================================================
echo.
echo Press any key to exit...
pause >nul
