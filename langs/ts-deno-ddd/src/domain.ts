export type Dir = "N" | "E" | "S" | "W";

export const left = (d: Dir): Dir =>
  (({ N: "W", W: "S", S: "E", E: "N" }) as const)[d];
export const right = (d: Dir): Dir =>
  (({ N: "E", E: "S", S: "W", W: "N" }) as const)[d];
export const step = (d: Dir): [number, number] =>
  (({ N: [0, 1], E: [1, 0], S: [0, -1], W: [-1, 0] }) as const)[d];

export type Position = { x: number; y: number };
export type Grid = { maxX: number; maxY: number };

export const contains = (g: Grid, p: Position) =>
  0 <= p.x && p.x <= g.maxX && 0 <= p.y && p.y <= g.maxY;

export class Robot {
  position: Position;
  orientation: Dir;
  lost = false;
  constructor(position: Position, orientation: Dir) {
    this.position = position;
    this.orientation = orientation;
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

export interface ScentRepository {
  has(pos: Position, o: Dir): boolean;
  add(pos: Position, o: Dir): void;
}
export class InMemoryScents implements ScentRepository {
  private set = new Set<string>();
  has(pos: Position, o: Dir) {
    return this.set.has(`${pos.x},${pos.y},${o}`);
  }
  add(pos: Position, o: Dir) {
    this.set.add(`${pos.x},${pos.y},${o}`);
  }
}

export function execute(
  scents: ScentRepository,
  grid: Grid,
  robot: Robot,
  instr: string,
) {
  for (const c of instr) {
    if (robot.lost) break;
    if (c === "L") robot.turnLeft();
    else if (c === "R") robot.turnRight();
    else if (c === "F") {
      const next = robot.nextForward();
      if (!contains(grid, next)) {
        if (!scents.has(robot.position, robot.orientation)) {
          scents.add(robot.position, robot.orientation);
          robot.lost = true;
        }
      } else {
        robot.position = next;
      }
    }
  }
}
