namespace MartianDDD.Domain;

public sealed class Grid
{
    public int MaxX { get; }
    public int MaxY { get; }

    public Grid(int maxX, int maxY)
    {
        if (maxX < 0 || maxY < 0) throw new ArgumentOutOfRangeException("Grid dimensions must be non-negative");
        MaxX = maxX;
        MaxY = maxY;
    }

    public bool Contains(Position p) => p.X >= 0 && p.X <= MaxX && p.Y >= 0 && p.Y <= MaxY;
}
