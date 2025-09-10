## TypeScript (Deno) Martian Robots

Docker:

```
docker build -f ts-deno-martian-kiss/Dockerfile -t martian:ts-deno-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:ts-deno-martian-kiss
```

### Assumptions & Gaps
- Tolerant parsing; no length/limit enforcement.
- Minimal error output.

### Improvements
- Add strict mode and tests; type-safe parsing.
