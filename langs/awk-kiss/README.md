## Awk Martian Robots

Docker:

```
docker build -f langs/awk-kiss/Dockerfile -t martian:awk-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:awk-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
