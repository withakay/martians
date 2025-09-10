from __future__ import annotations
from .types import Position, Orientation


class ScentRepository:
    def __init__(self) -> None:
        self._set: set[tuple[int, int, Orientation]] = set()

    def has(self, pos: Position, orientation: Orientation) -> bool:
        return (pos.x, pos.y, orientation) in self._set

    def add(self, pos: Position, orientation: Orientation) -> None:
        self._set.add((pos.x, pos.y, orientation))

