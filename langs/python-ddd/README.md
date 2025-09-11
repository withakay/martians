## Python (DDD) Martian Robots

Layered structure with Domain, Application, and CLI packages. No external deps.

Docker:

```
docker build -f langs/python-ddd/Dockerfile -t martian:python-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:python-ddd
```

### Assumptions & Gaps
- In-memory scents; no persistence or DI container.
- Tolerant parsing (trims; filters non-L/R/F); no hard spec limits enforced.
- Minimal error types; failures may raise exceptions.
- Emits trailing blank line to match goldens.

### Improvements
- Introduce strict validation and richer domain errors.
- Add unit/prop tests per layer; fuzz parser.
