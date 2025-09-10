## C# (.NET) Martian Robots

Builds and runs the existing CLI under `MartianRobot/src/MartianRobot.Cli`.

Docker:

```
docker build -f csharp-martian-kiss/Dockerfile -t martian:csharp-martian-kiss .
cat samples/sample-input.txt | docker run --rm -i martian:csharp-martian-kiss
```

Local (if .NET SDK 9.0+ installed):

```
cat samples/sample-input.txt | dotnet run --project MartianRobot/src/MartianRobot.Cli
```

### Assumptions & Gaps
- Wraps the reference CLI; behavior follows that codebase.
- No explicit checks for CHALLENGE.md limits.
- Tolerant to blank lines; expects ASCII L/R/F instructions.

### Improvements
- Add validation switches and more sample fixtures.
