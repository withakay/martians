## Elixir Martian Robots

Docker:

```
docker build -f langs/elixir-kiss/Dockerfile -t martian:elixir-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:elixir-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
