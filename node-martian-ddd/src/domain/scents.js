"use strict";

class ScentRepository {
  constructor() {
    this.set = new Set();
  }
  has(pos, o) {
    return this.set.has(`${pos.x},${pos.y},${o}`);
  }
  add(pos, o) {
    this.set.add(`${pos.x},${pos.y},${o}`);
  }
}

module.exports = { ScentRepository };
