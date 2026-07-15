@echo off
chcp 65001 >nul
title KIMI_SWING_PRO - Interactive Menu
color 0A
cls

:: Setup output directory
set "OUTPUT_DIR=C:\Deal\Kimi_Swing_Pro"
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%" 2>nul
    if errorlevel 1 (
        set "OUTPUT_DIR=%USERPROFILE%\Documents\Kimi_Swing_Pro"
        mkdir "%OUTPUT_DIR%" 2>nul
        if errorlevel 1 set "OUTPUT_DIR=%CD%"
    )
)
setx KIMI_SWING_OUTPUT "%OUTPUT_DIR%" >nul 2>&1

:MENU
cls
echo ============================================================
echo    KIMI_SWING_PRO - NSE Sector and Swing Trade Scanner
echo    God Mode Edition - Interactive Menu
echo ============================================================
echo    Output: %OUTPUT_DIR%\KIMI_SWING_PRO_*.xlsx
echo.
echo  [1] RUN FULL SCAN - All sectors + top swing trades
echo  [2] SCAN SPECIFIC SECTOR - Focus on one sector only
echo  [3] HIGH-CONFIDENCE TRADES ONLY - Min score 7+
echo  [4] TOP 50 STOCKS - Extended analysis
echo  [5] QUICK SCAN - Top 10 stocks only (fast)
echo  [6] OFFLINE MODE - Use cached data (no internet scrape)
echo  [7] INSTALL / UPDATE DEPENDENCIES
echo  [8] OPEN OUTPUT FOLDER
echo  [0] EXIT
echo.
echo ============================================================
set /p choice="Enter your choice [0-8]: "

if "%choice%"=="1" goto FULL_SCAN
if "%choice%"=="2" goto SECTOR_SCAN
if "%choice%"=="3" goto HIGH_CONFIDENCE
if "%choice%"=="4" goto TOP50_SCAN
if "%choice%"=="5" goto QUICK_SCAN
if "%choice%"=="6" goto OFFLINE_MODE
if "%choice%"=="7" goto INSTALL_DEPS
if "%choice%"=="8" goto OPEN_FOLDER
if "%choice%"=="0" goto EXIT

goto MENU

:FULL_SCAN
cls
echo [MODE] Running FULL SCAN...
echo [OUTPUT] %OUTPUT_DIR%\
echo.
cd /d "%~dp0"
python nse_sector_swing_scanner.py --top-n 25 --min-score 3
goto PAUSE_RETURN

:SECTOR_SCAN
cls
echo Available sectors: IT, BANKING, AUTO, FMCG, PHARMA, OIL_GAS, POWER,
echo METALS_MINING, CEMENT, INFRA, TELECOM, CHEMICALS, CAPITAL_GOODS, RETAIL
echo.
set /p sector="Enter sector code: "
echo.
echo [MODE] Scanning sector: %sector%
echo [OUTPUT] %OUTPUT_DIR%\
cd /d "%~dp0"
python nse_sector_swing_scanner.py --sector %sector% --top-n 30 --min-score 2
goto PAUSE_RETURN

:HIGH_CONFIDENCE
cls
echo [MODE] High-Confidence Trades Only (Score 7+)
echo [OUTPUT] %OUTPUT_DIR%\
echo.
cd /d "%~dp0"
python nse_sector_swing_scanner.py --min-score 7 --top-n 50
goto PAUSE_RETURN

:TOP50_SCAN
cls
echo [MODE] Extended Analysis - Top 50 Stocks
echo [OUTPUT] %OUTPUT_DIR%\
echo.
cd /d "%~dp0"
python nse_sector_swing_scanner.py --top-n 50 --min-score 2
goto PAUSE_RETURN

:QUICK_SCAN
cls
echo [MODE] Quick Scan - Top 10 stocks only
echo [OUTPUT] %OUTPUT_DIR%\
echo.
cd /d "%~dp0"
python nse_sector_swing_scanner.py --top-n 10 --min-score 4
goto PAUSE_RETURN

:OFFLINE_MODE
cls
echo [MODE] Offline Mode - Using cached data
echo (No internet scraping from scanx.trade)
echo [OUTPUT] %OUTPUT_DIR%\
echo.
cd /d "%~dp0"
python nse_sector_swing_scanner.py --no-scrape --top-n 30
goto PAUSE_RETURN

:INSTALL_DEPS
cls
echo [INSTALL] Installing/Updating dependencies...
echo.
python -m pip install --upgrade pip
python -m pip install --upgrade requests beautifulsoup4 pandas numpy yfinance lxml openpyxl
echo.
echo [OK] Dependencies updated!
goto PAUSE_RETURN

:OPEN_FOLDER
cls
echo [OPEN] Launching output folder...
start "" "%OUTPUT_DIR%"
goto PAUSE_RETURN

:PAUSE_RETURN
echo.
echo Press any key to return to menu...
pause >nul
goto MENU

:EXIT
cls
echo Thank you for using KIMI_SWING_PRO!
echo.
echo Output files saved at:
echo   %OUTPUT_DIR%\
echo.
timeout /t 2 >nul
exit /b 0
