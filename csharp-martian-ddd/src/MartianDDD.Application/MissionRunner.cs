using MartianDDD.Domain;

namespace MartianDDD.Application;

public sealed class MissionRunner
{
    public void Run(TextReader input, TextWriter output)
    {
        string? line;

        // Read grid line (skip blanks)
        do { line = input.ReadLine(); } while (line is not null && string.IsNullOrWhiteSpace(line));
        if (line is null) return;
        var (maxX, maxY) = Parsing.ParseGrid(line);
        var grid = new Grid(maxX, maxY);

        var scents = new InMemoryScentRepository();

        while (true)
        {
            // Read robot header
            line = ReadNonEmpty(input);
            if (line is null) break;
            var (pos, orient) = Parsing.ParseRobot(line);

            // Read robot instructions
            var instr = ReadNonEmpty(input) ?? string.Empty;
            instr = Parsing.NormalizeInstructions(instr);

            var robot = new Robot(pos, orient);
            var nav = new Navigator(scents);
            nav.Execute(grid, robot, instr);

            output.Write(posToString(robot.Position));
            output.Write(' ');
            output.Write(Parsing.OrientationToString(robot.Orientation));
            if (robot.Lost) output.Write(" LOST");
            output.Write('\n');
        }
        // trailing newline to match goldens
        output.Write('\n');
    }

    private static string? ReadNonEmpty(TextReader r)
    {
        string? line;
        while ((line = r.ReadLine()) is not null)
        {
            if (!string.IsNullOrWhiteSpace(line)) return line.Trim();
        }
        return null;
    }

    private static string posToString(Position p) => $"{p.X} {p.Y}";
}
