package app

import (
	"bufio"
	"fmt"
	"io"
	"martian-robot-ddd/internal/domain"
	"strconv"
	"strings"
)

func Run(r *bufio.Reader, w io.Writer) error {
	header, err := readNonEmpty(r)
	if err == io.EOF {
		return nil
	}
	if err != nil {
		return err
	}
	mx, my, err := parseGrid(header)
	if err != nil {
		return err
	}
	grid := domain.Grid{MaxX: mx, MaxY: my}
	scents := NewInMemoryScents()

	for {
		meta, err := readNonEmpty(r)
		if err == io.EOF {
			break
		}
		if err != nil {
			return err
		}
		parts := strings.Fields(meta)
		x := atoi(parts[0])
		y := atoi(parts[1])
		o := domain.Orientation(parts[2])

		instr, err := readNonEmpty(r)
		if err != nil && err != io.EOF {
			return err
		}
		instr = filterInstr(instr)

		robot := &domain.Robot{Position: domain.Position{X: x, Y: y}, Orientation: o}
		domain.Execute(scents, grid, robot, instr)

		if robot.Lost {
			fmt.Fprintf(w, "%d %d %s LOST\n", robot.Position.X, robot.Position.Y, robot.Orientation)
		} else {
			fmt.Fprintf(w, "%d %d %s\n", robot.Position.X, robot.Position.Y, robot.Orientation)
		}
		if err == io.EOF {
			break
		}
	}
	// trailing newline to match goldens
	fmt.Fprintln(w)
	return nil
}

func atoi(s string) int { n, _ := strconv.Atoi(s); return n }

func filterInstr(s string) string {
	var b strings.Builder
	for _, c := range s {
		if c == 'L' || c == 'R' || c == 'F' {
			b.WriteRune(c)
		}
	}
	return b.String()
}
