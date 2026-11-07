#!/usr/bin/env bash
# ABC PLAY — ONE COMMAND KIT (macOS / Linux)
set -e
echo "╔══════════════════════════════════════════╗"
echo "║     ABC PLAY — ONE COMMAND KIT         ║"
echo "╚══════════════════════════════════════════╝"
if ! command -v node >/dev/null 2>&1; then echo "[X] Node lipseste. Instaleaza de la https://nodejs.org"; exit 1; fi
echo "[OK] Node $(node -v)"
echo "[OK] npm $(npm -v)"
if [[ "$1" == "--go" || "$1" == "go" ]]; then node scripts/kit.js --start; else node scripts/kit.js; fi
