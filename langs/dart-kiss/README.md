## Dart Martian Robots

Docker:

```
docker build -f langs/dart-kiss/Dockerfile -t martian:dart-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:dart-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
