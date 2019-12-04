#!/usr/bin/env node

const date = new Date();
const interval = 1;
const t = date.getSeconds() / interval;
const n = 10;
const x = Math.floor(t % n);
const space = "_ ";
const person = "\u{1f3c3}"; // running guy
const output =
  "Hey, I'm walking here: " +
  space.repeat(n - x + 1) +
  person +
  space.repeat(x + 1);

console.error({ n, x, t });
console.log(output);
