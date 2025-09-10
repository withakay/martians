package domain

type Robot struct {
	Position    Position
	Orientation Orientation
	Lost        bool
}

func (r *Robot) TurnLeft()  { r.Orientation = r.Orientation.Left() }
func (r *Robot) TurnRight() { r.Orientation = r.Orientation.Right() }

func (r *Robot) NextForward() Position {
	dx, dy := r.Orientation.Step()
	return Position{X: r.Position.X + dx, Y: r.Position.Y + dy}
}
