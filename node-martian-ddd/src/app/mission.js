"use strict";
const { Robot } = require("../domain/robot");
const { ScentRepository } = require("../domain/scents");
const { execute } = require("../domain/navigator");
const {
  parseGrid,
  parseRobot,
  normalizeInstr,
  splitNonEmpty,
} = require("./parse");

function runMission(input) {
  const lines = splitNonEmpty(input);
  if (lines.length === 0) return "\n";
  const { maxX, maxY } = parseGrid(lines[0]);
  const grid = { maxX, maxY };
  const scents = new ScentRepository();
  const out = [];
  for (let i = 1; i + 1 < lines.length; i += 2) {
    const { x, y, o } = parseRobot(lines[i]);
    const instr = normalizeInstr(lines[i + 1]);
    const robot = new Robot({ x, y }, o);
    execute(scents, grid, robot, instr);
    out.push(
      `${robot.position.x} ${robot.position.y} ${robot.orientation}${robot.lost ? " LOST" : ""}`,
    );
  }
  return out.join("\n") + "\n\n";
}

module.exports = { runMission };
