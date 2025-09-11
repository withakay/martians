## Scala Martian Robots

Docker:

```
docker build -f langs/scala-kiss/Dockerfile -t martian:scala-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:scala-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
