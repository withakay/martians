## Java Martian Robots

Docker:

```
docker build -f java-martian-kiss/Dockerfile -t martian:java-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:java-martian-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no explicit spec limits.
- Minimal errors; single-file example.

### Improvements
- Add validation and tests; package with Maven/Gradle.
