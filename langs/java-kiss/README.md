## Java Martian Robots

Docker:

```
docker build -f langs/java-kiss/Dockerfile -t martian:java-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:java-kiss
```

### Assumptions & Gaps
- Trims/filters instructions; no explicit spec limits.
- Minimal errors; single-file example.

### Improvements
- Add validation and tests; package with Maven/Gradle.
