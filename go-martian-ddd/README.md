## Go (DDD) Martian Robots

Docker:

```
docker build -f go-martian-ddd/Dockerfile -t martian:go-martian-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:go-martian-ddd
```

### Assumptions & Gaps
- Tolerant parsing (trims; filters non-L/R/F). No hard spec limits.
- Minimal error handling; invalid lines may error.
- In-memory scents; no interfaces beyond small repo type.

### Improvements
- Add strict validation and tests; consider context/logging; slimmer image.

