# Martian Robots — Multilingual Reference Solutions

This repository contains working solutions to the Martian Robots programming challenge across many languages. It provides both minimal “Keep It Simple (KISS)” versions and more structured Domain‑Driven Design (DDD) examples, all runnable in Docker and verified by a common harness.

- Problem statement: see `CHALLENGE.md` (adapted from Red Badger Coding Challenge 2018).
- Golden I/O: sample input in `samples/inputs/sample-input.txt`, expected output in `samples/outputs/sample-output.txt`.

## Implementations

Naming & layout:

- All implementations live under `langs/`.
- Suffix `-kiss` for minimal versions; `-ddd` for layered DDD examples.

Use `make list` to see what’s available. Examples:

- `langs/python-kiss`, `langs/python-ddd`
- `langs/csharp-kiss`, `langs/csharp-ddd`
- `langs/go-kiss`, `langs/go-ddd`
- `langs/rust-kiss`, `langs/rust-ddd`
- `langs/node-kiss`, `langs/node-ddd`
- `langs/ts-deno-kiss`, `langs/ts-deno-ddd`
- `langs/java-kiss`, `langs/java-ddd`
- `langs/ocaml-kiss`, `langs/ocaml-ddd`

Each folder includes a `Dockerfile` and a small README with language‑specific notes.

## Quick Start

Prerequisites:

- Docker installed and available on your PATH
- Bash/Make (GNU Make 4.x)

Useful commands:

- Run the full harness across all implementations (all fixtures)

  ```bash
  ./tools/harness.sh
  # or
  make test-all
  ```

- List detected implementations

  ```bash
  make list
  ```

- Test a single implementation by folder name

  ```bash
  LANGS="python-ddd" ./tools/harness.sh
  # or via Make’s generated targets
  make test-langs/python-ddd
  ```

- Build images for everything (without running)
  ```bash
  make build-all
  ```

## Run One Implementation Manually (Example)

Every implementation reads STDIN and writes to STDOUT (no prompts). Images are tagged as `martian:<folder-name>`.

Example with Python (DDD):

```bash
docker build -f langs/python-ddd/Dockerfile -t martian:python-ddd .
cat samples/inputs/sample-input.txt | docker run --rm -i martian:python-ddd
```

Example with C# (.NET, KISS wrapper around the reference CLI):

```bash
docker build -f langs/csharp-kiss/Dockerfile -t martian:csharp-kiss .
cat samples/inputs/sample-input.txt | docker run --rm -i martian:csharp-kiss
```

For local (non‑Docker) runs, see each language folder’s README.

## How The Harness Works

`tools/harness.sh` will:

- Discover folders under `langs/*`
- Build each image using its `Dockerfile`
- For each `samples/inputs/*-input.txt`, pipe into the container and compare against `samples/outputs/*-output.txt`
- Normalize line endings and trailing blanks on both actual and expected

Tip: The expected output includes a trailing blank line; implementations are written to match it exactly.

## Common Assumptions & Gaps

- Input tolerant: trims blank lines; ignores non-L/R/F characters in instruction lines.
- No hard enforcement of limits from CHALLENGE.md (≤50 coords, ≤100 instructions).
- Grid upper-right bound is inclusive; scents are keyed by (position, orientation).
- Minimal error handling; invalid tokens may fail fast or be ignored depending on language.
- Single sample exercised in CI; not exhaustive.

## Areas for Improvement

- Strict input validation and clear errors per spec (bounds, tokens, lengths).
- Additional fixtures and property/fuzz tests across languages.
- Optional CLI flags (e.g., `--strict`, `--no-trim`) and multi-file support.
- Package/publish some versions (crates.io, PyPI, npm) and slim Docker images.
- Benchmark and document complexity; add docs on extending with new commands.

## Adding Another Language

1. Create a folder under `langs/` named like `langs/<lang>-kiss` (or `langs/<lang>-ddd`).
2. Add a `Dockerfile` that produces an executable reading from STDIN and writing to STDOUT.
3. Ensure output exactly matches `samples/outputs/sample-output.txt` for `samples/inputs/sample-input.txt`.
4. Add a short README with Docker build/run instructions.
5. Run `./tools/harness.sh` to verify.

## References

- Challenge description: `CHALLENGE.md`
- Original background: `langs/csharp-kiss/MartianRobot/README.md`

## DDD Overview

High‑level flow:

```mermaid
flowchart LR
  Input[/STDIN lines/] --> Parser[Application: Parsing]
  Parser --> Mission[Application: Mission Runner]
  Mission --> Nav[Domain: Navigator]
  Nav --> Robot[Domain: Robot]
  Nav --> Grid[Domain: Grid]
  Nav --> Scents[(Domain Port: IScentRepository)]
  Robot -->|state| Mission
  Mission --> Output[STDOUT lines]
```

Layering and dependencies:

```mermaid
flowchart TB
  subgraph Domain
    Entities[Robot, Orientation, Position]
    Grid
    Navigator
    Port[IScentRepository]
  end

  subgraph Application
    Mission[MissionRunner]
    Parsing
    RepoImpl[InMemoryScentRepository]
  end

  subgraph CLI
    Cli[Console Adapter]
  end

  Cli --> Mission
  Mission --> Navigator
  Mission -.-> Parsing
  Mission --> RepoImpl
  RepoImpl -.implements.-> Port
```

Folder mapping (examples):

- C#: `langs/csharp-ddd/src/MartianDDD.{Domain|Application|Cli}`
- Python: `langs/python-ddd/src/martian_ddd/{domain|application|cli}`
- Go: `langs/go-ddd/internal/{domain,app}` and `langs/go-ddd/cmd/martian`
- Rust: `langs/rust-ddd/martian-robot-ddd/src/{domain,application}` with `src/main.rs`
- Node: `langs/node-ddd/src/{domain,app}` with `src/cli.js`
- TS (Deno): `langs/ts-deno-ddd/src/*` (`domain.ts`, `app.ts`, `cli.ts`)
- Java: `langs/java-ddd/src/*` (flat sources for brevity)
- OCaml: `langs/ocaml-ddd/*` modules (`orientation.ml`, `robot.ml`, etc.)
