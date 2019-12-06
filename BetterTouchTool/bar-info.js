#!/usr/bin/env node
const { execSync } = require("child_process");

const sep = " ";
const pct = (() => {
  if (2 in process.argv) {
    return Number(process.argv[2]);
  }
  const str = execSync("pmset -g batt", { encoding: "utf-8" });
  const [, level] = str.match(/(\d+)%/) || [];
  return Number(level);
})();

const allSymbols = {
  moons: {
    none: "\u{1f311}",
    less: "\u{1f318}",
    half: "\u{1f317}",
    more: "\u{1f316}",
    full: "\u{1f315}"
  },
  hearts: {
    none: "\u{1f5a4}",
    less: "\u{1f494}",
    half: "\u{1f494}",
    more: "\u{2764}\u{fe0f}",
    full: "\u{2764}\u{fe0f}"
  },
  bars: {
    none: "\u{2581}",
    less: "\u{2584}",
    half: "\u{2584}",
    more: "\u{2584}",
    full: "\u{2588}"
  }
};

const symbols = allSymbols.hearts;

const before = Math.floor(pct / 10);
const after = Math.floor((100 - pct) / 10);
const out = ["Battery: "];
for (let x = 0; x < before; x++) {
  out.push(symbols.full);
}
const digit = pct % 10;
if (digit < 1) {
  // Do nothing
} else if (digit < 5) {
  out.push(symbols.less);
} else if (digit === 5) {
  out.push(symbols.half);
} else {
  out.push(symbols.more);
}
for (let x = 0; x < after; x++) {
  out.push(symbols.none);
}
console.log(out.join(sep));
