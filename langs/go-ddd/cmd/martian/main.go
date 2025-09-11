package main

import (
	"bufio"
	"martian-robot-ddd/internal/app"
	"os"
)

func main() {
	r := bufio.NewReader(os.Stdin)
	if err := app.Run(r, os.Stdout); err != nil {
		os.Stderr.WriteString(err.Error() + "\n")
		os.Exit(1)
	}
}
