using MartianRobot.Core;

namespace MartianRobot.Core;

public readonly record struct Coordinate(int X, int Y)
{
    public bool Inside(Coordinate max) => 0 <= X && X <= max.X && 0 <= Y && Y <= max.Y;
};

public readonly record struct Scent(Coordinate P, Direction D);

public sealed record Grid(Coordinate Max)
{
    public bool IsInside(Coordinate c) => c.Inside(Max);
}

public sealed record RobotState(Coordinate Coordinate, Direction Direction, bool Lost = false)
{
    public override string ToString() => $"{Coordinate.X} {Coordinate.Y} {Direction.AsLetter()}" + (Lost ? " LOST" : string.Empty);
}
