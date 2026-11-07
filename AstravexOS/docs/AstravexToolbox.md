# AstravexOS Toolbox v1.2.0

Toolbox pentru Windows 10 / 11, construit după modelul **Ghost Toolbox** (Ghost Spectre):
aceleași categorii de opțiuni, aceeași numerotare în meniul principal, aceleași configurări.
Totul e refăcut **doar cu unelte oficiale**: `winget`, DISM, PowerShell, `reg`, `sc`, `powercfg`.
Nu folosește servere terțe, executabile ascunse sau activatoare.

> **v1.2.0 – rebrand:** fostul *Trifan Toolbox* se numește acum **AstravexOS Toolbox** și are culorile AstravexOS:
> fundal bleumarin, neon albastru electric → violet → magenta și sigla nouă, prisma „A”.

Există în **două variante**, generate din aceeași sursă, deci cu exact aceleași opțiuni:

| Variantă | Pentru cine |
|---|---|
| **`AstravexOS-Toolbox.exe`** | Aplicație Windows cu ferestre: aspectul **HyperOS** (carduri rotunjite) în **culorile AstravexOS**, adică temă întunecată bleumarin cu accente neon albastru → violet → magenta. Categorii în stânga, butoane și bife, jurnal live. |
| **`AstravexOS-Toolbox.cmd`** | Varianta clasică de consolă, ca Ghost Toolbox: banner **ASTRAVEX** în degrade neon, meniu pe 2 coloane, „Stare” în timp real. |

![AstravexOS-Toolbox.exe - pagina Acasă](docs/astravex-exe-acasa.png)

