@echo off
:: ==========================================================
::  ONE COMMAND — ASTRAVEX OS WINDOWS KIT
::  Ruleaza din radacina proiectului: BUILD
:: ==========================================================
setlocal
chcp 65001 >nul 2>&1
echo.
echo  ╔════════════════════════════════════════════════╗
echo  ║  ASTRAVEX OS — WINDOWS KIT                   ║
echo  ║  O comanda face tot Windows-ul                 ║
echo  ╚════════════════════════════════════════════════╝
echo.
if exist AstravexOS\build.cmd (
  cd /d "%~dp0AstravexOS"
  call build.cmd %*
) else (
  echo  [X] Folderul AstravexOS nu exista!
  pause
  exit /b 1
)
endlocal
