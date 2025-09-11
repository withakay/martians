from __future__ import annotations
from dataclasses import dataclass
from .types import Position, Orientation


@dataclass
class Robot:
    position: Position
    orientation: Orientation
    lost: bool = False

    def turn_left(self) -> None:
        self.orientation = {
            Orientation.N: Orientation.W,
            Orientation.W: Orientation.S,
            Orientation.S: Orientation.E,
            Orientation.E: Orientation.N,
        }[self.orientation]

    def turn_right(self) -> None:
        self.orientation = {
            Orientation.N: Orientation.E,
            Orientation.E: Orientation.S,
            Orientation.S: Orientation.W,
            Orientation.W: Orientation.N,
        }[self.orientation]

    def next_forward(self) -> Position:
        match self.orientation:
            case Orientation.N:
                return Position(self.position.x, self.position.y + 1)
            case Orientation.E:
                return Position(self.position.x + 1, self.position.y)
            case Orientation.S:
                return Position(self.position.x, self.position.y - 1)
            case Orientation.W:
                return Position(self.position.x - 1, self.position.y)
        return self.position

