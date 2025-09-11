using System;
using System.IO;
using System.Linq;
using MartianRobot.Core;      // Models + InputParser
using MartianRobot.Core;     // Direction + RobotSimulator

// Read all of stdin; if empty, print a tiny usage hint and exit non‑zero.
string input = Console.In.ReadToEnd();
if (string.IsNullOrWhiteSpace(input))
{
    Console.Error.WriteLine("No input provided. Example usage:\n  cat samples/sample-input.txt | dotnet run --project src/MartianRobot.Cli");
    return 1;
}

try
{
    var (grid, robots) = InputParser.Parse(input);
    var sim = new RobotSimulator();
    foreach (var state in sim.RunAll(grid, robots))
    {
        Console.WriteLine(state.ToString());
    }
    Console.WriteLine();
    return 0;
}
catch (Exception ex)
{
    Console.Error.WriteLine(ex.Message);
    return 1;
}
