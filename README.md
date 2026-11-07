# ABC Play — One Command Kit

> **O singură comandă. Zero erori.** Proiect Expo complet, gata de rulat.

## 🚀 Start în 10 secunde (Windows CMD)

Deschizi **CMD** în folderul proiectului și scrii:

```bat
kit
```

Atât. Scriptul face tot:
1. Verifică `Node.js` + `npm` (instalează automat cu `winget` dacă lipsește)
2. Verifică structura proiectului + repară `assets` dacă e nevoie
3. `npm install` (cu fallback `legacy-peer-deps` + curățare cache dacă e corupt)
4. Verifică `Expo CLI` + validează proiectul
5. Îți arată ce să faci mai departe (sau pornește direct cu `kit --go`)

### Variante

| Unde | Comanda unică | Ce face |
|------|---------------|---------|
| **Windows CMD** | `kit` | kit complet |
| **Windows CMD** | `kit --go` | kit + pornește Expo automat |
| **PowerShell** | `.\kit.ps1` | același lucru în PS |
| **PowerShell** | `.\kit.ps1 --go` | + pornire |
| **macOS / Linux** | `./setup.sh` sau `bash setup.sh` | kit |
| **orice OS** | `npm run kit` | kit |
| **orice OS** | `npm run go` | kit + start |
| **dublu-click** | `START.cmd` | kit + start |

După kit:

```bash
npm start       # Expo — scanezi QR cu Expo Go
npm run web     # deschide în browser
npm run android # Android
```

---

## 📦 Ce conține kit-ul

```
Abc-play-expo/
├── kit.cmd        → ONE COMMAND (Windows CMD)
├── kit.ps1        → ONE COMMAND (PowerShell)
├── START.cmd      → dublu-click = kit + start
├── setup.sh       → ONE COMMAND (macOS/Linux)
├── package.json   → dependințe fixe, fără conflicte
├── app.json       → config Expo
├── babel.config.js
├── App.js         → aplicația completă (A-Z, RO/EN, TTS)
├── assets/        → icon, splash, a.png/b.png/c.png
└── scripts/
    ├── kit.js     → creierul kit-ului (verificări + instalare)
    └── clean.js   → curățare cache (npm run clean)
```

### De ce nu ai erori

- **Node 18+ verificat** înainte de orice
- **`npm install` cu 3 încercări**: normal → `legacy-peer-deps` → curățare + reinstall
- **Assets reparate automat** — dacă lipsește o imagine, se generează placeholder ca să nu crape `require()`
- **Expo CLI verificat** — se instalează dacă lipsește
- **Idempotent** — poți rula `kit` de 100 de ori, nu strică nimic

---

## 🎮 Aplicația

- 26 de litere (A-Z), fiecare cu cuvânt în RO + EN
- Imagini pentru A/B/C + emoji fallback pentru rest (nu crapă niciodată)
- Buton **Spune cuvântul** + **Spune litera** (expo-speech, RO/EN)
- Animații + navigare swipe/dot-uri + random
- Responsive (telefon / tabletă / web)

---

## 🛠️ Cerințe

- **Node.js 18+** (verificat automat)
- Internet la prima instalare (npm)
- Opțional: aplicația **Expo Go** pe telefon pentru scanare QR

Instalare Node rapid: `winget install OpenJS.NodeJS.LTS` (Windows) sau https://nodejs.org

---

## ❓ Probleme?

| Eroare | Soluție |
|--------|---------|
| `Node nu este instalat` | `winget install OpenJS.NodeJS.LTS` → redeschizi CMD → `kit` |
| `npm install` eșuează | `npm run clean` → `kit` (kit-ul face asta automat) |
| `expo-speech` nu merge pe web | Normal — pe web folosește Web Speech API, pe telefon e nativ. Butonul tot funcționează. |
| imagini lipsă | Kit-ul regenerează placeholder-uri automat |

---

## 📄 Licență

MIT — folosește-l cum vrei.

## ✨ Preview HTML inclus

`astravex-preview.html` (din atașament) rămâne în repo ca referință de design — nu e necesar pentru rulare.
