## Java (DDD) Martian Robots

Docker:

```
docker build -f langs/java-ddd/Dockerfile -t martian:java-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:java-ddd
```

### Assumptions & Gaps
- Flat sources for brevity; tolerant parsing; no hard spec limits.
- In-memory scents; basic errors.

### Improvements
- Add validation, tests, and packaging.
