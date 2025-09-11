## Erlang Martian Robots

Docker:

```
docker build -f langs/erlang-kiss/Dockerfile -t martian:erlang-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:erlang-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
