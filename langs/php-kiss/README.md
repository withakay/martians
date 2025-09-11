## PHP Martian Robots

Docker:

```
docker build -f langs/php-kiss/Dockerfile -t martian:php-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:php-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
