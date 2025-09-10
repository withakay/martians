## C++ Martian Robots

Docker:

```
docker build -f cpp-martian-kiss/Dockerfile -t martian:cpp-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:cpp-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
