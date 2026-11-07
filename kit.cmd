@echo off
:: ============================================
:: ABC PLAY — ONE COMMAND KIT (Windows CMD)
:: Doar deschizi CMD aici si scrii:  kit
:: Face TOT: verifica Node, instaleaza, repara, porneste
:: ============================================
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title ABC Play — One Command Kit
color 0B
cls
echo.
echo  ╔══════════════════════════════════════════╗
echo  ║     ABC PLAY — ONE COMMAND KIT         ║
echo  ║     O comanda. Zero erori.             ║
echo  ╚══════════════════════════════════════════╝
echo.

:: 1 — Verifica Node.js
where node >nul 2>&1
if %errorlevel% neq 0 (
  echo  [X] Node.js nu este instalat!
  echo      Instaleaza automat cu winget sau manual:
  echo        winget install OpenJS.NodeJS.LTS
  echo      Apoi redeschide CMD si ruleaza din nou: kit
  echo.
  :: incearca instalare automata daca winget exista
  where winget >nul 2>&1
  if %errorlevel%==0 (
    echo  [?] Incerc instalare automata Node.js LTS...
    winget install -e --id OpenJS.NodeJS.LTS --silent --accept-package-agreements --accept-source-agreements
    if %errorlevel%==0 (
      echo  [OK] Node.js instalat. Inchide si redeschide CMD, apoi ruleaza din nou: kit
    )
  )
  pause
  exit /b 1
)
for /f "tokens=*" %%i in ('node -v') do set NODEV=%%i
echo  [OK] Node %NODEV% detectat

where npm >nul 2>&1
if %errorlevel% neq 0 (
  echo  [X] npm lipseste! Reinstaleaza Node.js de la https://nodejs.org
  pause
  exit /b 1
)
for /f "tokens=*" %%i in ('npm -v') do set NPMV=%%i
echo  [OK] npm %NPMV% detectat
echo.

:: 2 — Ruleaza kit-ul Node (face restul)
echo  ──────────────────────────────────────────
echo   Pornesc kit-ul complet (poate dura 1-3 min prima data)...
echo  ──────────────────────────────────────────
echo.

:: Alege flag: daca argumentul e --go, porneste si Expo
if /i "%~1"=="--go" (
  node scripts\kit.js --start
) else if /i "%~1"=="go" (
  node scripts\kit.js --start
) else (
  node scripts\kit.js
)

if %errorlevel% neq 0 (
  echo.
  echo  [X] Kit-ul a intampinat o eroare. Verifica mesajele de mai sus.
  echo      Incearca: npm install --legacy-peer-deps
  pause
  exit /b 1
)

echo.
echo  ──────────────────────────────────────────
echo   GATA! Comenzi utile:
echo     npm start        - porneste Expo (QR telefon)
echo     npm run web      - deschide in browser
echo     kit --go         - kit + pornire automata
echo  ──────────────────────────────────────────
echo.
if /i "%~1"=="--go" goto :eof
if /i "%~1"=="go" goto :eof
choice /M "Vrei sa pornesc Expo acum"
if %errorlevel%==1 (
  echo.
  npx expo start
)
endlocal
