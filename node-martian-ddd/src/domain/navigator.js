"use strict";
const { contains } = require("./grid");

function execute(scents, grid, robot, instr) {
  for (const c of instr) {
    if (robot.lost) break;
    if (c === "L") robot.turnLeft();
    else if (c === "R") robot.turnRight();
    else if (c === "F") {
      const next = robot.nextForward();
      if (!contains(grid.maxX, grid.maxY, next)) {
        const keyPos = robot.position;
        const keyO = robot.orientation;
        if (!scents.has(keyPos, keyO)) {
          scents.add(keyPos, keyO);
          robot.lost = true;
        }
      } else {
        robot.position = next;
      }
    }
  }
}

module.exports = { execute };
