## Go Martian Robots

Docker:

```
docker build -f langs/go-kiss/Dockerfile -t martian:go-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:go-kiss
```

Local:

```
go run langs/go-kiss/main.go < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error messages; single file.

### Improvements
- Validation and tests; multi-sample harness.
