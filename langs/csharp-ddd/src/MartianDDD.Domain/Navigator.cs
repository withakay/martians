namespace MartianDDD.Domain;

public sealed class Navigator
{
    private readonly IScentRepository _scents;

    public Navigator(IScentRepository scents)
    {
        _scents = scents;
    }

    public void Execute(Grid grid, Robot robot, string instructions)
    {
        foreach (var ch in instructions)
        {
            if (robot.Lost) break;
            switch (ch)
            {
                case 'L': robot.TurnLeft(); break;
                case 'R': robot.TurnRight(); break;
                case 'F':
                    var next = robot.NextForward();
                    if (!grid.Contains(next))
                    {
                        // Check scent at current position+orientation. If present, ignore the move.
                        if (!_scents.HasScent(robot.Position, robot.Orientation))
                        {
                            _scents.AddScent(robot.Position, robot.Orientation);
                            robot.MarkLost();
                        }
                    }
                    else
                    {
                        robot.MoveTo(next);
                    }
                    break;
            }
        }
    }
}
