## Rust Martian Robots

Builds the `martian-robot-rs` crate and runs the binary that reads from stdin and prints results.

Docker:

```
docker build -f rust-martian-kiss/Dockerfile -t martian:rust-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:rust-martian-kiss
```

Local (if Rust installed):

```
cd martian-robot-rs && cargo run --quiet --release < ../samples/sample-input.txt
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits; minimal errors.

### Improvements
- Add validation and tests (unit/prop/fuzz).
