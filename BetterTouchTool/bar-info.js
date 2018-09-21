#!/usr/bin/env node
const os = require("os");

const uptime = os.uptime();
const hours = uptime / 60/ 60;
const days = hours / 24;
const info = [
  os.userInfo().username + "@" + os.hostname(),
  days.toFixed(2) + " days",
  os.loadavg().map(n => n.toFixed(2)).join(" / ")
];
console.log(info.join("  •  "));
