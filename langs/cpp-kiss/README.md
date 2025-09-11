## C++ Martian Robots

Docker:

```
docker build -f langs/cpp-kiss/Dockerfile -t martian:cpp-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:cpp-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict spec limits.
- Minimal error handling.

### Improvements
- Add validation and tests.
