## F# Martian Robots

Docker:

```
docker build -f fsharp-martian-kiss/Dockerfile -t martian:fsharp-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:fsharp-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
