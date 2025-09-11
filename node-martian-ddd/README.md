## Node.js (DDD) Martian Robots

Docker:

```
docker build -f node-martian-ddd/Dockerfile -t martian:node-martian-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:node-martian-ddd
```

### Assumptions & Gaps
- Tolerant parsing; no strict spec enforcement.
- In-memory scents; no DI or logging.

### Improvements
- Add validation and tests (unit/prop); publish as lib/CLI.
