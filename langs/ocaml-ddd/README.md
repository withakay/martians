## OCaml (DDD) Martian Robots

Docker:

```
docker build -f langs/ocaml-ddd/Dockerfile -t martian:ocaml-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:ocaml-ddd
```

### Assumptions & Gaps
- Tolerant parsing; no explicit spec limits.
- In-memory scents; compiled with `ocamlc` for simplicity.

### Improvements
- Add validation and tests; dune build; slimmer image.
