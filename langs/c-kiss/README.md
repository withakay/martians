## C Martian Robots

Docker:

```
docker build -f langs/c-kiss/Dockerfile -t martian:c-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:c-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no enforcement of spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
