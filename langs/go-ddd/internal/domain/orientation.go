package domain

type Orientation string

const (
	North Orientation = "N"
	East  Orientation = "E"
	South Orientation = "S"
	West  Orientation = "W"
)

func (o Orientation) Left() Orientation {
	switch o {
	case North:
		return West
	case West:
		return South
	case South:
		return East
	case East:
		return North
	}
	return o
}

func (o Orientation) Right() Orientation {
	switch o {
	case North:
		return East
	case East:
		return South
	case South:
		return West
	case West:
		return North
	}
	return o
}

func (o Orientation) Step() (int, int) {
	switch o {
	case North:
		return 0, 1
	case East:
		return 1, 0
	case South:
		return 0, -1
	case West:
		return -1, 0
	}
	return 0, 0
}
