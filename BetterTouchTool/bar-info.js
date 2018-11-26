const { execSync } = require("child_process");

const str = execSync("pmset -g batt", { encoding: "utf-8" });
const [, level] = str.match(/(\d+)%/);
const pct = Number(level);
const symbols = [0x1f315, 0x1f316, 0x1f317, 0x1f318, 0x1f311].map(n => {
  return String.fromCodePoint(n);
});
for (let x = 0; x < Math.floor(pct / 10); x++) {
  process.stdout.write(symbols[0]);
}
process.stdout.write(symbols[Math.floor((pct % 10) / 10 * symbols.length)]);
for (let x = 0; x < Math.floor((100 - pct) / 10); x++) {
  process.stdout.write(symbols[symbols.length - 1]);
}
process.stdout.write("\n");
