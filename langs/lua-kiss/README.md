## Lua Martian Robots

Docker:

```
docker build -f langs/lua-kiss/Dockerfile -t martian:lua-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:lua-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
