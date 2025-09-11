## Scala Martian Robots

Docker:

```
docker build -f scala-martian-kiss/Dockerfile -t martian:scala-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:scala-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
