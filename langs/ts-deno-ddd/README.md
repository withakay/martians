## TypeScript Deno (DDD) Martian Robots

Docker:

```
docker build -f langs/ts-deno-ddd/Dockerfile -t martian:ts-deno-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:ts-deno-ddd
```

### Assumptions & Gaps
- Tolerant parsing; no strict spec limits.
- In-memory scents only.

### Improvements
- Add validation switches and tests.
