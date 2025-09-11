namespace MartianDDD.Domain;

public interface IScentRepository
{
    bool HasScent(Position position, Orientation orientation);
    void AddScent(Position position, Orientation orientation);
}
