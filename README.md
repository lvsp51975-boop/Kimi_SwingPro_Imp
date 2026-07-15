# Kimi_SwingPro_Imp

NSE Sector & Swing Trade Scanner — God Mode Edition

## Features
- Auto-scrapes scanx.trade top deliveries
- Sector momentum ranking (14 sectors)
- Full technical analysis: EMA, RSI, MACD, ATR, BB, ADX, OBV, Stochastic
- Swing trade scoring with Entry / SL / TP1 / TP2
- Excel report with 6 sheets
- Email delivery to lvsp51975@gmail.com after every scan

## GitHub Actions (Auto Schedule)
Runs Mon–Sat at 10:00 AM IST. Excel sent to email automatically.

## GitHub Secrets Required
| Secret | Value |
|--------|-------|
| `EMAIL_FROM` | Your Gmail ID |
| `EMAIL_PASSWORD` | Gmail App Password |

## Local Usage
```
setup.bat                    # First time install
run_scanner.bat              # One-click run
run_scanner_interactive.bat  # Menu-driven
```

## Manual Python
```
python nse_sector_swing_scanner.py
python nse_sector_swing_scanner.py --sector IT --min-score 5
python nse_sector_swing_scanner.py --top-n 50
```

## Output
`C:\Deal\Kimi_Swing_Pro\KIMI_SWING_PRO_YYYYMMDD_HHMMSS.xlsx`

Sheets: Scan_Info | Sector_Analysis | All_Swing_Trades | BULLISH_Signals | BEARISH_Signals | TOP_PICKS
