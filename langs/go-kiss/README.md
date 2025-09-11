## Go Martian Robots

Docker:

```
docker build -f go-martian-kiss/Dockerfile -t martian:go-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:go-martian-kiss
```

Local:

```
go run go-martian-kiss/main.go < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error messages; single file.

### Improvements
- Validation and tests; multi-sample harness.
