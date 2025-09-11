## Julia Martian Robots

Docker:

```
docker build -f julia-martian-kiss/Dockerfile -t martian:julia-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:julia-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
