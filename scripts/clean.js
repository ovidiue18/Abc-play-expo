const fs = require('fs');
const path = require('path');
const ROOT = path.resolve(__dirname, '..');
for (const p of ['node_modules', '.expo', 'dist', 'web-build']) {
  const full = path.join(ROOT, p);
  if (fs.existsSync(full)) {
    console.log(`Sterg ${p}...`);
    fs.rmSync(full, { recursive: true, force: true });
  }
}
console.log('Curat!');
