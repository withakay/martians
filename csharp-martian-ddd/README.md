## C# (DDD) Martian Robots

This implementation demonstrates a simple Domain-Driven Design (DDD) layering:

- Domain: Entities, Value Objects, Domain Services, `IScentRepository`.
- Application: `MissionRunner` orchestration and parsing. In-memory `ScentRepository`.
- CLI: Wires everything and reads/writes STDIN/STDOUT.

Docker:

```
docker build -f csharp-martian-ddd/Dockerfile -t martian:csharp-martian-ddd .
cat samples/sample-input.txt | docker run --rm -i martian:csharp-martian-ddd
```

### Assumptions & Gaps
- In-memory `IScentRepository`; no DI container or persistence.
- Parser is tolerant (trims; filters non-L/R/F). No hard spec limits.
- Minimal error handling; exceptions on malformed lines.

### Improvements
- Add validation, domain errors, and unit/prop tests per layer.
- Wire DI and alternative scent stores.
