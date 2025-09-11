## Haskell Martian Robots

Docker:

```
docker build -f langs/haskell-kiss/Dockerfile -t martian:haskell-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:haskell-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
