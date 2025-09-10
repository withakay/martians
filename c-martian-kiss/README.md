## C Martian Robots

Docker:

```
docker build -f c-martian-kiss/Dockerfile -t martian:c-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:c-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no enforcement of spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
