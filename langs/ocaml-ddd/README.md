## OCaml (DDD) Martian Robots

Docker:

```
docker build -f ocaml-martian-ddd/Dockerfile -t martian:ocaml-martian-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:ocaml-martian-ddd
```

### Assumptions & Gaps
- Tolerant parsing; no explicit spec limits.
- In-memory scents; compiled with `ocamlc` for simplicity.

### Improvements
- Add validation and tests; dune build; slimmer image.
