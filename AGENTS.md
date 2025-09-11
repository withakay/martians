# Agents Guide

Concise guidance for contributors and AI agents working in this repo.

## Repo Layout
- `langs/`: all implementations. Suffix `-kiss` (minimal) or `-ddd` (DDD layered).
- `samples/`: `*-input.txt` fixtures. Add more freely.
- `goldens/`: matching `*-output.txt` expected results.
- `tools/harness.sh`: builds each impl, runs all fixtures, compares output, summarizes.
- `.github/workflows/ci.yml`: builds/tests on every push and on manual dispatch.

## Workflow
- Branch name: `type/scope-brief` (e.g., `feat/python-strict`, `chore/reorg-langs-issue-2`).
- Commits: small, descriptive, and scoped. Prefer one language per commit when touching many.
- PRs: use a real body file (avoid `\n` literals). Example:
  ```bash
  cat > /tmp/body.md <<'EOF'
  - Change summary
  - Rationale
  - Testing notes

  Fixes #123.
  EOF
  gh pr create -B main -H my-branch --title "title" --body-file /tmp/body.md
  ```

## Harness (tests)
- Run all: `./tools/harness.sh` (or `make test-all`).
- Target subset: `LANGS="langs/python-ddd langs/rust-kiss" ./tools/harness.sh`.
- Behavior: discovers `langs/*`, runs all `samples/*-input.txt` against `goldens/*-output.txt`.
- Normalization: trims trailing blank lines; enforces a single trailing newline before diff.
- Cross-implementation diff: reports mismatches between language outputs for the same fixture.

## Adding Fixtures
- Add `samples/<name>-input.txt` and `goldens/<name>-output.txt`.
- Keep output lines ending with a single final blank line (the harness normalizes, but goldens should reflect intent).

## Adding/Modifying Implementations
- Location: under `langs/<tech>-kiss` or `langs/<tech>-ddd`.
- Dockerfile: copy sources from `langs/<impl>/...` and emit a single CLI that reads stdin, writes stdout.
- Image tag: harness tags images as `martian:<basename>` (e.g., `martian:python-ddd`).
- Tolerance: implementations typically ignore non-`L/R/F` in instruction lines; note deviations in README.

## DDD Conventions
- Domain: entities/value objects, `Navigator`, scent repository interface.
- Application: parsing + mission runner; in-memory scent store.
- CLI: thin stdin/stdout adapter.

## CI Notes
- GitHub Actions posts a step summary with per-impl status and cross-diff counts.
- Use groups in logs (already enabled) to keep builds readable.

## Gotchas
- Don’t add nested git repos under `langs/*` (vendor contents instead).
- When reorganizing paths, update: Dockerfiles, harness, Makefile, READMEs.
- Avoid embedding literal `\n` in PR descriptions—use `--body-file`.

## Handy Commands
- List implementations: `make list`
- Build all: `make build-all`
- Test one: `make test-langs/python-ddd`
- Run one: `make run-langs/python-ddd`

