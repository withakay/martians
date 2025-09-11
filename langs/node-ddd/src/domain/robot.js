"use strict";
const { left, right, step } = require("./orientation");

class Robot {
  constructor(position, orientation) {
    this.position = position;
    this.orientation = orientation;
    this.lost = false;
  }
  turnLeft() {
    this.orientation = left(this.orientation);
  }
  turnRight() {
    this.orientation = right(this.orientation);
  }
  nextForward() {
    const [dx, dy] = step(this.orientation);
    return { x: this.position.x + dx, y: this.position.y + dy };
  }
}

module.exports = { Robot };
