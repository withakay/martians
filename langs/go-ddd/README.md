## Go (DDD) Martian Robots

Docker:

```
docker build -f langs/go-ddd/Dockerfile -t martian:go-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:go-ddd
```

### Assumptions & Gaps
- Tolerant parsing (trims; filters non-L/R/F). No hard spec limits.
- Minimal error handling; invalid lines may error.
- In-memory scents; no interfaces beyond small repo type.

### Improvements
- Add strict validation and tests; consider context/logging; slimmer image.

