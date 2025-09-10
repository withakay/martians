## Haskell Martian Robots

Docker:

```
docker build -f haskell-martian-kiss/Dockerfile -t martian:haskell-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:haskell-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
