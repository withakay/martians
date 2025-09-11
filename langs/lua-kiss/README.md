## Lua Martian Robots

Docker:

```
docker build -f lua-martian-kiss/Dockerfile -t martian:lua-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:lua-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
