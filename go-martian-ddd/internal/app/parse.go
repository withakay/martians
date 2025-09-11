package app

import (
	"bufio"
	"io"
	"strconv"
	"strings"
)

func readNonEmpty(r *bufio.Reader) (string, error) {
	for {
		s, err := r.ReadString('\n')
		if err != nil && err != io.EOF {
			return "", err
		}
		if s == "" && err == io.EOF {
			return "", io.EOF
		}
		s = strings.TrimSpace(s)
		if s != "" {
			return s, nil
		}
	}
}

func parseGrid(line string) (int, int, error) {
	p := strings.Fields(line)
	x, err := strconv.Atoi(p[0])
	if err != nil {
		return 0, 0, err
	}
	y, err := strconv.Atoi(p[1])
	if err != nil {
		return 0, 0, err
	}
	return x, y, nil
}
