using System.Collections.Immutable;
using MartianRobot.Core;

namespace MartianRobot.Core;

public interface IRobotSimulator
{
    RobotState Run(Grid grid, IEnumerable<(RobotState start, string instr)> robots);
    IEnumerable<RobotState> RunAll(Grid grid, IEnumerable<(RobotState start, string instr)> robots);
}

public sealed class RobotSimulator : IRobotSimulator
{
    // Keep scents across runs (as the original problem states: robots processed sequentially sharing scents)
    private readonly ISet<Scent> _scents = new HashSet<Scent>();

    public IEnumerable<RobotState> RunAll(Grid grid, IEnumerable<(RobotState start, string instr)> robots)
    {
        _scents.Clear();
        foreach (var (start, instr) in robots)
            yield return RunOne(grid, start, instr);
    }

    public RobotState Run(Grid grid, IEnumerable<(RobotState start, string instr)> robots)
        => RunAll(grid, robots).Last();

    private RobotState RunOne(Grid grid, RobotState state, string instr)
    {
        var pos = state.Coordinate;
        var dir = state.Direction;
        var lost = false;

        foreach (var c in instr)
        {
            if (lost) break;
            switch (c)
            {
                case 'L': dir = dir.TurnLeft(); break;
                case 'R': dir = dir.TurnRight(); break;
                case 'F':
                    {
                        var (dx, dy) = dir.Step();
                        var next = new Coordinate(pos.X + dx, pos.Y + dy);
                        if (!next.Inside(grid.Max))
                        {
                            var key = new Scent(pos, dir);
                            if (_scents.Contains(key))
                            {
                                // Ignore this move
                                continue;
                            }
                            _scents.Add(key);
                            lost = true;
                        }
                        else pos = next;
                        break;
                    }
                default:
                    // ignore unknown commands for forward-compatibility
                    break;
            }
        }
        return new RobotState(pos, dir, lost);
    }
}
