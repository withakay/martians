package app

import "martian-robot-ddd/internal/domain"

type InMemoryScents struct{ set map[[3]int]domain.Orientation }

func NewInMemoryScents() *InMemoryScents {
	return &InMemoryScents{set: make(map[[3]int]domain.Orientation)}
}

func (s *InMemoryScents) Has(pos domain.Position, o domain.Orientation) bool {
	_, ok := s.set[[3]int{pos.X, pos.Y, int(o[0])}]
	return ok
}

func (s *InMemoryScents) Add(pos domain.Position, o domain.Orientation) {
	s.set[[3]int{pos.X, pos.Y, int(o[0])}] = o
}
