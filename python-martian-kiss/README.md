## Python Martian Robots

Docker:

```
docker build -f python-martian-kiss/Dockerfile -t martian:python-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:python-martian-kiss
```

Local:

```
python python-martian-kiss/main.py < samples/sample-input.txt
```

### Assumptions & Gaps
- Trims blank lines; filters non-L/R/F from instruction lines.
- No hard checks for grid ≤50 or instruction length ≤100.
- Minimal error handling; invalid lines may raise.
- Outputs a trailing blank line to match goldens.

### Improvements
- Add strict mode with validation and helpful errors.
- Unit + property tests; more fixtures.
