from __future__ import annotations
from dataclasses import dataclass
from enum import Enum


class Orientation(str, Enum):
    N = "N"
    E = "E"
    S = "S"
    W = "W"


@dataclass(frozen=True)
class Position:
    x: int
    y: int

