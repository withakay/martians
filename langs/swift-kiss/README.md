## Swift Martian Robots

Docker:

```
docker build -f langs/swift-kiss/Dockerfile -t martian:swift-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:swift-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
