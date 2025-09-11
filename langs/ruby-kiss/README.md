## Ruby Martian Robots

Docker:

```
docker build -f langs/ruby-kiss/Dockerfile -t martian:ruby-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:ruby-kiss
```

Local:

```
ruby langs/ruby-kiss/main.rb < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims/filters instructions; no strict limits.
- Minimal error handling.

### Improvements
- Validation and tests.
