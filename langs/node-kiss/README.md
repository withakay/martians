## Node.js Martian Robots

Docker:

```
docker build -f langs/node-kiss/Dockerfile -t martian:node-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:node-kiss
```

Local:

```
node langs/node-kiss/main.js < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims blank lines; filters non-L/R/F.
- No explicit spec limits; minimal error messages.

### Improvements
- Add strict mode and tests.
