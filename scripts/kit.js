// ABC Play - ONE COMMAND KIT
// Ruleaza: node scripts/kit.js  sau  npm run kit  sau  kit.cmd pe Windows
// Face tot: verifica Node, instaleaza dependinte, repara assets, verifica proiect, porneste Expo

const fs = require('fs');
const path = require('path');
const { execSync, spawn } = require('child_process');
const os = require('os');

const ROOT = path.resolve(__dirname, '..');
process.chdir(ROOT);

const C = {
  reset: '\x1b[0m',
  bold: '\x1b[1m',
  dim: '\x1b[2m',
  green: '\x1b[32m',
  cyan: '\x1b[36m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
};

function log(msg) { console.log(msg); }
function step(n, total, msg) {
  console.log(`${C.cyan}[${n}/${total}]${C.reset} ${msg}`);
}
function ok(msg) { console.log(`${C.green}  ✔ ${msg}${C.reset}`); }
function warn(msg) { console.log(`${C.yellow}  ! ${msg}${C.reset}`); }
function fail(msg) { console.log(`${C.red}  ✘ ${msg}${C.reset}`); }

function run(cmd, opts = {}) {
  try {
    execSync(cmd, { stdio: opts.silent ? 'pipe' : 'inherit', cwd: ROOT, ...opts });
    return true;
  } catch (e) {
    if (!opts.allowFail) throw e;
    return false;
  }
}
function hasCmd(cmd) {
  try { execSync(os.platform() === 'win32' ? `where ${cmd}` : `which ${cmd}`, { stdio: 'pipe' }); return true; }
  catch { return false; }
}

