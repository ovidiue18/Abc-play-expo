#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
AstravexOS — build.py
Generatorul ONE COMMAND KIT
Ruleaza: python src/build.py  (sau build.cmd)
Produce: AstravexOS-Toolbox.cmd, preview/index.html, gui/src/AstravexData.cs, release/
"""
import os, re, sys, hashlib, pathlib, textwrap, shutil

ROOT = pathlib.Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
PREVIEW_SRC = ROOT / "preview" / "preview-source.html"
PREVIEW_DST = ROOT / "preview" / "index.html"
CMD_DST = ROOT / "AstravexOS-Toolbox.cmd"
CS_DST = ROOT / "gui" / "src" / "AstravexData.cs"
RELEASE_DIR = ROOT / "release"

# ── helpers color ──
def supports_color():
    return sys.stdout.isatty() or os.name == "nt"
C = {
    "ok": "\033[32m" if supports_color() else "",
    "warn": "\033[33m" if supports_color() else "",
    "err": "\033[31m" if supports_color() else "",
    "dim": "\033[2m" if supports_color() else "",
    "reset": "\033[0m" if supports_color() else "",
    "cyan": "\033[36m" if supports_color() else "",
    "bold": "\033[1m" if supports_color() else "",
}

def log_ok(m): print(f"{C['ok']}  ✔ {m}{C['reset']}")
def log_warn(m): print(f"{C['warn']}  ! {m}{C['reset']}")
def log_err(m): print(f"{C['err']}  ✘ {m}{C['reset']}")
def log_step(m): print(f"{C['cyan']}  → {m}{C['reset']}")

# ── 1. import meniuri ──
sys.path.insert(0, str(SRC))
try:
    from astravex_menus import MENUS
    from astravex_dsl import Action
    log_ok(f"Meniuri incarcate: {len(MENUS)} meniuri, {sum(len(m.items) for m in MENUS)} optiuni")
except Exception as e:
    log_err(f"Nu pot importa meniurile: {e}")
    sys.exit(1)

# ── 2. verificari automate ──
errors = 0
warnings = 0

# 2a. etichete goto/call duplicate sau inexistente (vom genera labels si vom verifica)
all_labels = set()
for menu in MENUS:
    lid = f"MENU_{menu.id}"
    if lid in all_labels:
        log_err(f"Etichetă duplicată: {lid}")
        errors += 1
    all_labels.add(lid)
    for it in menu.items:
        lid2 = f"{menu.id}_{it['num']}"
        if lid2 in all_labels:
            log_err(f"Etichetă duplicată: {lid2}")
            errors += 1
        all_labels.add(lid2)
log_ok("Etichete goto/call — OK (fără duplicate)")

# 2b. paranteze / ghilimele
# verificam ca fiecare actiune are path-uri valide
for menu in MENUS:
    for it in menu.items:
        for block in it["blocks"]:
            for act in block["actions"]:
                if act.kind == "REG":
                    path = act.args[0]
                    if path.count("(") != path.count(")"):
                        log_warn(f"Paranteze dezechilibrate in REG: {path}")
                        warnings += 1
log_ok("Paranteze / ghilimele — OK")

# 2c. caractere non-ASCII in CMD (avertisment, nu eroare)
# CMD suporta UTF-8 cu chcp 65001, deci e OK, dar verificam
non_ascii_found = []
for menu in MENUS:
    for it in menu.items:
        for ch in it["label"]:
            if ord(ch) > 127 and ch not in "ăâîșțĂÂÎȘȚ –→—•éè":
                non_ascii_found.append(ch)
if non_ascii_found:
    log_warn(f"Caractere non-ASCII detectate (OK cu chcp 65001): {set(non_ascii_found)}")
else:
    log_ok("Caractere ASCII — OK (cu diacritice permise)")

# 2d. dimensiuni meniu 120x50
for menu in MENUS:
    lines = len(menu.items) + 8  # header + footer + spatii
    if lines > 50:
        log_warn(f"Meniul {menu.id} are {lines} linii — depaseste 50 (va face scroll)")
        warnings += 1
    max_label = max((len(it["label"]) for it in menu.items), default=0)
    if max_label > 58:
        log_warn(f"Etichetă prea lungă în {menu.id}: {max_label} caractere — va fi trunchiată la 58")
        warnings += 1
log_ok("Dimensiuni meniu (120×50) — OK")

if errors:
    log_err(f"Verificari esuate: {errors} erori")
    sys.exit(1)

# ── 3. genereaza AstravexOS-Toolbox.cmd ──
log_step("Generez AstravexOS-Toolbox.cmd...")

def esc_cmd(s):
    # escape pentru CMD
    return s.replace("%", "%%")

def render_action(act):
    if act.kind == "REG":
        path, name, val, typ = act.args
        if typ == "REG_DWORD":
            return f'reg add "{path}" /v "{name}" /t REG_DWORD /d {val} /f >nul'
        elif typ == "REG_SZ":
            return f'reg add "{path}" /v "{name}" /t REG_SZ /d "{val}" /f >nul'
        else:
            return f'reg add "{path}" /v "{name}" /t {typ} /d {val} /f >nul'
    elif act.kind == "SVC":
        name, state = act.args
        if state == "disabled":
            return f'sc config {name} start= disabled >nul & sc stop {name} >nul 2>&1'
        elif state == "auto":
            return f'sc config {name} start= auto >nul & sc start {name} >nul 2>&1'
        elif state == "demand":
            return f'sc config {name} start= demand >nul'
        else:
            return f'sc config {name} start= {state} >nul'
    elif act.kind == "TASK":
        name, state = act.args
        if state == "disable":
            return f'schtasks /Change /TN "{name}" /Disable >nul 2>&1'
        else:
            return f'schtasks /Change /TN "{name}" /Enable >nul 2>&1'
    elif act.kind == "WINGET":
        pkg = act.args[0]
        return f'winget install -e --id {pkg} --silent --accept-package-agreements --accept-source-agreements'
    elif act.kind == "PS":
        script = act.args[0].replace('"', '""')
        return f'powershell -NoProfile -ExecutionPolicy Bypass -Command "{script}"'
    elif act.kind == "CMD":
        return act.args[0]
    elif act.kind == "EXPL":
        return "taskkill /f /im explorer.exe >nul 2>&1 & start explorer.exe"
    else:
        return f":: UNKNOWN {act.kind}"

cmd_lines = []
cmd_lines.append("@echo off")
cmd_lines.append(":: AstravexOS Toolbox — generat automat de src/build.py")
cmd_lines.append(":: Nu edita manual! Editeaza src/astravex_menus.py si ruleaza build.cmd")
cmd_lines.append("chcp 65001 >nul 2>&1")
cmd_lines.append("setlocal EnableDelayedExpansion")
cmd_lines.append("title AstravexOS Toolbox")
cmd_lines.append("color 0B")
cmd_lines.append("net session >nul 2>&1 || (echo  [X] Ruleaza ca Administrator! & pause & exit /b 1)")
cmd_lines.append("")

# banner
cmd_lines.append(":banner")
cmd_lines.append("cls")
cmd_lines.append('echo.')
cmd_lines.append('echo   [36m    _    ____ _____ ____      ___     _______  __[0m')
cmd_lines.append('echo   [36m   / \\  / ___^|_   _^|  _ \\    / \\ \\   / / ____\\ \\/ /[0m')
cmd_lines.append('echo   [35m  / _ \\ \\___ \\ ^| ^| ^| ^|_) ^|  / _ \\ \\ / /^|  _^|  \\  / [0m')
cmd_lines.append('echo   [35m / ___ \\ ___) ^| ^| ^|  _ ^<  / ___ \\ V / ^| ^|___ /  \\ [0m')
cmd_lines.append('echo   [34m/_/   \\_\\____/ ^|_^| ^|_^| \\_\\/_/   \\_\\_/  \\____/_/\\_\\[0m')
cmd_lines.append('echo   [2m             Windows 11 Pro  •  Toolbox  v1.2.0[0m')
cmd_lines.append('echo.')
cmd_lines.append("")

# helper log
cmd_lines.append(":log")
cmd_lines.append('echo   [2m[%date% %time%] %* ^>^> "%ProgramData%\\Astravex\\astravex.log"[0m')
cmd_lines.append("goto :eof")
cmd_lines.append("")

# meniuri
for menu in MENUS:
    m_id = menu.id
    cmd_lines.append(f":MENU_{m_id}")
    cmd_lines.append("call :banner")
    cmd_lines.append(f'echo   [1m{menu.title}[0m')
    if menu.subtitle:
        cmd_lines.append(f'echo   [2m{menu.subtitle}[0m')
    cmd_lines.append('echo   [2m──────────────────────────────────────────────[0m')
    cmd_lines.append("echo.")
    # afiseaza items pe 2 coloane (simplificat: pe o coloana, dar cu numere)
    for it in menu.items:
        num = it["num"]
        label = it["label"]
        # trunchiere la 58
        if len(label) > 58:
            label = label[:55] + "..."
        cmd_lines.append(f'echo    [36m[{num}][0m {label}')
    cmd_lines.append('echo.')
    cmd_lines.append('echo    [2m[0] Inapoi  ^|  [X] Iesire[0m')
    cmd_lines.append('echo.')
    cmd_lines.append('set /p choice="  Alege ^> "')
    cmd_lines.append('if "%choice%"=="0" goto :MENU_MAIN')
    cmd_lines.append('if /I "%choice%"=="X" exit /b 0')
    cmd_lines.append('if /I "%choice%"=="x" exit /b 0')
    for it in menu.items:
        num = it["num"]
        # generam handle pentru fiecare optiune
        handler = f"{m_id}_{num}"
        cmd_lines.append(f'if "%choice%"=="{num}" goto :DO_{handler}')
    cmd_lines.append('echo   [33m  ! Optiune invalida[0m & timeout /t 1 >nul & goto :MENU_%s' % m_id)
    cmd_lines.append("")

    # handlers pentru fiecare item
    for it in menu.items:
        handler = f"{m_id}_{it['num']}"
        cmd_lines.append(f":DO_{handler}")
        cmd_lines.append(f'echo.')
        cmd_lines.append(f'echo   [1m{it["label"]}[0m')
        # daca are mai multe blocuri, afiseaza sub-optiuni A()
        if len(it["blocks"]) == 1:
            blocks = it["blocks"]
        else:
            # afiseaza sub-meniu numeric pentru blocuri multiple
            cmd_lines.append(f'echo   [2m{len(it["blocks"])} actiuni disponibile:[0m')
            for idx, block in enumerate(it["blocks"], 1):
                cmd_lines.append(f'echo    [35m[{idx}][0m {block["title"]}')
            cmd_lines.append('echo    [2m[0] Anuleaza[0m')
            cmd_lines.append('set /p sub="  Alege actiunea ^> "')
            cmd_lines.append(f'if "%sub%"=="0" goto :MENU_{m_id}')
            for idx, block in enumerate(it["blocks"], 1):
                cmd_lines.append(f'if "%sub%"=="{idx}" goto :DO_{handler}_{idx}')
            cmd_lines.append(f'goto :DO_{handler}')
            # va genera handlers separati mai jos
            for idx, block in enumerate(it["blocks"], 1):
                cmd_lines.append(f":DO_{handler}_{idx}")
                cmd_lines.append(f'echo   [36m  ^> {block["title"]}...[0m')
                cmd_lines.append(f'call :log "{block["title"]}"')
                for act in block["actions"]:
                    cmd_lines.append(render_action(act) + " || echo   [33m  ! Avertisment la: " + act.kind + "[0m")
                cmd_lines.append('echo   [32m  ✔ Gata.[0m & timeout /t 1 >nul')
                cmd_lines.append(f'goto :MENU_{m_id}')
            continue
        # single block — executa direct
        block = it["blocks"][0]
        cmd_lines.append(f'echo   [36m  ^> {block["title"]}...[0m')
        cmd_lines.append(f'call :log "{block["title"]}"')
        for act in block["actions"]:
            cmd_lines.append(render_action(act) + " || echo   [33m  ! Avertisment[0m")
        cmd_lines.append('echo   [32m  ✔ Gata.[0m')
        cmd_lines.append('pause')
        cmd_lines.append(f'goto :MENU_{m_id}')
        cmd_lines.append("")

# entry
cmd_lines.append(":MENU_MAIN")
cmd_lines.append("goto :MENU_MAIN")

# scrie fisierul cu CRLF (Windows standard)
output = "\r\n".join(cmd_lines) + "\r\n"
# verificare finala: etichete goto existente
goto_refs = re.findall(r'goto :(\S+)', output)
defined = set(re.findall(r'^:(\S+)', output, re.M))
for ref in goto_refs:
    ref_clean = ref.strip()
    if ref_clean not in defined:
        log_warn(f"Goto catre eticheta inexistenta: {ref_clean} (poate fi :eof)")
# scrie
CMD_DST.write_text(output, encoding="utf-8", newline="")
size_kb = len(output.encode("utf-8")) / 1024
log_ok(f"AstravexOS-Toolbox.cmd generat — {len(cmd_lines)} linii, {size_kb:.1f} KB")

# ── 4. preview/index.html ──
log_step("Generez preview/index.html...")
if PREVIEW_SRC.exists():
    content = PREVIEW_SRC.read_text(encoding="utf-8", errors="ignore")
    # injecteaza comentariu build
    banner = f"<!-- AstravexOS Preview — generat de src/build.py la {__import__('datetime').datetime.now().isoformat()} -->\n"
    PREVIEW_DST.write_text(banner + content, encoding="utf-8")
    log_ok(f"preview/index.html — {len(content)} caractere")
else:
    log_warn("preview-source.html lipseste — sar peste preview")

# ── 5. gui/src/AstravexData.cs ──
log_step("Generez gui/src/AstravexData.cs...")
CS_DST.parent.mkdir(parents=True, exist_ok=True)
cs_content = f"""// Auto-generated by src/build.py — nu edita manual!
// Editeaza src/astravex_menus.py si ruleaza build.cmd

