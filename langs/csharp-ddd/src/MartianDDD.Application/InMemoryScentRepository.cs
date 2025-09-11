using System.Collections.Concurrent;
using MartianDDD.Domain;

namespace MartianDDD.Application;

public sealed class InMemoryScentRepository : IScentRepository
{
    private readonly ConcurrentDictionary<(int x, int y, Orientation o), byte> _set = new();

    public bool HasScent(Position position, Orientation orientation)
        => _set.ContainsKey((position.X, position.Y, orientation));

    public void AddScent(Position position, Orientation orientation)
        => _set.TryAdd((position.X, position.Y, orientation), 0);
}

