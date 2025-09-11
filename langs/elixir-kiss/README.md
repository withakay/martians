## Elixir Martian Robots

Docker:

```
docker build -f elixir-martian-kiss/Dockerfile -t martian:elixir-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:elixir-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
