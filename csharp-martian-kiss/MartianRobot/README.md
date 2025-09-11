# Martian Robots

A small, focused .NET implementation of the “Martian Robots” kata.
It models a bounded rectangular grid on Mars and processes a sequence of robots,
each with an initial position and a string of instructions.

This repository contains a reusable core library and xUnit tests.
There is no CLI app by design to keep the solution minimal;
the tests and the example snippet below demonstrate usage.

---

## What’s Implemented

- Core domain types: `Coordinate`, `Grid`, `Direction`, `Scent`, `RobotState`.
- Parser: `InputParser.Parse(string)` → upper‑right grid coordinate and a list of robots with their starting state and instruction string.
- Simulator: `RobotSimulator` that processes robots sequentially, leaving “scents” when a robot is lost and ignoring future identical “fall” moves.
- All rules from the PDF, including:
  - Bounded rectangular grid with lower‑left at `(0,0)`.
  - Instructions `L`, `R`, `F` (turn left, turn right, move forward).
  - Robots run sequentially and share scents.
  - Unknown instruction characters are ignored safely (extensibility hook).

---

## Project Layout

```
MartianRobot.sln
src/
  MartianRobot.Core/
    Direction.cs       // Direction enum + turning/stepping helpers
    Models.cs          // Coordinate, Grid, Scent, RobotState
    InputParser.cs     // Reads the text format defined in the PDF
    Simulator.cs       // RobotSimulator and IRobotSimulator

tests/
  MartianRobot.Core.Tests/ // xUnit tests for parsing and scenarios
```

Target framework: `.NET 9.0` (see `src/MartianRobot.Core/MartianRobot.Core.csproj`).

---

## Prerequisites

- .NET SDK 9.0 or newer: `dotnet --version` should report `9.x`.

---

## Build & Test

- Build the solution:

  ```bash
  dotnet build
  ```

- Run all tests (xUnit):

  ```bash
  dotnet test
  ```

---

## Usage (Library)

Here’s a minimal example that parses the sample input from the brief and prints the expected output.
You can paste this into a quick console app that references `MartianRobot.Core` or run inside a scratch project.

```csharp
using System;
using System.Linq;
using MartianRobot.Core;      // Models + InputParser
using MartianRobot.Core;     // Direction + RobotSimulator

var input = """
5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL
""";

var (grid, robots) = InputParser.Parse(input);
var sim = new RobotSimulator();
var results = sim.RunAll(grid, robots);

foreach (var r in results)
{
    Console.WriteLine(r.ToString()); // ToString() adds " LOST" when applicable
}
```

Expected output (matches the PDF):

```
1 1 E
3 3 N LOST
2 3 S
```

---

## Usage (CLI)

The repository now includes a minimal console app that reads from standard input and writes results to standard output.

- Run with the included sample input:

  ```bash
  cat samples/sample-input.txt | dotnet run --project src/MartianRobot.Cli
  ```

- Or run interactively and paste input, then Ctrl+D (Unix/macOS) or Ctrl+Z, Enter (Windows):

  ```bash
  dotnet run --project src/MartianRobot.Cli
  ```

---

## Input Format (from the PDF)

- Line 1: Upper‑right grid coordinates `X Y` (lower‑left is implicitly `0 0`).
- Then, for each robot (two lines):
  - Initial position `x y D` where `D` ∈ `{N,E,S,W}`.
  - Instruction string of `L`, `R`, `F` (less than 100 characters).
- Maximum coordinate value is 50.
- Robots are processed sequentially; scents from lost robots affect subsequent robots.

---

## Design Notes

- `RobotSimulator` keeps a set of `Scent` values `(position, direction)`; when a forward move would fall off the grid at a scented edge, that move is ignored, and the robot continues.
- Unknown instruction characters are ignored to allow future extensions without breaking existing input.
- `RobotState.ToString()` emits `"X Y D"` and appends `" LOST"` when `Lost == true`.
- Parsing uses invariant culture; blank lines are ignored; incomplete robot pairs are skipped safely.

---

## Extending

- New commands: add another case in `RobotSimulator.RunOne`’s instruction switch and (optionally) helper(s) in `MoveOperation`.
- Alternative parsers or I/O: keep `RobotSimulator` unchanged and supply robots from another source (JSON, CLI, etc.).
- CLI: if desired, add a small console project that wires `InputParser` + `RobotSimulator` and prints results line‑by‑line.

---

## Sample Data

The original challenge sample is included above. You can also drop that into a file (e.g., `input.txt`) and feed its contents to `InputParser.Parse(File.ReadAllText("input.txt"))`.

---

## Assumptions & Edge Cases

- Coordinates are inclusive bounds; moving outside marks the robot as lost and leaves a scent at the last valid cell with the attempted direction.
- Header must contain at least two integers; otherwise an `ArgumentException` is thrown.
- Invalid direction tokens in positions throw `ArgumentException`.
- Empty input throws `ArgumentException("Empty input")`.

---

## License

No explicit license file was supplied with the challenge brief. If you plan to publish this repository publicly, consider adding a license to clarify usage.

---

## Acknowledgements

Problem statement © Red Badger Consulting Limited (Coding Challenge 2018).
