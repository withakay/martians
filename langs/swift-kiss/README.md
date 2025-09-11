## Swift Martian Robots

Docker:

```
docker build -f swift-martian-kiss/Dockerfile -t martian:swift-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:swift-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
