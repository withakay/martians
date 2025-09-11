"use strict";
const { runMission } = require("./app/mission");

let data = "";
process.stdin.setEncoding("utf8");
process.stdin.on("data", (chunk) => (data += chunk));
process.stdin.on("end", () => {
  const out = runMission(data);
  process.stdout.write(out);
});
