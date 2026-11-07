@echo off
:: AstravexOS Toolbox — generat automat de src/build.py
:: Nu edita manual! Editeaza src/astravex_menus.py si ruleaza build.cmd
chcp 65001 >nul 2>&1
setlocal EnableDelayedExpansion
title AstravexOS Toolbox
color 0B
net session >nul 2>&1 || (echo  [X] Ruleaza ca Administrator! & pause & exit /b 1)

:banner
cls
echo.
echo   [36m    _    ____ _____ ____      ___     _______  __[0m
echo   [36m   / \  / ___^|_   _^|  _ \    / \ \   / / ____\ \/ /[0m
echo   [35m  / _ \ \___ \ ^| ^| ^| ^|_) ^|  / _ \ \ / /^|  _^|  \  / [0m
echo   [35m / ___ \ ___) ^| ^| ^|  _ ^<  / ___ \ V / ^| ^|___ /  \ [0m
echo   [34m/_/   \_\____/ ^|_^| ^|_^| \_\/_/   \_\_/  \____/_/\_\[0m
echo   [2m             Windows 11 Pro  •  Toolbox  v1.2.0[0m
echo.

:log
echo   [2m[%date% %time%] %* ^>^> "%ProgramData%\Astravex\astravex.log"[0m
goto :eof

:MENU_MAIN
call :banner
echo   [1mASTRAVEX TOOLBOX[0m
echo   [2mAlege o optiune — tasteaza numarul si apasa Enter[0m
echo   [2m──────────────────────────────────────────────[0m
echo.
echo    [36m[1][0m Action Center & Notificari
echo    [36m[2][0m Cortana + Copilot + Recall
echo    [36m[3][0m Print Spooler (imprimante)
echo    [36m[4][0m Windows Security / Defender
echo    [36m[5][0m Hibernare / Fast Boot
echo    [36m[6][0m Pagefile (memorie virtuala)
echo    [36m[7][0m Take Ownership (meniu click-dreapta)
echo    [36m[8][0m Windows Update
echo    [36m[9][0m Compact OS + LZX
echo    [36m[10][0m Microsoft Store + Xbox
echo    [36m[11][0m Xbox Game Bar / Game DVR
echo    [36m[12][0m Browsere (winget)
echo    [36m[13][0m VC++ & DirectX
echo    [36m[14][0m OneDrive
echo    [36m[15][0m Aplicatii populare (30)
echo    [36m[16][0m Microsoft Store UWP
echo    [36m[17][0m .NET & Runtimes
echo    [36m[18][0m Astravex Personalize (tema)
echo    [36m[19][0m Tweaks Privacy / Telemetrie
echo    [36m[20][0m Android (WSA) + WSL
echo    [36m[24][0m Ghost Personalize → Astravex Personalize
echo    [36m[42][0m Windows 11 Tweaks
echo.
echo    [2m[0] Inapoi  ^|  [X] Iesire[0m
echo.
set /p choice="  Alege ^> "
if "%choice%"=="0" goto :MENU_MAIN
if /I "%choice%"=="X" exit /b 0
if /I "%choice%"=="x" exit /b 0
if "%choice%"=="1" goto :DO_MAIN_1
if "%choice%"=="2" goto :DO_MAIN_2
if "%choice%"=="3" goto :DO_MAIN_3
if "%choice%"=="4" goto :DO_MAIN_4
if "%choice%"=="5" goto :DO_MAIN_5
if "%choice%"=="6" goto :DO_MAIN_6
if "%choice%"=="7" goto :DO_MAIN_7
if "%choice%"=="8" goto :DO_MAIN_8
if "%choice%"=="9" goto :DO_MAIN_9
if "%choice%"=="10" goto :DO_MAIN_10
if "%choice%"=="11" goto :DO_MAIN_11
if "%choice%"=="12" goto :DO_MAIN_12
if "%choice%"=="13" goto :DO_MAIN_13
if "%choice%"=="14" goto :DO_MAIN_14
if "%choice%"=="15" goto :DO_MAIN_15
if "%choice%"=="16" goto :DO_MAIN_16
if "%choice%"=="17" goto :DO_MAIN_17
if "%choice%"=="18" goto :DO_MAIN_18
if "%choice%"=="19" goto :DO_MAIN_19
if "%choice%"=="20" goto :DO_MAIN_20
if "%choice%"=="24" goto :DO_MAIN_24
if "%choice%"=="42" goto :DO_MAIN_42
echo   [33m  ! Optiune invalida[0m & timeout /t 1 >nul & goto :MENU_MAIN

:DO_MAIN_1
echo.
echo   [1mAction Center & Notificari[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Dezactiveaza Action Center
echo    [35m[2][0m Activeaza Action Center
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_1_1
if "%sub%"=="2" goto :DO_MAIN_1_2
goto :DO_MAIN_1
:DO_MAIN_1_1
echo   [36m  ^> Dezactiveaza Action Center...[0m
call :log "Dezactiveaza Action Center"
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment la: REG[0m
sc config WpnService start= disabled >nul & sc stop WpnService >nul 2>&1 || echo   [33m  ! Avertisment la: SVC[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_1_2
echo   [36m  ^> Activeaza Action Center...[0m
call :log "Activeaza Action Center"
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment la: REG[0m
sc config WpnService start= demand >nul || echo   [33m  ! Avertisment la: SVC[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_2
echo.
echo   [1mCortana + Copilot + Recall[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Dezactiveaza Cortana / Copilot
echo    [35m[2][0m Activeaza Copilot
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_2_1
if "%sub%"=="2" goto :DO_MAIN_2_2
goto :DO_MAIN_2
:DO_MAIN_2_1
echo   [36m  ^> Dezactiveaza Cortana / Copilot...[0m
call :log "Dezactiveaza Cortana / Copilot"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Copilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment la: REG[0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_2_2
echo   [36m  ^> Activeaza Copilot...[0m
call :log "Activeaza Copilot"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Copilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_3
echo.
echo   [1mPrint Spooler (imprimante)[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Activeaza Print Spooler
echo    [35m[2][0m Dezactiveaza Print Spooler
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_3_1
if "%sub%"=="2" goto :DO_MAIN_3_2
goto :DO_MAIN_3
:DO_MAIN_3_1
echo   [36m  ^> Activeaza Print Spooler...[0m
call :log "Activeaza Print Spooler"
sc config Spooler start= auto >nul & sc start Spooler >nul 2>&1 || echo   [33m  ! Avertisment la: SVC[0m
net start Spooler || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_3_2
echo   [36m  ^> Dezactiveaza Print Spooler...[0m
call :log "Dezactiveaza Print Spooler"
sc config Spooler start= disabled >nul & sc stop Spooler >nul 2>&1 || echo   [33m  ! Avertisment la: SVC[0m
net stop Spooler /y || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_4
echo.
echo   [1mWindows Security / Defender[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Opreste Defender (SUPERLITE W/O DEF)
echo    [35m[2][0m Activeaza Defender
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_4_1
if "%sub%"=="2" goto :DO_MAIN_4_2
goto :DO_MAIN_4
:DO_MAIN_4_1
echo   [36m  ^> Opreste Defender (SUPERLITE W/O DEF)...[0m
call :log "Opreste Defender (SUPERLITE W/O DEF)"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue" || echo   [33m  ! Avertisment la: PS[0m
sc config WinDefend start= disabled >nul & sc stop WinDefend >nul 2>&1 || echo   [33m  ! Avertisment la: SVC[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_4_2
echo   [36m  ^> Activeaza Defender...[0m
call :log "Activeaza Defender"
sc config WinDefend start= auto >nul & sc start WinDefend >nul 2>&1 || echo   [33m  ! Avertisment la: SVC[0m
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $false" || echo   [33m  ! Avertisment la: PS[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_5
echo.
echo   [1mHibernare / Fast Boot[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Dezactiveaza Hibernare
echo    [35m[2][0m Activeaza Hibernare
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_5_1
if "%sub%"=="2" goto :DO_MAIN_5_2
goto :DO_MAIN_5
:DO_MAIN_5_1
echo   [36m  ^> Dezactiveaza Hibernare...[0m
call :log "Dezactiveaza Hibernare"
powercfg /hibernate off || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_5_2
echo   [36m  ^> Activeaza Hibernare...[0m
call :log "Activeaza Hibernare"
powercfg /hibernate on || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_6
echo.
echo   [1mPagefile (memorie virtuala)[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Pagefile automat
echo    [35m[2][0m Pagefile dezactivat (SSD rapid)
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_6_1
if "%sub%"=="2" goto :DO_MAIN_6_2
goto :DO_MAIN_6
:DO_MAIN_6_1
echo   [36m  ^> Pagefile automat...[0m
call :log "Pagefile automat"
wmic computersystem where name='%computername%' set AutomaticManagedPagefile=True || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_6_2
echo   [36m  ^> Pagefile dezactivat (SSD rapid)...[0m
call :log "Pagefile dezactivat (SSD rapid)"
wmic computersystem where name='%computername%' set AutomaticManagedPagefile=False || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_7
echo.
echo   [1mTake Ownership (meniu click-dreapta)[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Instaleaza Take Ownership
echo    [35m[2][0m Elimina Take Ownership
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_7_1
if "%sub%"=="2" goto :DO_MAIN_7_2
goto :DO_MAIN_7
:DO_MAIN_7_1
echo   [36m  ^> Instaleaza Take Ownership...[0m
call :log "Instaleaza Take Ownership"
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /v "" /t REG_SZ /d "Take Ownership" /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_7_2
echo   [36m  ^> Elimina Take Ownership...[0m
call :log "Elimina Take Ownership"
reg delete "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /f || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_8
echo.
echo   [1mWindows Update[0m
echo   [2m3 actiuni disponibile:[0m
echo    [35m[1][0m Pauza Update pana in 2077
echo    [35m[2][0m Reia Update-urile
echo    [35m[3][0m Blocheaza upgrade de versiune ( ramai pe 24H2/25H2 )
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_8_1
if "%sub%"=="2" goto :DO_MAIN_8_2
if "%sub%"=="3" goto :DO_MAIN_8_3
goto :DO_MAIN_8
:DO_MAIN_8_1
echo   [36m  ^> Pauza Update pana in 2077...[0m
call :log "Pauza Update pana in 2077"
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2026-11-07T00:00:00Z" /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_8_2
echo   [36m  ^> Reia Update-urile...[0m
call :log "Reia Update-urile"
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseUpdatesStartTime /f 2>nul || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_8_3
echo   [36m  ^> Blocheaza upgrade de versiune ( ramai pe 24H2/25H2 )...[0m
call :log "Blocheaza upgrade de versiune ( ramai pe 24H2/25H2 )"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersion" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_9
echo.
echo   [1mCompact OS + LZX[0m
echo   [2m3 actiuni disponibile:[0m
echo    [35m[1][0m Activeaza Compact OS
echo    [35m[2][0m LZX pe Program Files
echo    [35m[3][0m Decomprima tot
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_9_1
if "%sub%"=="2" goto :DO_MAIN_9_2
if "%sub%"=="3" goto :DO_MAIN_9_3
goto :DO_MAIN_9
:DO_MAIN_9_1
echo   [36m  ^> Activeaza Compact OS...[0m
call :log "Activeaza Compact OS"
compact.exe /CompactOS:always || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_9_2
echo   [36m  ^> LZX pe Program Files...[0m
call :log "LZX pe Program Files"
compact /c /exe:lzx "C:\Program Files\*.*" || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_9_3
echo   [36m  ^> Decomprima tot...[0m
call :log "Decomprima tot"
compact /CompactOS:never || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_10
echo.
echo   [1mMicrosoft Store + Xbox[0m
echo   [2m3 actiuni disponibile:[0m
echo    [35m[1][0m Reinstaleaza Store
echo    [35m[2][0m Instaleaza Xbox App (winget)
echo    [35m[3][0m Elimina Xbox Game Bar
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_10_1
if "%sub%"=="2" goto :DO_MAIN_10_2
if "%sub%"=="3" goto :DO_MAIN_10_3
goto :DO_MAIN_10
:DO_MAIN_10_1
echo   [36m  ^> Reinstaleaza Store...[0m
call :log "Reinstaleaza Store"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ""$($_.InstallLocation)\AppXManifest.xml""}" || echo   [33m  ! Avertisment la: PS[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_10_2
echo   [36m  ^> Instaleaza Xbox App (winget)...[0m
call :log "Instaleaza Xbox App (winget)"
winget install -e --id Microsoft.GamingStore --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_10_3
echo   [36m  ^> Elimina Xbox Game Bar...[0m
call :log "Elimina Xbox Game Bar"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage" || echo   [33m  ! Avertisment la: PS[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_11
echo.
echo   [1mXbox Game Bar / Game DVR[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Dezactiveaza Game DVR
echo    [35m[2][0m Activeaza Game Bar
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_11_1
if "%sub%"=="2" goto :DO_MAIN_11_2
goto :DO_MAIN_11
:DO_MAIN_11_1
echo   [36m  ^> Dezactiveaza Game DVR...[0m
call :log "Dezactiveaza Game DVR"
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_11_2
echo   [36m  ^> Activeaza Game Bar...[0m
call :log "Activeaza Game Bar"
winget install -e --id Microsoft.XboxGamingOverlay --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_12
echo.
echo   [1mBrowsere (winget)[0m
echo   [2m4 actiuni disponibile:[0m
echo    [35m[1][0m Instaleaza Chrome
echo    [35m[2][0m Instaleaza Firefox
echo    [35m[3][0m Instaleaza Brave
echo    [35m[4][0m Instaleaza Edge
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_12_1
if "%sub%"=="2" goto :DO_MAIN_12_2
if "%sub%"=="3" goto :DO_MAIN_12_3
if "%sub%"=="4" goto :DO_MAIN_12_4
goto :DO_MAIN_12
:DO_MAIN_12_1
echo   [36m  ^> Instaleaza Chrome...[0m
call :log "Instaleaza Chrome"
winget install -e --id Google.Chrome --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_12_2
echo   [36m  ^> Instaleaza Firefox...[0m
call :log "Instaleaza Firefox"
winget install -e --id Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_12_3
echo   [36m  ^> Instaleaza Brave...[0m
call :log "Instaleaza Brave"
winget install -e --id Brave.Brave --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_12_4
echo   [36m  ^> Instaleaza Edge...[0m
call :log "Instaleaza Edge"
winget install -e --id Microsoft.Edge --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_13
echo.
echo   [1mVC++ & DirectX[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m VC++ AIO (toate versiunile)
echo    [35m[2][0m DirectX Web Installer
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_13_1
if "%sub%"=="2" goto :DO_MAIN_13_2
goto :DO_MAIN_13
:DO_MAIN_13_1
echo   [36m  ^> VC++ AIO (toate versiunile)...[0m
call :log "VC++ AIO (toate versiunile)"
winget install -e --id Microsoft.VCRedist.2015+.x64 --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_13_2
echo   [36m  ^> DirectX Web Installer...[0m
call :log "DirectX Web Installer"
winget install -e --id Microsoft.DirectX --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_14
echo.
echo   [1mOneDrive[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Dezinstaleaza OneDrive
echo    [35m[2][0m Instaleaza OneDrive
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_14_1
if "%sub%"=="2" goto :DO_MAIN_14_2
goto :DO_MAIN_14
:DO_MAIN_14_1
echo   [36m  ^> Dezinstaleaza OneDrive...[0m
call :log "Dezinstaleaza OneDrive"
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall 2>nul & %SystemRoot%\System32\OneDriveSetup.exe /uninstall 2>nul || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_14_2
echo   [36m  ^> Instaleaza OneDrive...[0m
call :log "Instaleaza OneDrive"
winget install -e --id Microsoft.OneDrive --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_15
echo.
echo   [1mAplicatii populare (30)[0m
echo   [2m5 actiuni disponibile:[0m
echo    [35m[1][0m 7-Zip
echo    [35m[2][0m VLC
echo    [35m[3][0m Notepad++
echo    [35m[4][0m Discord
echo    [35m[5][0m Steam
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_15_1
if "%sub%"=="2" goto :DO_MAIN_15_2
if "%sub%"=="3" goto :DO_MAIN_15_3
if "%sub%"=="4" goto :DO_MAIN_15_4
if "%sub%"=="5" goto :DO_MAIN_15_5
goto :DO_MAIN_15
:DO_MAIN_15_1
echo   [36m  ^> 7-Zip...[0m
call :log "7-Zip"
winget install -e --id 7zip.7zip --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_15_2
echo   [36m  ^> VLC...[0m
call :log "VLC"
winget install -e --id VideoLAN.VLC --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_15_3
echo   [36m  ^> Notepad++...[0m
call :log "Notepad++"
winget install -e --id Notepad++.Notepad++ --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_15_4
echo   [36m  ^> Discord...[0m
call :log "Discord"
winget install -e --id Discord.Discord --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_15_5
echo   [36m  ^> Steam...[0m
call :log "Steam"
winget install -e --id Valve.Steam --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_16
echo.
echo   [1mMicrosoft Store UWP[0m
echo   [36m  ^> Re-inregistreaza toate UWP...[0m
call :log "Re-inregistreaza toate UWP"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ""$($_.InstallLocation)\AppXManifest.xml"" -ErrorAction SilentlyContinue }" || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_MAIN

:DO_MAIN_17
echo.
echo   [1m.NET & Runtimes[0m
echo   [2m3 actiuni disponibile:[0m
echo    [35m[1][0m .NET 3.5 (din Windows)
echo    [35m[2][0m .NET Desktop Runtime 8
echo    [35m[3][0m .NET Desktop Runtime 9
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_17_1
if "%sub%"=="2" goto :DO_MAIN_17_2
if "%sub%"=="3" goto :DO_MAIN_17_3
goto :DO_MAIN_17
:DO_MAIN_17_1
echo   [36m  ^> .NET 3.5 (din Windows)...[0m
call :log ".NET 3.5 (din Windows)"
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_17_2
echo   [36m  ^> .NET Desktop Runtime 8...[0m
call :log ".NET Desktop Runtime 8"
winget install -e --id Microsoft.DotNet.DesktopRuntime.8 --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_17_3
echo   [36m  ^> .NET Desktop Runtime 9...[0m
call :log ".NET Desktop Runtime 9"
winget install -e --id Microsoft.DotNet.DesktopRuntime.9 --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment la: WINGET[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_18
echo.
echo   [1mAstravex Personalize (tema)[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Aplica tema Astravex Dark
echo    [35m[2][0m Wallpaper Astravex
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_18_1
if "%sub%"=="2" goto :DO_MAIN_18_2
goto :DO_MAIN_18
:DO_MAIN_18_1
echo   [36m  ^> Aplica tema Astravex Dark...[0m
call :log "Aplica tema Astravex Dark"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_SZ /d "0" /f >nul || echo   [33m  ! Avertisment la: REG[0m
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d 0xFF2E8FFF /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_18_2
echo   [36m  ^> Wallpaper Astravex...[0m
call :log "Wallpaper Astravex"
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%ProgramData%\Astravex\astravex-wallpaper.jpg" /f & RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_19
echo.
echo   [1mTweaks Privacy / Telemetrie[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Opreste telemetrie (SUPERLITE)
echo    [35m[2][0m Curata jurnal Event Viewer
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_19_1
if "%sub%"=="2" goto :DO_MAIN_19_2
goto :DO_MAIN_19
:DO_MAIN_19_1
echo   [36m  ^> Opreste telemetrie (SUPERLITE)...[0m
call :log "Opreste telemetrie (SUPERLITE)"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment la: REG[0m
sc config DiagTrack start= disabled >nul & sc stop DiagTrack >nul 2>&1 || echo   [33m  ! Avertisment la: SVC[0m
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1 || echo   [33m  ! Avertisment la: TASK[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_19_2
echo   [36m  ^> Curata jurnal Event Viewer...[0m
call :log "Curata jurnal Event Viewer"
for /F "tokens=*" %G in ('wevtutil el') do wevtutil cl "%G" || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_20
echo.
echo   [1mAndroid (WSA) + WSL[0m
echo   [2m3 actiuni disponibile:[0m
echo    [35m[1][0m Instaleaza WSA (fara GApps — recomandat)
echo    [35m[2][0m Activeaza WSL
echo    [35m[3][0m ADB: conectare WSA
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_20_1
if "%sub%"=="2" goto :DO_MAIN_20_2
if "%sub%"=="3" goto :DO_MAIN_20_3
goto :DO_MAIN_20
:DO_MAIN_20_1
echo   [36m  ^> Instaleaza WSA (fara GApps — recomandat)...[0m
call :log "Instaleaza WSA (fara GApps — recomandat)"
powershell -NoProfile -ExecutionPolicy Bypass -Command "winget install --id WSABuilds.WSA -e --silent" || echo   [33m  ! Avertisment la: PS[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_20_2
echo   [36m  ^> Activeaza WSL...[0m
call :log "Activeaza WSL"
wsl --install --no-distribution || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_20_3
echo   [36m  ^> ADB: conectare WSA...[0m
call :log "ADB: conectare WSA"
adb connect 127.0.0.1:58526 || echo   [33m  ! Avertisment la: CMD[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_24
echo.
echo   [1mGhost Personalize → Astravex Personalize[0m
echo   [2m2 actiuni disponibile:[0m
echo    [35m[1][0m Transparanta taskbar ON
echo    [35m[2][0m Ascunde iconite Desktop
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_24_1
if "%sub%"=="2" goto :DO_MAIN_24_2
goto :DO_MAIN_24
:DO_MAIN_24_1
echo   [36m  ^> Transparanta taskbar ON...[0m
call :log "Transparanta taskbar ON"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_24_2
echo   [36m  ^> Ascunde iconite Desktop...[0m
call :log "Ascunde iconite Desktop"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment la: REG[0m
taskkill /f /im explorer.exe >nul 2>&1 & start explorer.exe || echo   [33m  ! Avertisment la: EXPL[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_42
echo.
echo   [1mWindows 11 Tweaks[0m
echo   [2m3 actiuni disponibile:[0m
echo    [35m[1][0m Clasic menu (dreapta)
echo    [35m[2][0m End Task in taskbar
echo    [35m[3][0m Dezactiveaza Widgets
echo    [2m[0] Anuleaza[0m
set /p sub="  Alege actiunea ^> "
if "%sub%"=="0" goto :MENU_MAIN
if "%sub%"=="1" goto :DO_MAIN_42_1
if "%sub%"=="2" goto :DO_MAIN_42_2
if "%sub%"=="3" goto :DO_MAIN_42_3
goto :DO_MAIN_42
:DO_MAIN_42_1
echo   [36m  ^> Clasic menu (dreapta)...[0m
call :log "Clasic menu (dreapta)"
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /v "" /t REG_SZ /d "Clasic" /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_42_2
echo   [36m  ^> End Task in taskbar...[0m
call :log "End Task in taskbar"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v "TaskbarEndTask" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:DO_MAIN_42_3
echo   [36m  ^> Dezactiveaza Widgets...[0m
call :log "Dezactiveaza Widgets"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment la: REG[0m
echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul
goto :MENU_MAIN
:MENU_BROWSERS
call :banner
echo   [1mBrowsere — toate via winget[0m
echo   [2mAlege mai multe: 1 4 7 sau 1,4,7[0m
echo   [2m──────────────────────────────────────────────[0m
echo.
echo    [36m[1][0m Google Chrome
echo    [36m[2][0m Mozilla Firefox
echo    [36m[3][0m Brave
echo    [36m[4][0m Opera GX
echo    [36m[5][0m Vivaldi
echo.
echo    [2m[0] Inapoi  ^|  [X] Iesire[0m
echo.
set /p choice="  Alege ^> "
if "%choice%"=="0" goto :MENU_MAIN
if /I "%choice%"=="X" exit /b 0
if /I "%choice%"=="x" exit /b 0
if "%choice%"=="1" goto :DO_BROWSERS_1
if "%choice%"=="2" goto :DO_BROWSERS_2
if "%choice%"=="3" goto :DO_BROWSERS_3
if "%choice%"=="4" goto :DO_BROWSERS_4
if "%choice%"=="5" goto :DO_BROWSERS_5
echo   [33m  ! Optiune invalida[0m & timeout /t 1 >nul & goto :MENU_BROWSERS

:DO_BROWSERS_1
echo.
echo   [1mGoogle Chrome[0m
echo   [36m  ^> Instaleaza...[0m
call :log "Instaleaza"
winget install -e --id Google.Chrome --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_BROWSERS

:DO_BROWSERS_2
echo.
echo   [1mMozilla Firefox[0m
echo   [36m  ^> Instaleaza...[0m
call :log "Instaleaza"
winget install -e --id Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_BROWSERS

:DO_BROWSERS_3
echo.
echo   [1mBrave[0m
echo   [36m  ^> Instaleaza...[0m
call :log "Instaleaza"
winget install -e --id Brave.Brave --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_BROWSERS

:DO_BROWSERS_4
echo.
echo   [1mOpera GX[0m
echo   [36m  ^> Instaleaza...[0m
call :log "Instaleaza"
winget install -e --id Opera.OperaGX --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_BROWSERS

:DO_BROWSERS_5
echo.
echo   [1mVivaldi[0m
echo   [36m  ^> Instaleaza...[0m
call :log "Instaleaza"
winget install -e --id Vivaldi.Vivaldi --silent --accept-package-agreements --accept-source-agreements || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_BROWSERS

:MENU_GAMING
call :banner
echo   [1mGaming Tweaks[0m
echo   [2mOptimizari pentru FPS maxim[0m
echo   [2m──────────────────────────────────────────────[0m
echo.
echo    [36m[1][0m Ultimate Performance
echo    [36m[2][0m Game Mode ON
echo    [36m[3][0m HAGS ON (GPU Scheduling)
echo    [36m[4][0m Mouse fara accelerare
echo.
echo    [2m[0] Inapoi  ^|  [X] Iesire[0m
echo.
set /p choice="  Alege ^> "
if "%choice%"=="0" goto :MENU_MAIN
if /I "%choice%"=="X" exit /b 0
if /I "%choice%"=="x" exit /b 0
if "%choice%"=="1" goto :DO_GAMING_1
if "%choice%"=="2" goto :DO_GAMING_2
if "%choice%"=="3" goto :DO_GAMING_3
if "%choice%"=="4" goto :DO_GAMING_4
echo   [33m  ! Optiune invalida[0m & timeout /t 1 >nul & goto :MENU_GAMING

:DO_GAMING_1
echo.
echo   [1mUltimate Performance[0m
echo   [36m  ^> Activeaza Ultimate Performance...[0m
call :log "Activeaza Ultimate Performance"
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_GAMING

:DO_GAMING_2
echo.
echo   [1mGame Mode ON[0m
echo   [36m  ^> Activeaza Game Mode...[0m
call :log "Activeaza Game Mode"
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_GAMING

:DO_GAMING_3
echo.
echo   [1mHAGS ON (GPU Scheduling)[0m
echo   [36m  ^> Activeaza HAGS...[0m
call :log "Activeaza HAGS"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_GAMING

:DO_GAMING_4
echo.
echo   [1mMouse fara accelerare[0m
echo   [36m  ^> Dezactiveaza accelerare mouse...[0m
call :log "Dezactiveaza accelerare mouse"
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment[0m
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_DWORD /d 0 /f >nul || echo   [33m  ! Avertisment[0m
echo   [32m  ✔ Gata.[0m
pause
goto :MENU_GAMING

:MENU_MAIN
goto :MENU_MAIN
