## Ruby Martian Robots

Docker:

```
docker build -f ruby-martian-kiss/Dockerfile -t martian:ruby-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:ruby-martian-kiss
```

Local:

```
ruby ruby-martian-kiss/main.rb < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
