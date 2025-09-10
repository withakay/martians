package domain

func Execute(repo ScentRepository, grid Grid, robot *Robot, instr string) {
	for _, c := range instr {
		if robot.Lost {
			break
		}
		switch c {
		case 'L':
			robot.TurnLeft()
		case 'R':
			robot.TurnRight()
		case 'F':
			next := robot.NextForward()
			if !grid.Contains(next) {
				if !repo.Has(robot.Position, robot.Orientation) {
					repo.Add(robot.Position, robot.Orientation)
					robot.Lost = true
				}
			} else {
				robot.Position = next
			}
		}
	}
}
