from __future__ import annotations
import sys
from ..application.mission import run_mission


def main() -> int:
    run_mission(sys.stdin, sys.stdout)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

