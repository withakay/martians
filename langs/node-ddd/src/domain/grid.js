"use strict";

function contains(maxX, maxY, p) {
  return 0 <= p.x && p.x <= maxX && 0 <= p.y && p.y <= maxY;
}

module.exports = { contains };
