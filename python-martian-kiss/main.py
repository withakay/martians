#!/usr/bin/env python3
import sys


def parse_int(s):
    return int(s)


dirs = ['N', 'E', 'S', 'W']
step = {'N': (0, 1), 'E': (1, 0), 'S': (0, -1), 'W': (-1, 0)}


def turn_left(d):
    return dirs[(dirs.index(d)-1) % 4]


def turn_right(d):
    return dirs[(dirs.index(d)+1) % 4]


def inside(x, y, maxx, maxy):
    return 0 <= x <= maxx and 0 <= y <= maxy


def run(data):
    lines = [ln.strip() for ln in data.splitlines() if ln.strip()]
    if not lines:
        raise ValueError('Empty input')
    header = lines[0].split()
    if len(header) < 2:
        raise ValueError('Invalid header')
    maxx, maxy = parse_int(header[0]), parse_int(header[1])

    scents = set()
    out = []
    i = 1
    while i+1 < len(lines):
        p = lines[i].split()
        i += 1
        instr = lines[i].strip()
        i += 1
        x, y, d = parse_int(p[0]), parse_int(p[1]), p[2]
        lost = False
        for c in instr:
            if lost:
                break
            if c == 'L':
                d = turn_left(d)
            elif c == 'R':
                d = turn_right(d)
            elif c == 'F':
                dx, dy = step[d]
                nx, ny = x+dx, y+dy
                if not inside(nx, ny, maxx, maxy):
                    key = (x, y, d)
                    if key in scents:
                        continue
                    scents.add(key)
                    lost = True
                else:
                    x, y = nx, ny
            else:
                # ignore unknown
                pass
        out.append(f"{x} {y} {d}" + (" LOST" if lost else ""))
    return "\n".join(out) + "\n\n"


def main():
    data = sys.stdin.read()
    if not data.strip():
        print("No input provided", file=sys.stderr)
        sys.exit(1)
    try:
        sys.stdout.write(run(data))
    except Exception as e:
        print(str(e), file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
