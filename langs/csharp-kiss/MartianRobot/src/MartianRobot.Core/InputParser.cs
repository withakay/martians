using System.Globalization;
using MartianRobot.Core;

namespace MartianRobot.Core;

public sealed record SimulatorParams(Grid Grid, IReadOnlyList<(RobotState start, string instr)> Robots);

public static class InputParser
{
    private const char Separator = ' ';

    public static SimulatorParams Parse(ReadOnlySpan<char> input)
    {
        var lines = ExtractLinesFromInput(input);

        if (lines.Count == 0)
        {
            throw new ArgumentException("Empty input");
        }
        // The first line of input is the upper-right coordinates of the rectangular world,
        // the lower-left coordinates are assumed to be 0, 0.
        var header = lines[0].Split();
        if (header.Length < 2)
        {
            throw new ArgumentException(
                "Invalid input: Line 1 must contain at least 2 numbers separated by a space, got '{0}'",
                lines[0]);
        }

        var max = new Coordinate(header[0].ParseInt(), header[1].ParseInt());
        var grid = new Grid(max);

        // The remaining input consists of a sequence of robot positions and
        // instructions (two lines per robot).
        var pairs = lines.Skip(1).Chunk(2);
        var robots = new List<(RobotState start, string instr)>();

        foreach (var pair in pairs)
        {
            if (pair.Length < 2) break;
            var p = pair[0].Split();
            var pos = new Coordinate(p[0].ParseInt(), p[1].ParseInt());
            var dir = MoveOperation.Parse(p[2]);
            robots.Add((new RobotState(pos, dir), pair[1]));
        }
        return new SimulatorParams(grid, robots);
    }

    internal static List<string> ExtractLinesFromInput(ReadOnlySpan<char> input)
    {
        var lines = input.ToString()
            .Split(['\r', '\n'], StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .ToList();
        return lines;
    }

    internal static int ParseInt(this string input) => int.Parse(input, CultureInfo.InvariantCulture);

}