**Cum îl iei:** kitul de instalare **`release/AstravexOS-Toolbox-Setup-1.2.0.exe`** (recomandat) sau arhiva **`release/AstravexOS-Toolbox-1.2.0-portabil.zip`**, care merge fără instalare. Detalii la [Instalare](#instalare).

## Ce e nou în v1.2.0 (rebrand AstravexOS)

- **Nume nou: AstravexOS Toolbox** (fost Trifan Toolbox). Fișierele, scurtăturile, folderele și cheile de registru au nume noi:
  - `AstravexOS-Toolbox.exe`, `AstravexOS-Toolbox.cmd`, `AstravexOS-Toolbox-Setup-1.2.0.exe`;
  - instalare în `C:\Program Files\AstravexOS Toolbox`, date în `C:\ProgramData\AstravexOS`;
  - meniul de pe desktop **Astravex Mode** (alias `astravexmode`) și planul de energie „AstravexOS Ultimate Performance”.
- **Tema AstravexOS în aplicație și în kit:**
  - fundal bleumarin, carduri cu contur fin și bară de titlu întunecată;
  - butoane principale în degrade albastru electric → violet, iconițe de categorii în nuanțe neon;
  - cardul „Sistemul tău” și panoul kitului au ca fundal peisajul neon AstravexOS.
- **Siglă nouă**, prisma „A” (cyan → albastru → violet → magenta), în aplicație, iconiță, kit și previzualizare.
- **Wallpaper nou** `assets/astravex-wallpaper.jpg` (1920×1080), folosit de opțiunea **24 → 18**.
- **CMD în culorile AstravexOS:** banner ASTRAVEX în degrade, titluri albastre, taste violet.
  - Pe Windows 10 1703+ culorile brandului sunt *truecolor*, exact ca în siglă; pe versiunile mai vechi rămân cele 16 culori standard.
  - Verde / roșu / galben își păstrează sensul: OK / eroare / atenție.
- Schemă nouă de consolă **Astravex Neon** în opțiunea **34**.
- **Trecerea de la Trifan e automată:** dacă kitul găsește vechiul Trifan Toolbox, îl dezinstalează silențios, cu dezinstalatorul lui.
  - Dispar fișierele, scurtăturile, intrarea din „Aplicații instalate” și meniul Trifan Mode.
  - Datele vechi din `C:\ProgramData\Trifan` rămân pe loc; le poți șterge de mână.

## Versiunea 1.1 (pe scurt)

- **`AstravexOS-Toolbox.exe`**, aplicația cu ferestre (detalii mai jos).
- **Kit de instalare**: Program Files, meniul Start, dezinstalare din Setări, actualizare peste versiunea veche. Există și o **variantă portabilă** (.zip).
- **Android (WSA) + ADB / WSL Linux** (opțiunea **42 → 20**):
  - instalează WSA din [WSABuilds](https://github.com/MustardChef/WSABuilds), cu trei variante: fără Google Play (recomandat), cu Google Play, sau cu root (Magisk);
  - pornire, oprire, setări și eliminare WSA;
  - Virtual Machine Platform;
  - ADB (Google Platform Tools): conectare la WSA, instalare APK, consolă ADB;
  - WSA PacMan, WSA System Control, scrcpy;
  - WSL (`wsl --install` / `--update`).
- **Pachet IObit oficial** (opțiunea **27 → I**): 8 aplicații IObit în versiunile gratuite oficiale, prin winget, cu selecție multiplă:
  - Advanced SystemCare, Driver Booster, Smart Defrag, Uninstaller;
  - Malware Fighter, Software Updater, Unlocker, Undelete.
- **Reparat:** la instalări multiple fără winget, întrebarea „instalez winget?” apare o singură dată și nu mai apare un „[OK]” fals.

## Fișiere

| Fișier | Ce este |
|---|---|
| `release/AstravexOS-Toolbox-Setup-1.2.0.exe` | **Kitul de instalare** (≈ 820 KB): conține aplicația, varianta de consolă, wallpaper-ul și acest README. |
| `release/AstravexOS-Toolbox-1.2.0-portabil.zip` | **Varianta portabilă**: folderul `AstravexOS-Toolbox/` gata de pornit, fără instalare. |
| `release/SHA256SUMS.txt` | Sumele de control SHA-256 ale celor două fișiere de mai sus. |
| `AstravexOS-Toolbox.exe` | **Aplicația cu ferestre** (WinForms, .NET Framework 4.x, inclus în Windows 10/11). Conține toate meniurile. |
| `AstravexOS-Toolbox.cmd` | **Varianta de consolă.** Un singur fișier (ASCII, CRLF): 8.028 de linii, 49 de meniuri, 397 de opțiuni, 394 de acțiuni. |
| `assets/astravex-wallpaper.jpg` | Wallpaper-ul AstravexOS (1920×1080), folosit de opțiunea **24 → 18**. Păstrează folderul `assets` lângă program. |
| `preview/index.html` | Previzualizare interactivă a variantei CMD (merge offline în orice browser). |
| `docs/` | Capturi de ecran cu `AstravexOS-Toolbox.exe` și cu kitul de instalare. |
| `gui/res/hero.jpg`, `setup/res/brand.jpg` | Peisajul AstravexOS din cardul „Sistemul tău” și din panoul kitului (încorporate în exe la compilare). |
| `src/astravex_menus.py` | **Sursa** tuturor meniurilor și acțiunilor (aici se editează). |
| `src/astravex_dsl.py` | Mini-limbajul folosit pentru meniuri (`Menu`, `IT`, `A`, `WG`, `REG`, `PS` ...). |
| `src/build.py` | Generatorul: produce `AstravexOS-Toolbox.cmd`, `preview/index.html` și (prin `build_gui.py`) `AstravexOS-Toolbox.exe`, cu verificări automate. |
| `src/build_gui.py` | Partea de generator pentru aplicația cu ferestre: datele C#, iconița, manifestul și compilarea. |
| `src/build_setup.py` | Construiește kitul de instalare și arhiva portabilă în `release/`. |
| `gui/src/*.cs` | Codul aplicației: `Theme.cs` (tema AstravexOS: culori, siglă, butoane), `Views.cs`, `MainForm.cs`, `Dialogs.cs`, `Runner.cs`. `AstravexData.cs` este generat automat. |
| `setup/src/*.cs` | Codul kitului de instalare: `Setup.cs` (instalare, dezinstalare, scurtături, registru) și `SetupForm.cs` (interfața). Folosește și `gui/src/Theme.cs`. `SetupData.cs` este generat automat. |

## Instalare

### Kit de instalare (recomandat)

![Kitul de instalare AstravexOS](docs/astravex-setup.png)

1. Pornește **`AstravexOS-Toolbox-Setup-1.2.0.exe`** și acceptă promptul UAC.
2. Dacă apare **SmartScreen** („Windows a protejat PC-ul”), alege „Mai multe informații” → „Rulare oricum”. Kitul nu e semnat digital.
3. Alege folderul (implicit `C:\Program Files\AstravexOS Toolbox`) și opțiunile:
   - **Scurtătură pe desktop** (pornită implicit);
   - **Varianta de consolă (AstravexOS-Toolbox.cmd)** (pornită implicit), cu scurtătura „AstravexOS Toolbox (CMD)” în meniul Start.
4. Apasă **Instalează**. La final poți apăsa direct **Deschide AstravexOS Toolbox**.

Ce face kitul:

- copiază `AstravexOS-Toolbox.exe`, `AstravexOS-Toolbox.cmd`, `assets\` și `README.md` în folderul ales, plus `Dezinstalare.exe`;
- pune **AstravexOS Toolbox** în meniul Start (pentru toți utilizatorii) și, opțional, pe desktop;
- înregistrează aplicația în **Setări → Aplicații → Aplicații instalate**, cu versiunea, iconița și mărimea;
- dacă găsește vechiul **Trifan Toolbox**, îl dezinstalează silențios și îți spune asta pe pagina finală.

**Actualizare:** pornești kitul nou peste cel vechi. Recunoaște instalarea existentă și afișează **Actualizează** (sau **Reinstalează** pentru aceeași versiune). Păstrează folderul și opțiunile alese data trecută. Jurnalul și backup-urile din `%ProgramData%\AstravexOS` nu sunt atinse.

Dacă **AstravexOS Toolbox e deschis**, kitul te anunță. La a doua apăsare îl închide singur și continuă, ca să nu rămână fișiere pe jumătate înlocuite.

![Gata](docs/astravex-setup-gata.png)

### Dezinstalare

Din **Setări → Aplicații → Aplicații instalate → AstravexOS Toolbox → Dezinstalare**. Alternativ, rulezi `Dezinstalare.exe` din folderul programului.

![Dezinstalare](docs/astravex-setup-dezinstalare.png)

- Șterge doar fișierele puse de kit, scurtăturile și intrarea din „Aplicații instalate”. Dacă ai pus alte fișiere în folder, folderul rămâne.
- **Șterge și datele AstravexOS** (oprit implicit): jurnalul și backup-urile din `C:\ProgramData\AstravexOS`.
- **Elimină meniul Astravex Mode** (pornit implicit, apare doar dacă l-ai activat): intrările Astravex Mode din click-dreapta pe desktop.
- **Tweak-urile aplicate rămân active.** Dacă vrei să le anulezi, folosește întâi opțiunile din aplicație sau un punct de restaurare.

### Varianta portabilă

1. Extrage **`AstravexOS-Toolbox-1.2.0-portabil.zip`** (nu porni programul din interiorul arhivei).
2. Pornește `AstravexOS-Toolbox\AstravexOS-Toolbox.exe` (sau `AstravexOS-Toolbox.cmd`) și acceptă promptul UAC.

Nu scrie nimic în registru și nu creează scurtături. Ca să-l elimini, ștergi folderul (și, dacă vrei, `C:\ProgramData\AstravexOS`).

### Instalare automată (pentru scripturi)

| Comandă | Ce face |
|---|---|
| `AstravexOS-Toolbox-Setup-1.2.0.exe /S` | Instalează fără ferestre, cu opțiunile implicite (sau cele de data trecută). |
| `… /S /D=D:\Programe\AstravexOS Toolbox` | Instalează în alt folder (`/D=` la final, fără ghilimele). |
| `… /S /nodesktop /nocmd` | Fără scurtătură pe desktop / fără `AstravexOS-Toolbox.cmd`. |
| `"C:\Program Files\AstravexOS Toolbox\Dezinstalare.exe" /uninstall /S` | Dezinstalează fără ferestre (păstrează datele). |
| `… /uninstall /S /purge` | Dezinstalează și șterge datele din `C:\ProgramData\AstravexOS`. |

Coduri de ieșire: `0` reușit, `1` eroare, `2` anulat, `3` fără drepturi de administrator.
Jurnalul kitului e în `%TEMP%\AstravexOS-Setup.log`.

## AstravexOS-Toolbox.exe – aplicația cu ferestre

1. Instalează-l cu kitul sau extrage varianta portabilă (vezi [Instalare](#instalare)). Dacă îl muți de mână, păstrează folderul `assets` lângă `AstravexOS-Toolbox.exe`.
2. Pornește-l din meniul Start („AstravexOS Toolbox”), de pe desktop sau cu dublu-click pe `AstravexOS-Toolbox.exe`, apoi acceptă promptul UAC. Programul cere singur drepturi de administrator.
3. Dacă apare **SmartScreen** („Windows a protejat PC-ul”), alege „Mai multe informații” → „Rulare oricum”. Apare pentru că executabilul nu e semnat digital.

**Nu are nevoie de alte programe:** .NET Framework 4.x vine cu Windows 10 și 11.

**Cum arată și cum se folosește:**

- **Stânga:** sigla, căutarea și toate categoriile din meniul principal, grupate în carduri cu iconițe neon.
- **Acasă:** cardul „Sistemul tău”, cu peisajul AstravexOS în fundal, arată:
  - versiunea de Windows, .NET, TPM;
  - dacă rulezi ca administrator, utilizatorul și PC-ul;
  - fusul orar.

  Butonul **Punct de restaurare** din card creează imediat un punct de restaurare.
- **Click pe o opțiune** o rulează. În listele de aplicații bifezi cercurile din stânga, apoi apeși **Instalează (N)**.
- **Jurnalul e ascuns.** Apare jos doar când rulează o acțiune și arată live tot ce face aceasta. După terminare rămâne deschis cu rezultatul, până îl închizi cu **X**. Butonul din dreapta sus (sau **Ctrl+L**) îl arată sau îl ascunde oricând.
- Când o acțiune îți cere ceva, apare o fereastră de dialog:
  - o valoare (cale, nume, dimensiune în MB): câmp de text, iar la fișiere și foldere și butonul **Răsfoiește**;
  - o confirmare: **Da / Nu**.
- Mesajele scurte apar ca notificări jos, pe mijloc.

**Tastatură** (ca în CMD):

| Tastă | Ce face |
|---|---|
| număr + **Enter** | rulează opțiunea; în listele de aplicații poți scrie mai multe: `1 4 7` |
| **Esc** | înapoi |
| **Ctrl+F** | caută în toate meniurile |
| **F5** | reîncarcă stările (Activ / Inactiv) |
| **Ctrl+L** | arată sau ascunde jurnalul |

**Parametri din linia de comandă:**

- `AstravexOS-Toolbox.exe --open M15` deschide direct un meniu;
- `--search wsa` caută;
- `--select "1 2"` bifează opțiunile în meniul deschis;
- `--log` pornește cu jurnalul vizibil.

**Ce rulează în spate:** fiecare acțiune execută exact aceleași comenzi ca `AstravexOS-Toolbox.cmd`, într-un `cmd.exe` ascuns. Jurnalul permanent rămâne `%ProgramData%\AstravexOS\astravex.log`. Dacă aplicația întâlnește o eroare neprevăzută, detaliile ajung în `%TEMP%\AstravexOS\error.log`.

<p>
<img src="docs/astravex-exe-selectie.png" width="49%" alt="Selectie multipla">
<img src="docs/astravex-exe-instalare.png" width="49%" alt="Instalare cu jurnal">
<img src="docs/astravex-exe-android.png" width="49%" alt="Meniul Android (WSA)">
<img src="docs/astravex-exe-dialog.png" width="49%" alt="Dialog pentru o valoare">
</p>

## AstravexOS-Toolbox.cmd – varianta de consolă

1. Descarcă `AstravexOS-Toolbox.cmd`, plus folderul `assets` dacă vrei wallpaper-ul AstravexOS. Dacă e într-o arhivă ZIP, **extrage-o mai întâi**.
2. Dă **dublu-click** pe `AstravexOS-Toolbox.cmd` și acceptă promptul UAC.
3. Tastează numărul opțiunii și apasă **Enter**. Cu `0` revii la meniul anterior, cu `X` ieși din program.
4. În listele de aplicații poți alege mai multe deodată: `1 4 7` sau `1,4,7`.

> Recomandare: înainte de orice tweak, creează un punct de restaurare (tasta **R** în CMD, butonul din cardul „Sistemul tău” în aplicație).

**Cerințe (ambele variante):**

- Windows 10 sau Windows 11. În CMD, culorile necesită Windows 10 versiunea 1511 sau mai nouă. Degradeul neon (truecolor) apare de la versiunea 1703; înainte se folosesc cele 16 culori standard.
- Drepturi de administrator.
- Internet pentru instalări.
- `winget` (App Installer). Dacă lipsește, AstravexOS Toolbox îl instalează singur sau poți folosi opțiunea **W**.

## Harta opțiunilor față de Ghost Toolbox

| Nr. | Ghost Toolbox | AstravexOS Toolbox |
|---|---|---|
| 1 | Action Center & Notification, Cortana, Printer | La fel, plus Remote Desktop, Windows Hello și serviciul de tastare (cu stare live) |
| 2 | Clear Event Viewer Logs | La fel, plus oprirea auditării Object Access (cu backup și restaurare) |
| 3 | Clear Cache Updates, Delivery Optimization | La fel, plus cache Store, Temp, cleanmgr, WinSxS, DISM/SFC, chkdsk, optimizare disc |
| 4 | Ghost Online Activator | **Înlocuit** cu Windows Defender, SmartScreen și UAC (fără activator) |
| 5 | Hibernation, Fastboot, Sleep, Sysmain | La fel (cu stare live) |
| 6 | Pagefile | La fel: dezactivat, 256 MB până la 16 GB, gestionat de sistem sau personalizat |
| 7 | Take Ownership | La fel |
| 8 | Stop Windows Updates until 2077 | La fel, plus politici (fără drivere, fără upgrade de versiune) |
| 9 | Compact, LZX | La fel (Compact OS, LZX pe Program Files sau pe un folder ales, decomprimare) |
| 10 | Microsoft Store & Xbox, UWP | La fel (Store, re-înregistrare, aplicații UWP și codec-uri prin `winget -s msstore`) |
| 11 | Xbox Game Bar | La fel (instalare, eliminare, reparare protocol `ms-gamebar`, Game DVR) |
| 12–15, 18 | Edge, Firefox, Chrome, PotPlayer, Brave | La fel, prin winget (plus VLC, MPC-HC, K-Lite, Opera GX, Vivaldi, LibreWolf, Zen, Chromium ...) |
| 16, 17 | VC++ AIO, DirectX | La fel |
| 19, 20, 23 | Miracast, Clipboard & Touch Keyboard, Game Pass | La fel |
| 22 | Disk Benchmark | `winsat` plus CrystalDiskMark și CrystalDiskInfo |
| 24 | Ghost Personalize | **AstravexOS Personalize** (temă dark/light, accent, transparență, iconițe desktop, wallpaper ...) |
| 25 | DriverEasy | La fel (winget) |
| 26 | OneDrive | La fel (instalare / dezinstalare), plus RaiDrive |
| 27 | Users Request (+ pachetul IObit) | **Aplicații populare**: 30 de aplicații cu selecție multiplă, plus **[I] Pachet IObit** în versiunile oficiale gratuite |
| 28, 29, 30 | Groove, Your Phone, .NET | Media Player, Phone Link, .NET 3.5 (online sau din ISO), .NET 4.x, Desktop Runtime 8 / 9 / 10 |
| 31 | WinRE | La fel (stare, activare, dezactivare, repornire în Recovery) |
| 32 | Change Windows Editions | Edițiile disponibile, schimbarea ediției și activarea **cu cheia ta** (fără KMS) |
| 33 | Administrator / New Users | La fel, plus redenumire, parolă, ștergere, Admin Approval Mode |
| 34 | CMD Color Schemes | 12 scheme (Campbell, One Half, Solarized, Dracula, Nord, **Astravex Neon** ...) |
| 35 | Standalone Windows Update | Căutare actualizări, istoric, reparare Windows Update, `winget upgrade --all`, verificare la pornire |
| 36 | IObit Driver Booster | **Unelte drivere**: Driver Booster (oficial), Snappy Driver Installer, Intel DSA, DDU, NVIDIA/AMD, backup și restaurare drivere |
| 37 | 7-Zip | 7-Zip, NanaZip, WinRAR, PeaZip |
| 38 | Sound Mod | FxSound, Equalizer APO, Dolby Access (oficial), Realtek Audio Control, repornire servicii audio |
| 39 | Tweaking for Gaming | Ultimate Performance, Game Mode, HAGS, mouse fără accelerare, Magpie, Afterburner ... |
| 40 | Game Clients | Steam, EA app, Epic, GOG, Ubisoft, Battle.net, Xbox, itch.io, Amazon, Playnite, Heroic, Rockstar |
| 41 | Ghost YouTube Downloader | **AstravexOS YouTube Downloader** (yt-dlp + FFmpeg: video MP4 sau audio MP3) |
| 42 | Options for Windows 11 (+ WSA) | Meniu clasic, taskbar, End Task, Widgets, Copilot/Recall, aplicații W11, patchere taskbar, plus **[20] Android (WSA) + ADB / WSL** |
| 99 | Changelog | Changelog, despre, jurnal, verificare versiune nouă |
| — | GhostMode (meniu pe desktop) | **[M] Astravex Mode**: meniu click-dreapta pe desktop cu 7 intrări comutabile |
| — | — | Extra: **[T]** fus orar și sincronizare oră, **[D]** DNS (Cloudflare, Google, Quad9, AdGuard), **[R]** punct de restaurare, **[W]** winget (căutare, export / import aplicații) |

Aliasuri acceptate în meniul principal (CMD): `timezone`, `dns`, `astravexmode`, `ghostmode`, `winget`, `android`, `wsa`, `iobit`.

## Ce NU am preluat (intenționat)

- **Ghost Online Activator** și activarea prin KMS: activatoarele de Windows/Office sunt piraterie și sunt periculoase. Opțiunea 4 e acum securitatea Windows, iar 32 activează doar cu cheia ta.
- **Pachetul IObit „repack”** (versiuni PRO piratate): l-am înlocuit cu versiunile gratuite oficiale, direct de la IObit, prin winget (**27 → I**).
- **Serverele Ghost Spectre** (Dropbox, bit.ly, servere private): toate descărcările vin din winget, Microsoft Store, GitHub sau site-urile oficiale.
- **Drivere audio Dolby / DTS modificate** (Sound Mod): sunt nesemnate și pot compromite sistemul.
- **Paint 3D** și **Cortana Beta**: retrase de Microsoft.

## De știut

- **WSA:** Microsoft a oprit WSA în martie 2025. AstravexOS Toolbox instalează build-urile comunitare WSABuilds, care pornesc de la pachetele Microsoft.
  - Recomandat: varianta **[1] fără Google Play**. Variantele cu GApps se pot închide singure pe build-urile Windows 11 recente.
  - Ai nevoie de virtualizare activată în BIOS și de o partiție NTFS.
  - WSA rămâne instalat în `C:\WSA\...`. Nu șterge acel folder.
- **Windows Terminal** (implicit în Windows 11) ignoră `mode con` și schemele de culori din `HKCU\Console`. Pentru fereastra CMD de 120×50 și pentru opțiunea 34, setează **Windows Console Host** ca terminal implicit (Setări → Pentru dezvoltatori → Terminal). Aplicația `AstravexOS-Toolbox.exe` nu e afectată.
- Tweak-urile **HKCU** se aplică utilizatorului care a acceptat UAC. Dacă rulezi AstravexOS Toolbox cu alt cont de administrator, ele ajung pe acel cont.
- Unele opțiuni cer **repornirea** Explorer sau a PC-ului. AstravexOS Toolbox îți spune când e cazul.
- Drag & drop din Explorer în AstravexOS Toolbox nu funcționează (Windows blochează trasul de fișiere în ferestrele ridicate cu UAC). Folosește **Răsfoiește** sau scrie calea.
- **winget** e necesar pentru instalări. Dacă lipsește, AstravexOS Toolbox îl instalează prin modulul oficial `Microsoft.WinGet.Client` (`Repair-WinGetPackageManager`).
- Folosește programul **pe propria răspundere**. Tweak-urile sunt reversibile din același meniu, iar punctul de restaurare e plasa de siguranță.

## Modificare și regenerare

Toate meniurile se editează în `src/astravex_menus.py`. Apoi construiești.

**Pe Windows (CMD):**

```bat
cd /d C:\AstravexOS
build.cmd
```

`build.cmd` verifică Python (3.12 sau mai nou; dacă lipsește: `winget install -e --id Python.Python.3.12`) și rulează `src\build.py`. Compilatorul C# nu trebuie instalat: se folosește `csc.exe` din .NET Framework 4.x, inclus în Windows 10/11.

**Pe Linux:**

```bash
cd AstravexOS
python3 src/build.py
```

Generatorul rescrie `AstravexOS-Toolbox.cmd`, `preview/index.html` și `gui/src/AstravexData.cs`. Dacă găsește un compilator C#, recompilează și `AstravexOS-Toolbox.exe`, apoi (prin `build_setup.py`) reface în `release/` kitul de instalare, arhiva portabilă și `SHA256SUMS.txt`:

- **Python 3.12** sau mai nou, obligatoriu;
- un compilator C#, obligatoriu pentru exe: `csc.exe` din .NET Framework 4.x (Windows, găsit automat) sau **mcs** (Mono, de exemplu `apt install mono-mcs`);
- **windres** (`mingw-w64-tools`), opțional: pune iconița, manifestul UAC și versiunea într-un singur fișier de resurse. Fără el, cu `csc` se folosesc opțiunile `/win32icon` și `/win32manifest`, iar versiunea vine din atribute .NET.

Documentația completă (descriere, ghid de refacere în CMD, toate comenzile fiecărei opțiuni și codul sursă) este în `docs/AstravexOS-Toolbox-Documentatie-1.2.0.pdf`.

Verificări automate:

- etichetele `goto` / `call` inexistente sau duplicate;
- parantezele și ghilimelele;
- caracterele non-ASCII;
- dacă meniurile CMD încap în 120 de coloane și 50 de linii;
- compilarea aplicației și a kitului de instalare fără erori.

Exemplu de opțiune nouă (apare automat și în CMD, și în aplicația cu ferestre):

```python
IT(9, 'Exemplu: dezactiveaza Bing in Start', A('Dezactiveaza Bing in Start', [
    DW(r'HKCU\Software\Policies\Microsoft\Windows\Explorer', 'DisableSearchBoxSuggestions', 1),
    EXPL()]))
```
