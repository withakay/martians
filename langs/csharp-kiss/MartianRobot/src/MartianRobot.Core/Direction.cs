namespace MartianRobot.Core;

public enum Direction { N, E, S, W }

public static class MoveOperation
{
    public static Direction TurnLeft(this Direction d) => d switch
    {
        Direction.N => Direction.W,
        Direction.W => Direction.S,
        Direction.S => Direction.E,
        Direction.E => Direction.N,
        _ => d,
    };

    public static Direction TurnRight(this Direction d) => d switch
    {
        Direction.N => Direction.E,
        Direction.E => Direction.S,
        Direction.S => Direction.W,
        Direction.W => Direction.N,
        _ => d,
    };

    public static (int dx, int dy) Step(this Direction d) => d switch
    {
        Direction.N => (0, 1),
        Direction.E => (1, 0),
        Direction.S => (0, -1),
        Direction.W => (-1, 0),
        _ => (0, 0),
    };

    public static string AsLetter(this Direction d) => d switch
    {
        Direction.N => "N",
        Direction.E => "E",
        Direction.S => "S",
        Direction.W => "W",
        _ => "?",
    };

    public static Direction Parse(string s) => s switch
    {
        "N" => Direction.N,
        "E" => Direction.E,
        "S" => Direction.S,
        "W" => Direction.W,
        _ => throw new ArgumentException($"Invalid direction: {s}"),
    };
}
