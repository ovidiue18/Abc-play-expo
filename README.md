# Abc-play-expo + AstravexOS — ONE COMMAND KIT

> **O singura comanda in CMD face tot proiectul de la 0, fara erori.**

Acest repo contine **doua proiecte**, ambele cu **ONE COMMAND KIT**:

---

## 1️⃣ ASTRAVEX OS — Windows 11 Pro (NOU, cum ai cerut)

**Exact ca in fisierele trimise** — Windows 11 cu desktop, installer, toolbox.

### O comanda:

```bat
BUILD.cmd
```
sau direct:
```bat
cd AstravexOS
build.cmd
```

**Ce primesti:**
- `AstravexOS/preview/index.html` — **desktop Windows 11 complet in browser** (taskbar, Start, Explorer, Settings, Toolbox, boot animation, login, installer OOBE cu 9 pasi, profile COMPACT/SUPERLITE/NODEF/LTSC)
- `AstravexOS/AstravexOS-Toolbox.cmd` — toolbox consola (31 optiuni, ca Ghost Toolbox, doar cu unelte oficiale winget/reg/ps)
- `AstravexOS/assets/astravex-wallpaper.jpg` — wallpaper neon 1920×1080
- `AstravexOS/docs/` — ghid complet
- `AstravexOS/release/` — kit + SHA256

**Cum editezi:**
- Totul e in `AstravexOS/src/astravex_menus.py` — adaugi un `IT()` si apare in CMD + EXE. Apoi rulezi `build.cmd` din nou.

Detalii: `AstravexOS/docs/README-Windows-Kit.md`

**Preview offline:** dublu-click pe `AstravexOS/preview/index.html` — merge fara server.

---

## 2️⃣ ABC Play — Expo App (existent)

App mobila pentru invatat alfabetul (A-Z, RO/EN, TTS).

### O comanda:

```bat
kit.cmd
```
sau:
```bash
npm run kit
kit --go   # + porneste Expo
```

Detalii in sectiunea de mai jos.

---

## ABC Play — detalii

```bat
kit              # verifica Node, instaleaza, repara assets, verifica Expo
kit --go         # + porneste Expo direct
START.cmd        # dublu-click
```

Dupa kit:
```bash
npm start       # QR pentru telefon (Expo Go)
npm run web     # browser
```

**Structura ABC Play:**
```
App.js, app.json, package.json, babel.config.js
assets/ (icon, splash, a/b/c.png)
scripts/kit.js (creierul kit-ului)
kit.cmd / kit.ps1 / setup.sh
```

**Fix-uri automate:** 3 incercari `npm install` (normal → legacy-peer-deps → cache clean), reparare assets, verificare Expo.

---

## Cerinte

- **AstravexOS:** Windows 10/11 + Python 3.12+ (se instaleaza automat cu winget)
- **ABC Play:** Node.js 18+ + internet prima data
