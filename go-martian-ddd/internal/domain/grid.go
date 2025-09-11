package domain

type Grid struct{ MaxX, MaxY int }

func (g Grid) Contains(p Position) bool {
	return 0 <= p.X && p.X <= g.MaxX && 0 <= p.Y && p.Y <= g.MaxY
}
