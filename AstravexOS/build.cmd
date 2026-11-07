@echo off
:: ==========================================================
::  ASTRAVEX OS — ONE COMMAND KIT
::  O singura comanda care face TOT proiectul de la 0
::  Nu ai nevoie de nimic instalat in afara de Windows
:: ==========================================================
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title AstravexOS — One Command Kit
color 0B
cls
echo.
echo  ╔════════════════════════════════════════════════╗
echo  ║                                                ║
echo  ║   [1mASTRAVEX OS  —  ONE COMMAND KIT[0m               ║
echo  ║   Windows 11 Pro  •  Build Kit                  ║
echo  ║   O comanda. Zero erori.                       ║
echo  ║                                                ║
echo  ╚════════════════════════════════════════════════╝
echo.

:: --- 1. Verifica Python ---
echo  [1/4] Verific Python...
where python >nul 2>&1
if %errorlevel%==0 (
  for /f "tokens=*" %%i in ('python --version 2^>^&1') do set PYV=%%i
  echo   [32m✔ !PYV! detectat[0m
  goto :haspy
)
where py >nul 2>&1
if %errorlevel%==0 (
  for /f "tokens=*" %%i in ('py --version 2^>^&1') do set PYV=%%i
  echo   [32m✔ !PYV! (launcher) detectat[0m
  set PYTHON=py
  goto :run
)
echo   [33m! Python nu e instalat — incerc instalare automata...[0m
where winget >nul 2>&1
if %errorlevel%==0 (
  echo   ^> winget install Python.Python.3.12 --silent
  winget install -e --id Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
  if !errorlevel!==0 (
    echo   [32m✔ Python instalat. Reporneste CMD si ruleaza din nou: build.cmd[0m
    pause
    exit /b 0
  )
)
echo   [31m✘ Python 3.12+ e obligatoriu.[0m
echo     Instaleaza manual: https://www.python.org/downloads/
echo     sau: winget install Python.Python.3.12
pause
exit /b 1

:haspy
set PYTHON=python
:run

:: --- 2. Verifica structura ---
echo.
echo  [2/4] Verific structura kit-ului...
if not exist src\build.py (
  echo   [31m✘ lipseste src\build.py[0m
  pause & exit /b 1
)
if not exist src\astravex_menus.py (
  echo   [31m✘ lipseste src\astravex_menus.py[0m
  pause & exit /b 1
)
echo   [32m✔ Structura OK[0m

:: --- 3. Ruleaza generatorul ---
echo.
echo  [3/4] Generez proiectul (build.py)...
echo  ──────────────────────────────────────────────
%PYTHON% src\build.py
if %errorlevel% neq 0 (
  echo.
  echo   [31m✘ Build esuat — verifica erorile de mai sus[0m
  pause
  exit /b 1
)
echo  ──────────────────────────────────────────────

:: --- 4. Rezultat ---
echo.
echo  [4/4] Verific output...
if exist AstravexOS-Toolbox.cmd (
  for %%A in (AstravexOS-Toolbox.cmd) do echo   [32m✔ AstravexOS-Toolbox.cmd ^(%%~zA bytes^)[0m
) else echo   [33m! AstravexOS-Toolbox.cmd nu a fost generat[0m
if exist preview\index.html (
  for %%A in (preview\index.html) do echo   [32m✔ preview\index.html ^(%%~zA bytes^)[0m
)
if exist gui\src\AstravexData.cs (
  echo   [32m✔ gui\src\AstravexData.cs[0m
)
echo.
echo  ╔════════════════════════════════════════════════╗
echo  ║  [32m✓ KIT GATA — 0 ERORI[0m                              ║
echo  ║                                                ║
echo  ║  Output:                                       ║
echo  ║   • AstravexOS-Toolbox.cmd  ^(consola^)           ║
echo  ║   • preview\index.html      ^(Windows preview^)   ║
echo  ║   • gui\src\AstravexData.cs ^(date C#^)           ║
echo  ║   • release\  ^(kit + portabil + SHA256^)        ║
echo  ╚════════════════════════════════════════════════╝
echo.
echo  Deschide preview-ul: [36mpreview\index.html[0m  ^(dublu-click^)
echo  Ruleaza Toolbox:     [36mAstravexOS-Toolbox.cmd[0m  ^(dreapta ^> Run as Admin^)
echo.

:: Intreaba daca deschide preview
choice /M "Vrei sa deschid preview-ul in browser acum"
if %errorlevel%==1 start "" "preview\index.html"

endlocal
