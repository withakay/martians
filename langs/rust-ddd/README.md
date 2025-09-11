## Rust (DDD) Martian Robots

Docker:

```
docker build -f langs/rust-ddd/Dockerfile -t martian:rust-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:rust-ddd
```

### Assumptions & Gaps
- Tolerant parsing (trims; filters non-L/R/F). No hard spec limits.
- Errors may panic on malformed lines; no `--strict` mode.
- In-memory scents only.

### Improvements
- Add strict validation and error types; tests (unit/prop/fuzz).

