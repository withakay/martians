## Erlang Martian Robots

Docker:

```
docker build -f erlang-martian-kiss/Dockerfile -t martian:erlang-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:erlang-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
