"""
AstravexOS — definitia meniurilor Toolbox
Editabil: adaugi un IT() si apare automat in CMD + EXE
"""

from astravex_dsl import Menu, IT, A, REG, SVC, TASK, WINGET, PS, CMD, DW, SZ, EXPL

MENUS = []

# ---------- Meniu principal ----------
MENUS.append(Menu("MAIN", "ASTRAVEX TOOLBOX", "Alege o optiune — tasteaza numarul si apasa Enter", [
    IT(1, "Action Center & Notificari", [
        A("Dezactiveaza Action Center", [
            DW(r"HKCU\Software\Policies\Microsoft\Windows\Explorer", "DisableNotificationCenter", 1),
            SVC("WpnService", "disabled"),
        ]),
        A("Activeaza Action Center", [
            DW(r"HKCU\Software\Policies\Microsoft\Windows\Explorer", "DisableNotificationCenter", 0),
            SVC("WpnService", "demand"),
        ]),
    ]),
    IT(2, "Cortana + Copilot + Recall", [
        A("Dezactiveaza Cortana / Copilot", [
            DW(r"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Copilot", "TurnOffWindowsCopilot", 1),
            DW(r"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowCopilotButton", 0),
        ]),
        A("Activeaza Copilot", [
            DW(r"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Copilot", "TurnOffWindowsCopilot", 0),
        ]),
    ]),
    IT(3, "Print Spooler (imprimante)", [
        A("Activeaza Print Spooler", [SVC("Spooler", "auto"), CMD("net start Spooler")]),
        A("Dezactiveaza Print Spooler", [SVC("Spooler", "disabled"), CMD("net stop Spooler /y")]),
    ]),
    IT(4, "Windows Security / Defender", [
        A("Opreste Defender (SUPERLITE W/O DEF)", [
            PS("Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue"),
            SVC("WinDefend", "disabled"),
        ]),
        A("Activeaza Defender", [
            SVC("WinDefend", "auto"),
            PS("Set-MpPreference -DisableRealtimeMonitoring $false"),
        ]),
    ]),
    IT(5, "Hibernare / Fast Boot", [
        A("Dezactiveaza Hibernare", [CMD("powercfg /hibernate off")]),
        A("Activeaza Hibernare", [CMD("powercfg /hibernate on")]),
    ]),
    IT(6, "Pagefile (memorie virtuala)", [
        A("Pagefile automat", [CMD("wmic computersystem where name='%computername%' set AutomaticManagedPagefile=True")]),
        A("Pagefile dezactivat (SSD rapid)", [CMD("wmic computersystem where name='%computername%' set AutomaticManagedPagefile=False")]),
    ]),
    IT(7, "Take Ownership (meniu click-dreapta)", [
        A("Instaleaza Take Ownership", [REG(r"HKEY_CLASSES_ROOT\*\shell\TakeOwnership", "", "Take Ownership", "REG_SZ")]),
        A("Elimina Take Ownership", [CMD('reg delete "HKEY_CLASSES_ROOT\\*\\shell\\TakeOwnership" /f')]),
    ]),
    IT(8, "Windows Update", [
        A("Pauza Update pana in 2077", [SZ(r"HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings", "PauseUpdatesStartTime", "2026-11-07T00:00:00Z")]),
        A("Reia Update-urile", [CMD('reg delete "HKLM\\SOFTWARE\\Microsoft\\WindowsUpdate\\UX\\Settings" /v PauseUpdatesStartTime /f 2>nul')]),
        A("Blocheaza upgrade de versiune ( ramai pe 24H2/25H2 )", [DW(r"HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate", "TargetReleaseVersion", 1)]),
    ]),
    IT(9, "Compact OS + LZX", [
        A("Activeaza Compact OS", [CMD("compact.exe /CompactOS:always")]),
        A("LZX pe Program Files", [CMD('compact /c /exe:lzx "C:\\Program Files\\*.*"')]),
        A("Decomprima tot", [CMD("compact /CompactOS:never")]),
    ]),
    IT(10, "Microsoft Store + Xbox", [
        A("Reinstaleaza Store", [PS("Get-AppxPackage *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\\AppXManifest.xml\"}")]),
        A("Instaleaza Xbox App (winget)", [WINGET("Microsoft.GamingStore")]),
        A("Elimina Xbox Game Bar", [PS("Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage")]),
    ]),
    IT(11, "Xbox Game Bar / Game DVR", [
        A("Dezactiveaza Game DVR", [DW(r"HKCU\System\GameConfigStore", "GameDVR_Enabled", 0)]),
        A("Activeaza Game Bar", [WINGET("Microsoft.XboxGamingOverlay")]),
    ]),
    IT(12, "Browsere (winget)", [
        A("Instaleaza Chrome", [WINGET("Google.Chrome")]),
        A("Instaleaza Firefox", [WINGET("Mozilla.Firefox")]),
        A("Instaleaza Brave", [WINGET("Brave.Brave")]),
        A("Instaleaza Edge", [WINGET("Microsoft.Edge")]),
    ]),
    IT(13, "VC++ & DirectX", [
        A("VC++ AIO (toate versiunile)", [WINGET("Microsoft.VCRedist.2015+.x64")]),
        A("DirectX Web Installer", [WINGET("Microsoft.DirectX")]),
    ]),
    IT(14, "OneDrive", [
        A("Dezinstaleaza OneDrive", [CMD("%SystemRoot%\\SysWOW64\\OneDriveSetup.exe /uninstall 2>nul & %SystemRoot%\\System32\\OneDriveSetup.exe /uninstall 2>nul")]),
        A("Instaleaza OneDrive", [WINGET("Microsoft.OneDrive")]),
    ]),
    IT(15, "Aplicatii populare (30)", [
        A("7-Zip", [WINGET("7zip.7zip")]),
        A("VLC", [WINGET("VideoLAN.VLC")]),
        A("Notepad++", [WINGET("Notepad++.Notepad++")]),
        A("Discord", [WINGET("Discord.Discord")]),
        A("Steam", [WINGET("Valve.Steam")]),
    ]),
    IT(16, "Microsoft Store UWP", [
        A("Re-inregistreaza toate UWP", [PS("Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\\AppXManifest.xml\" -ErrorAction SilentlyContinue }")]),
    ]),
    IT(17, ".NET & Runtimes", [
        A(".NET 3.5 (din Windows)", [CMD("DISM /Online /Enable-Feature /FeatureName:NetFx3 /All")]),
        A(".NET Desktop Runtime 8", [WINGET("Microsoft.DotNet.DesktopRuntime.8")]),
        A(".NET Desktop Runtime 9", [WINGET("Microsoft.DotNet.DesktopRuntime.9")]),
    ]),
    IT(18, "Astravex Personalize (tema)", [
        A("Aplica tema Astravex Dark", [
            SZ(r"HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme", "0"),
            DW(r"HKCU\Software\Microsoft\Windows\DWM", "ColorizationColor", "0xFF2E8FFF"),
        ]),
        A("Wallpaper Astravex", [CMD('reg add "HKCU\\Control Panel\\Desktop" /v Wallpaper /t REG_SZ /d "%ProgramData%\\Astravex\\astravex-wallpaper.jpg" /f & RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters')]),
    ]),
    IT(19, "Tweaks Privacy / Telemetrie", [
        A("Opreste telemetrie (SUPERLITE)", [
            DW(r"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", 0),
            SVC("DiagTrack", "disabled"),
            TASK("\\Microsoft\\Windows\\Application Experience\\Microsoft Compatibility Appraiser", "disable"),
        ]),
        A("Curata jurnal Event Viewer", [CMD("for /F \"tokens=*\" %G in ('wevtutil el') do wevtutil cl \"%G\"")]),
    ]),
    IT(20, "Android (WSA) + WSL", [
        A("Instaleaza WSA (fara GApps — recomandat)", [PS("winget install --id WSABuilds.WSA -e --silent")]),
        A("Activeaza WSL", [CMD("wsl --install --no-distribution")]),
        A("ADB: conectare WSA", [CMD("adb connect 127.0.0.1:58526")]),
    ]),
    IT(24, "Ghost Personalize → Astravex Personalize", [
        A("Transparanta taskbar ON", [DW(r"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "UseOLEDTaskbarTransparency", 1)]),
        A("Ascunde iconite Desktop", [DW(r"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "HideIcons", 1), EXPL()]),
    ]),
    IT(42, "Windows 11 Tweaks", [
        A("Clasic menu (dreapta)", [SZ(r"HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}", "", "Clasic")]),
        A("End Task in taskbar", [DW(r"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings", "TaskbarEndTask", 1)]),
        A("Dezactiveaza Widgets", [DW(r"HKLM\SOFTWARE\Policies\Microsoft\Dsh", "AllowNewsAndInterests", 0)]),
    ]),
]))

# ---------- Submeniuri ----------
MENUS.append(Menu("BROWSERS", "Browsere — toate via winget", "Alege mai multe: 1 4 7 sau 1,4,7", [
    IT(1, "Google Chrome", [A("Instaleaza", [WINGET("Google.Chrome")])]),
    IT(2, "Mozilla Firefox", [A("Instaleaza", [WINGET("Mozilla.Firefox")])]),
    IT(3, "Brave", [A("Instaleaza", [WINGET("Brave.Brave")])]),
    IT(4, "Opera GX", [A("Instaleaza", [WINGET("Opera.OperaGX")])]),
    IT(5, "Vivaldi", [A("Instaleaza", [WINGET("Vivaldi.Vivaldi")])]),
]))

MENUS.append(Menu("GAMING", "Gaming Tweaks", "Optimizari pentru FPS maxim", [
    IT(1, "Ultimate Performance", [A("Activeaza Ultimate Performance", [CMD("powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61")])]),
    IT(2, "Game Mode ON", [A("Activeaza Game Mode", [DW(r"HKCU\Software\Microsoft\GameBar", "AllowAutoGameMode", 1)])]),
    IT(3, "HAGS ON (GPU Scheduling)", [A("Activeaza HAGS", [DW(r"HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers", "HwSchMode", 2)])]),
    IT(4, "Mouse fara accelerare", [A("Dezactiveaza accelerare mouse", [DW(r"HKCU\Control Panel\Mouse", "MouseSpeed", "0"), DW(r"HKCU\Control Panel\Mouse", "MouseThreshold1", "0")])]),
]))

# verif helper
def get_menu(id):
    for m in MENUS:
        if m.id == id:
            return m
    raise KeyError(id)
