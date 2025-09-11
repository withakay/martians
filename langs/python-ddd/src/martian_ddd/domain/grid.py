from __future__ import annotations
from .types import Position


class Grid:
    def __init__(self, max_x: int, max_y: int) -> None:
        if max_x < 0 or max_y < 0:
            raise ValueError("Grid dimensions must be non-negative")
        self.max_x = max_x
        self.max_y = max_y

    def contains(self, pos: Position) -> bool:
        return 0 <= pos.x <= self.max_x and 0 <= pos.y <= self.max_y

