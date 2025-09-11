import { Dir, Position, InMemoryScents, execute, Robot } from "./domain.ts";

export const parseGrid = (line: string) => {
  const [x, y] = line.trim().split(/\s+/).map(Number);
  return { maxX: x, maxY: y };
};

export const parseRobot = (line: string): { pos: Position; o: Dir } => {
  const [x, y, o] = line.trim().split(/\s+/);
  return { pos: { x: Number(x), y: Number(y) }, o: o as Dir };
};

export const normalizeInstr = (line: string) =>
  line
    .trim()
    .split("")
    .filter((c) => c === "L" || c === "R" || c === "F")
    .join("");

export function runMission(input: string): string {
  const lines = input
    .split(/\r?\n/)
    .map((s) => s.trim())
    .filter(Boolean);
  if (lines.length === 0) return "\n";
  const grid = parseGrid(lines[0]);
  const scents = new InMemoryScents();
  const out: string[] = [];
  for (let i = 1; i + 1 < lines.length; i += 2) {
    const { pos, o } = parseRobot(lines[i]);
    const instr = normalizeInstr(lines[i + 1]);
    const robot = new Robot(pos, o);
    execute(scents, grid, robot, instr);
    out.push(
      `${robot.position.x} ${robot.position.y} ${robot.orientation}${robot.lost ? " LOST" : ""}`,
    );
  }
  return out.join("\n") + "\n\n";
}
