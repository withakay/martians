"use strict";

const dirs = ["N", "E", "S", "W"];

function left(d) {
  return dirs[(dirs.indexOf(d) - 1 + 4) % 4];
}
function right(d) {
  return dirs[(dirs.indexOf(d) + 1) % 4];
}
function step(d) {
  return { N: [0, 1], E: [1, 0], S: [0, -1], W: [-1, 0] }[d];
}

module.exports = { dirs, left, right, step };
