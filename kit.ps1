# ABC PLAY — ONE COMMAND KIT (PowerShell)
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     ABC PLAY — ONE COMMAND KIT (PS)     ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "[X] Node.js lipseste! Ruleaza: winget install OpenJS.NodeJS.LTS" -ForegroundColor Red; exit 1
}
Write-Host "[OK] Node $(node -v)" -ForegroundColor Green
Write-Host "[OK] npm $(npm -v)" -ForegroundColor Green
$go = $args -contains "--go" -or $args -contains "go"
if ($go) { node scripts/kit.js --start } else { node scripts/kit.js }
if ($LASTEXITCODE -ne 0) { Write-Host "[X] Eroare kit" -ForegroundColor Red; exit $LASTEXITCODE }
if (-not $go) {
  $r = Read-Host "Pornesc Expo acum? (y/n)"
  if ($r -eq "y" -or $r -eq "Y") { npx expo start }
}
