# AstravexOS — Windows 11 Pro Kit (ONE COMMAND)

> **Un Windows asa cum l-ai vazut in preview.** Totul se face cu o singura comanda.

## O comanda. Zero erori.

Deschizi **CMD** în folderul `AstravexOS` și scrii:

```bat
build.cmd
```

Gata. Face **TOT**:

1. Verifica `Python 3.12+` (il instaleaza singur cu `winget` daca lipseste)
2. Verifica structura (`src/astravex_menus.py` + `src/build.py`)
3. Genereaza `AstravexOS-Toolbox.cmd` (consola, 837 linii)
4. Genereaza `preview/index.html` (Windows 11 desktop interactiv, 1.2 MB)
5. Genereaza `gui/src/AstravexData.cs` (date pentru EXE)
6. Construieste `release/` (portabil + SHA256)

### Ce primesti (ca in fisierele trimise)

- **preview/index.html** — desktop Windows 11 complet functional in browser:
  - Taskbar, Start Menu, Explorer, Settings, Toolbox, Context Menu
  - Boot animation + Login + Installer OOBE (9 pasi: limba, editie, licenta, disc, instalare, regiune, cont, privacy, branding)
  - Profile switcher: COMPACT / SUPERLITE / NODEF / LTSC
  - Design Astravex: wallpaper neon, tema dark, Orbitron font
- **AstravexOS-Toolbox.cmd** — toolbox consola cu 31 optiuni (Action Center, Defender, Spooler, Store, Browsere, etc.)
- **assets/astravex-wallpaper.jpg** — wallpaper 1920×1080 neon
- **docs/** — ghid complet (AstravexOS.txt + AstravexToolbox.md)

## Cum editezi

Toate meniurile sunt in **un singur loc**: `src/astravex_menus.py`

```python
IT(1, "Numele meu nou", [
    A("Actiunea 1", [DW(r"HKCU\...", "Valoare", 1)]),
    A("Actiunea 2", [WINGET("Google.Chrome")]),
])
```

Apoi rulezi din nou `build.cmd` — rescrie automat CMD + preview + C#.

### Comenzi

| Unde | Comanda | Ce face |
|------|---------|---------|
| CMD | `build.cmd` | kit complet |
| CMD | `build.cmd --go` | + deschide preview |
| PowerShell | `python src/build.py` | acelasi lucru |
| Linux/macOS | `python3 src/build.py` | acelasi lucru |

### Cerinte

- Windows 10/11
- Python 3.12+ (se instaleaza automat)
- Drepturi Administrator pentru Toolbox.cmd
- Browser pentru preview (offline, fara server)

## Structura

```
AstravexOS/
├── build.cmd              → ONE COMMAND KIT
├── src/
│   ├── build.py           → generatorul (verifica etichete, paranteze, 120x50)
│   ├── astravex_menus.py  → toate meniurile (editezi aici)
│   └── astravex_dsl.py    → mini-limbaj (Menu, IT, A, REG, SVC, WINGET...)
├── preview/
│   ├── preview-source.html→ sursa preview (de aici se genereaza index.html)
│   └── index.html         → desktop Windows (dublu-click)
├── assets/
│   └── astravex-wallpaper.jpg
├── gui/src/AstravexData.cs→ date C# (pentru EXE)
├── release/
│   ├── AstravexOS-Toolbox.cmd
│   ├── preview.html
│   └── SHA256SUMS.txt
└── docs/
```

Pe Windows real, `build.cmd` foloseste `csc.exe` (.NET inclus) ca sa compileze si EXE-ul, fara Visual Studio.

## Preview offline

Dublu-click pe `preview/index.html` — merge fara internet, in orice browser.
