## TypeScript (Bun) Martian Robots

Docker:

```
docker build -f ts-bun-martian-kiss/Dockerfile -t martian:ts-bun-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:ts-bun-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests; ESM packaging.
