#!/usr/bin/env bash
set -e
echo "╔════════════════════════════════════════════════╗"
echo "║  ASTRAVEX OS — WINDOWS KIT                   ║"
echo "╚════════════════════════════════════════════════╝"
cd "$(dirname "$0")/AstravexOS"
python3 src/build.py
echo "GATA! Deschide preview/index.html in browser"
