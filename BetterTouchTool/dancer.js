#!/usr/bin/env node

const date = new Date();
const interval = 1;
const t = date.getSeconds() / interval;
const n = 10;
const x = Math.floor(t % n);
const theme = {
  text: {
    blank: "-",
    walk1: "+",
    walk2: "x"
  },
  hearts: {
    blank: "\u{1f5a4}",
    walk1: "\u{1f49a}",
    walk2: "\u{1f499}"
  },
  moons: {
    blank: "\u{1f311}",
    walk1: "\u{1f31b}",
    walk2: "\u{1f31c}"
  }
}.moons;
const output =
  "Tick: " +
  theme.blank.repeat(x) +
  (x % 2 === 0 ? theme.walk1 : theme.walk2) +
  theme.blank.repeat(n - x - 1);

console.error({ n, x, t });
console.log(output);