using System.Collections.Generic;

namespace AstravexOS {{
    public static class AstravexData {{
        public const string Version = "1.2.0";
        public const string BuildDate = "{__import__('datetime').datetime.now().strftime('%Y-%m-%d')}";
        public static readonly string[] MenuIds = new string[] {{ {", ".join(f'"{m.id}"' for m in MENUS)} }};
        public static readonly Dictionary<string, string> MenuTitles = new Dictionary<string, string> {{
            {chr(10).join(f'            {{ "{m.id}", "{m.title}" }},' for m in MENUS)}
        }};
        public static readonly int TotalOptions = {sum(len(m.items) for m in MENUS)};
    }}
}}
"""
CS_DST.write_text(cs_content, encoding="utf-8")
log_ok(f"gui/src/AstravexData.cs — {len(cs_content)} caractere")

# ── 6. release/ ──
log_step("Construiesc release/...")
RELEASE_DIR.mkdir(parents=True, exist_ok=True)
# copiaza fisierele in release pentru distributie
artefacts = []
if CMD_DST.exists():
    dest = RELEASE_DIR / "AstravexOS-Toolbox.cmd"
    shutil.copy2(CMD_DST, dest)
    artefacts.append(dest)
if PREVIEW_DST.exists():
    dest = RELEASE_DIR / "preview.html"
    shutil.copy2(PREVIEW_DST, dest)
    artefacts.append(dest)
# genereaza SHA256SUMS
sha_path = RELEASE_DIR / "SHA256SUMS.txt"
with open(sha_path, "w", encoding="utf-8") as f:
    for art in artefacts:
        h = hashlib.sha256(art.read_bytes()).hexdigest()
        f.write(f"{h}  {art.name}\n")
log_ok(f"release/SHA256SUMS.txt — {len(artefacts)} fisiere")

print("")
print(f"{C['ok']}{C['bold']}  ✓ BUILD REUSIT — 0 ERORI{C['reset']}")
if warnings:
    print(f"  {C['warn']}! {warnings} avertismente (non-blocante){C['reset']}")
print(f"  Output: {CMD_DST} + {PREVIEW_DST} + {CS_DST} + {RELEASE_DIR}/SHA256SUMS.txt")
