## Rust Martian Robots

Builds the `martian-robot-rs` crate and runs the binary that reads from stdin and prints results.

Docker:

```
docker build -f langs/rust-kiss/Dockerfile -t martian:rust-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:rust-kiss
```

Local (if Rust installed):

```
cd langs/rust-kiss/martian-robot-rs && cargo run --quiet --release < ../../samples/sample-input.txt
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits; minimal errors.

### Improvements
- Add validation and tests (unit/prop/fuzz).
