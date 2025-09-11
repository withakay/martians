from __future__ import annotations
from typing import TextIO
from ..domain.grid import Grid
from ..domain.robot import Robot
from ..domain.types import Orientation, Position
from ..domain.scents import ScentRepository


def _read_non_empty(r: TextIO) -> str | None:
    while True:
        line = r.readline()
        if line == "":
            return None
        line = line.strip()
        if line:
            return line


def _parse_grid(line: str) -> tuple[int, int]:
    xs = [int(tok) for tok in line.split()]
    if len(xs) != 2:
        raise ValueError("grid line must have two integers")
    return xs[0], xs[1]


def _parse_robot(line: str) -> tuple[Position, Orientation]:
    parts = line.split()
    if len(parts) != 3:
        raise ValueError("robot line must be: X Y O")
    x, y, o = int(parts[0]), int(parts[1]), parts[2]
    return Position(x, y), Orientation(o)


def run_mission(stdin: TextIO, stdout: TextIO) -> None:
    header = _read_non_empty(stdin)
    if header is None:
        return
    gx, gy = _parse_grid(header)
    grid = Grid(gx, gy)
    scents = ScentRepository()

    while True:
        meta = _read_non_empty(stdin)
        if meta is None:
            break
        pos, o = _parse_robot(meta)
        instr = _read_non_empty(stdin) or ""
        instr = "".join(ch for ch in instr if ch in "LRF")

        robot = Robot(pos, o)
        for ch in instr:
            if robot.lost:
                break
            if ch == "L":
                robot.turn_left()
            elif ch == "R":
                robot.turn_right()
            elif ch == "F":
                nxt = robot.next_forward()
                if not grid.contains(nxt):
                    if not scents.has(robot.position, robot.orientation):
                        scents.add(robot.position, robot.orientation)
                        robot.lost = True
                else:
                    robot.position = nxt

        stdout.write(f"{robot.position.x} {robot.position.y} {robot.orientation.value}")
        if robot.lost:
            stdout.write(" LOST")
        stdout.write("\n")
    # trailing newline to match goldens
    stdout.write("\n")
