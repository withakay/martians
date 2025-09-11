using System.Globalization;
using MartianDDD.Domain;

namespace MartianDDD.Application;

public static class Parsing
{
    public static (int maxX, int maxY) ParseGrid(string line)
    {
        var parts = SplitInts(line);
        if (parts.Length != 2) throw new FormatException("Grid line must have two integers");
        return (parts[0], parts[1]);
    }

    public static (Position pos, Orientation orientation) ParseRobot(string line)
    {
        var tokens = line.Split(new[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
        if (tokens.Length != 3) throw new FormatException("Robot line must be: X Y O");
        var x = int.Parse(tokens[0], CultureInfo.InvariantCulture);
        var y = int.Parse(tokens[1], CultureInfo.InvariantCulture);
        var o = ParseOrientation(tokens[2]);
        return (new Position(x, y), o);
    }

    public static string NormalizeInstructions(string line)
        => new string(line.Trim().Where(c => c is 'L' or 'R' or 'F').ToArray());

    public static Orientation ParseOrientation(string token) => token switch
    {
        "N" => Orientation.N,
        "E" => Orientation.E,
        "S" => Orientation.S,
        "W" => Orientation.W,
        _ => throw new FormatException("Invalid orientation")
    };

    public static string OrientationToString(Orientation o) => o switch
    {
        Orientation.N => "N",
        Orientation.E => "E",
        Orientation.S => "S",
        Orientation.W => "W",
        _ => "?"
    };

    private static int[] SplitInts(string line)
        => line.Split(new[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries)
               .Select(s => int.Parse(s, CultureInfo.InvariantCulture))
               .ToArray();
}

