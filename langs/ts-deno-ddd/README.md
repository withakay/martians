## TypeScript Deno (DDD) Martian Robots

Docker:

```
docker build -f ts-deno-martian-ddd/Dockerfile -t martian:ts-deno-martian-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:ts-deno-martian-ddd
```

### Assumptions & Gaps
- Tolerant parsing; no strict spec limits.
- In-memory scents only.

### Improvements
- Add validation switches and tests.
