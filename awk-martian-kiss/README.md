## Awk Martian Robots

Docker:

```
docker build -f awk-martian-kiss/Dockerfile -t martian:awk-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:awk-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