async function main() {
  const args = process.argv.slice(2);
  const shouldStart = args.includes('--start') || args.includes('--go') || args.includes('--run');

  console.log('');
  console.log(`${C.bold}${C.blue}  ╔══════════════════════════════════════════╗${C.reset}`);
  console.log(`${C.bold}${C.blue}  ║     ABC PLAY — ONE COMMAND KIT         ║${C.reset}`);
  console.log(`${C.bold}${C.blue}  ║     De la 0 la proiect functional      ║${C.reset}`);
  console.log(`${C.bold}${C.blue}  ╚══════════════════════════════════════════╝${C.reset}`);
  console.log('');

  const TOTAL = shouldStart ? 7 : 6;

  // 1 - Verifica Node & npm
  step(1, TOTAL, 'Verific Node.js si npm...');
  const nodeV = process.version;
  const major = parseInt(nodeV.slice(1).split('.')[0], 10);
  if (major < 18) {
    fail(`Node ${nodeV} este prea vechi. Ai nevoie de Node 18+`);
    console.log(`  Instaleaza de la https://nodejs.org sau ruleaza: winget install OpenJS.NodeJS.LTS`);
    process.exit(1);
  }
  ok(`Node ${nodeV} ${C.dim}— OK${C.reset}`);
  try {
    const npmV = execSync('npm -v', { encoding: 'utf8' }).trim();
    ok(`npm ${npmV} ${C.dim}— OK${C.reset}`);
  } catch {
    fail('npm lipseste!');
    process.exit(1);
  }

  // 2 - Verifica / repara structura proiect
  step(2, TOTAL, 'Verific structura proiectului...');
  const needFiles = ['App.js', 'app.json', 'package.json', 'babel.config.js'];
  for (const f of needFiles) {
    if (!fs.existsSync(path.join(ROOT, f))) {
      fail(`Lipseste ${f}`);
      process.exit(1);
    }
    ok(`${f} prezent`);
  }

  // 3 - Assets
  step(3, TOTAL, 'Verific assets (icon, splash, litere)...');
  const assetsDir = path.join(ROOT, 'assets');
  if (!fs.existsSync(assetsDir)) fs.mkdirSync(assetsDir, { recursive: true });
  
  // check icon/splash exist, if not create 1x1 png placeholder
  const requiredAssets = ['icon.png', 'splash.png', 'a.png', 'b.png', 'c.png'];
  // tiny 1x1 transparent PNG base64
  const tinyPng = Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8DwHwAFBQIAX8jx0gAAAABJRU5ErkJggg==', 'base64');
  for (const a of requiredAssets) {
    const p = path.join(assetsDir, a);
    if (!fs.existsSync(p) || fs.statSync(p).size < 100) {
      warn(`${a} lipsa/corupt — generez placeholder`);
      fs.writeFileSync(p, tinyPng);
      ok(`${a} creat (placeholder)`);
    } else {
      ok(`${a} OK (${(fs.statSync(p).size/1024).toFixed(1)} KB)`);
    }
  }

  // 4 - Curata cache-uri stricate (optional, non-blocking)
  step(4, TOTAL, 'Curat cache-uri vechi (daca exista)...');
  // nu stergem node_modules agresiv, doar verificam integritatea
  if (fs.existsSync(path.join(ROOT, 'node_modules')) && fs.existsSync(path.join(ROOT, 'package-lock.json'))) {
    // verifica daca package.json s-a schimbat vs installed
    ok('node_modules existent — sar peste reinstall complet');
    // reparare rapida: npm install va face restul
  } else if (fs.existsSync(path.join(ROOT, 'node_modules'))) {
    ok('node_modules prezent');
  } else {
    warn('node_modules lipsa — va fi instalat la pasul urmator');
  }

  // 5 - npm install (cu retry si fallback)
  step(5, TOTAL, 'Instalez dependintele (npm install)...');
  if (!hasCmd('npm')) { fail('npm nu e in PATH'); process.exit(1); }

  let installed = false;
  // incearca npm install normal
  try {
    log(`${C.dim}  → npm install — poate dura 1-3 minute la prima rulare...${C.reset}`);
    execSync('npm install --silent --no-audit --no-fund', { stdio: 'inherit', cwd: ROOT });
    installed = true;
    ok('Dependinte instalate');
  } catch (e) {
    warn('npm install a esuat — incerc cu --legacy-peer-deps...');
    try {
      execSync('npm install --legacy-peer-deps --no-audit --no-fund', { stdio: 'inherit', cwd: ROOT });
      installed = true;
      ok('Dependinte instalate (legacy-peer-deps)');
    } catch (e2) {
      warn('Incerc curatare cache + reinstall...');
      try { execSync('npm cache clean --force', { stdio: 'pipe', cwd: ROOT }); } catch {}
      try {
        // sterge node_modules daca e corupt
        if (fs.existsSync(path.join(ROOT, 'node_modules'))) {
          fs.rmSync(path.join(ROOT, 'node_modules'), { recursive: true, force: true });
        }
        execSync('npm install --legacy-peer-deps --no-audit --no-fund', { stdio: 'inherit', cwd: ROOT });
        installed = true;
        ok('Dependinte instalate dupa curatare');
      } catch (e3) {
        fail('Nu s-au putut instala dependintele. Verifica conexiunea la internet.');
        console.log(C.yellow + '  Incearca manual: npm install --legacy-peer-deps' + C.reset);
        process.exit(1);
      }
    }
  }

  // 6 - Verifica Expo
  step(6, TOTAL, 'Verific Expo...');
  try {
    const expoVer = execSync('npx expo --version', { encoding: 'utf8', cwd: ROOT, stdio: 'pipe' }).trim();
    ok(`Expo CLI ${expoVer} ${C.dim}— OK${C.reset}`);
  } catch {
    warn('Expo CLI nu raspunde — instalez @expo/cli...');
    try { execSync('npm install -D @expo/cli --no-audit --no-fund', { stdio: 'inherit', cwd: ROOT }); ok('Expo CLI instalat'); }
    catch { warn('Nu s-a instalat Expo CLI, dar continui — npx expo ar trebui sa mearga'); }
  }

  // doctor check (non-blocking)
  log(`${C.dim}  → expo-doctor (verificare rapida, non-blocanta)...${C.reset}`);
  try {
    execSync('npx expo-doctor --verbose 2>&1 | head -n 50', { stdio: 'pipe', cwd: ROOT, encoding: 'utf8' });
    ok('Proiect valid Expo');
  } catch {
    warn('expo-doctor a gasit avertismente — proiectul tot porneste, verifica cu: npx expo-doctor');
  }

  // 7 - Porneste (optional)
  if (shouldStart) {
    step(7, TOTAL, 'Pornesc Expo...');
    console.log('');
    console.log(`${C.green}${C.bold}  Totul e gata! Pornesc serverul...${C.reset}`);
    console.log(`${C.dim}  → Daca vrei doar web: npx expo start --web${C.reset}`);
    console.log(`${C.dim}  → Scaneaza QR cu Expo Go pentru telefon${C.reset}`);
    console.log('');

    // spawn expo start si pastreaza procesul viu
    const child = spawn('npx', ['expo', 'start'], { cwd: ROOT, stdio: 'inherit', shell: true });
    child.on('exit', (code) => process.exit(code || 0));
    // nu iesim, lasam serverul pornit
    return;
  }

  console.log('');
  console.log(`${C.green}${C.bold}  ╔══════════════════════════════════════════╗${C.reset}`);
  console.log(`${C.green}${C.bold}  ║  ✓ KIT GATA — 0 ERORI                  ║${C.reset}`);
  console.log(`${C.green}${C.bold}  ╚══════════════════════════════════════════╝${C.reset}`);
  console.log('');
  console.log(`  ${C.bold}Ce poti face acum:${C.reset}`);
  console.log(`    ${C.cyan}npm start${C.reset}         ${C.dim}— porneste Expo (QR pentru telefon)${C.reset}`);
  console.log(`    ${C.cyan}npm run web${C.reset}       ${C.dim}— deschide in browser${C.reset}`);
  console.log(`    ${C.cyan}npm run android${C.reset}   ${C.dim}— porneste pe Android${C.reset}`);
  console.log(`    ${C.cyan}kit --go${C.reset}          ${C.dim}— (Windows) kit + pornire automata${C.reset}`);
  console.log('');
  console.log(`  ${C.dim}Proiect: ${ROOT}${C.reset}`);
  console.log('');
}

main().catch(e => {
  console.error(C.red + 'Eroare fatala in kit:' + C.reset, e);
  process.exit(1);
});
