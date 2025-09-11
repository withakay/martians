## Julia Martian Robots

Docker:

```
docker build -f langs/julia-kiss/Dockerfile -t martian:julia-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:julia-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
