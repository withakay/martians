"use strict";

function parseGrid(line) {
  const [x, y] = line.trim().split(/\s+/).map(Number);
  return { maxX: x, maxY: y };
}

function parseRobot(line) {
  const [x, y, o] = line.trim().split(/\s+/);
  return { x: Number(x), y: Number(y), o };
}

function normalizeInstr(line) {
  return line
    .trim()
    .split("")
    .filter((c) => c === "L" || c === "R" || c === "F")
    .join("");
}

function splitNonEmpty(text) {
  return text
    .split(/\r?\n/)
    .map((s) => s.trim())
    .filter(Boolean);
}

module.exports = { parseGrid, parseRobot, normalizeInstr, splitNonEmpty };
