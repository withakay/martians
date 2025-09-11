## PHP Martian Robots

Docker:

```
docker build -f php-martian-kiss/Dockerfile -t martian:php-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:php-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
