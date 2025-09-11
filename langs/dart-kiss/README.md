## Dart Martian Robots

Docker:

```
docker build -f dart-martian-kiss/Dockerfile -t martian:dart-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:dart-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
