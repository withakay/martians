package domain

type ScentRepository interface {
	Has(pos Position, o Orientation) bool
	Add(pos Position, o Orientation)
}
