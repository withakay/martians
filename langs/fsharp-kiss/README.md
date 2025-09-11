## F# Martian Robots

Docker:

```
docker build -f langs/fsharp-kiss/Dockerfile -t martian:fsharp-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:fsharp-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
