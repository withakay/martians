## Node.js Martian Robots

Docker:

```
docker build -f node-martian-kiss/Dockerfile -t martian:node-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:node-martian-kiss
```

Local:

```
node node-martian-kiss/main.js < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims blank lines; filters non-L/R/F.
- No explicit spec limits; minimal error messages.

### Improvements
- Add strict mode and tests.
