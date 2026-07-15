@echo off
chcp 65001 >nul
title KIMI_SWING_PRO - Setup
color 0E
cls

echo ============================================================
echo    KIMI_SWING_PRO - NSE Sector and Swing Trade Scanner
echo    First-Time Setup
echo ============================================================
echo    Output: C:\Deal\Kimi_Swing_Pro\
echo.

:: Create output directory with fallback
set "OUTPUT_DIR=C:\Deal\Kimi_Swing_Pro"
echo [SETUP] Creating output directory...
mkdir "%OUTPUT_DIR%" 2>nul
if errorlevel 1 (
    echo [WARN] Could not create C:\Deal\Kimi_Swing_Pro
echo [INFO] Trying Documents folder...
    set "OUTPUT_DIR=%USERPROFILE%\Documents\Kimi_Swing_Pro"
    mkdir "%OUTPUT_DIR%" 2>nul
    if errorlevel 1 (
        echo [INFO] Using current directory.
        set "OUTPUT_DIR=%CD%"
    ) else (
        echo [OK] Using: %OUTPUT_DIR%
    )
) else (
    echo [OK] Output directory created: %OUTPUT_DIR%
)
setx KIMI_SWING_OUTPUT "%OUTPUT_DIR%" >nul 2>&1
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [FATAL] Python NOT FOUND!
    echo.
    echo Please install Python 3.9 or higher:
    echo   1. Go to https://www.python.org/downloads/
    echo   2. Download Python 3.11 or 3.12
echo   3. During install, CHECK "Add Python to PATH"
    echo   4. Restart this setup
    echo.
    start https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [OK] Python found:
python --version
echo.

:: Upgrade pip
echo [STEP 1/2] Upgrading pip...
python -m pip install --upgrade pip
echo.

:: Install packages
echo [STEP 2/2] Installing required packages...
echo This may take 2-5 minutes depending on your connection...
echo.
python -m pip install requests beautifulsoup4 pandas numpy yfinance lxml openpyxl
echo.

if errorlevel 1 (
    echo [ERROR] Installation failed!
    echo Try running as Administrator.
    pause
    exit /b 1
)

echo [SUCCESS] All dependencies installed!
echo.
echo ============================================================
echo    KIMI_SWING_PRO SETUP COMPLETE
echo ============================================================
echo.
echo Output folder: %OUTPUT_DIR%\
echo.
echo You can now run the scanner using:
echo   run_scanner.bat              - Simple one-click run
echo   run_scanner_interactive.bat  - Menu-driven interface
echo.
echo Press any key to exit...
pause >nul
