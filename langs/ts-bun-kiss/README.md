## TypeScript (Bun) Martian Robots

Docker:

```
docker build -f langs/ts-bun-kiss/Dockerfile -t martian:ts-bun-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:ts-bun-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests; ESM packaging.
