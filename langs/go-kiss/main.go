package main

import (
    "bufio"
    "fmt"
    "io"
    "os"
    "strings"
)

type Scent struct{ x, y int; d byte }

func run(data string) (string, error) {
    lines := make([]string, 0)
    for _, ln := range strings.Split(data, "\n") {
        ln = strings.TrimSpace(ln)
        if ln != "" { lines = append(lines, ln) }
    }
    if len(lines) == 0 { return "", fmt.Errorf("Empty input") }
    var maxX, maxY int
    if _, err := fmt.Sscanf(lines[0], "%d %d", &maxX, &maxY); err != nil {
        return "", fmt.Errorf("Invalid header")
    }
    scents := make([]Scent, 0, 64)
    var out []string
    for i := 1; i+1 < len(lines); i += 2 {
        var x, y int; var d byte
        fmt.Sscanf(lines[i], "%d %d %c", &x, &y, &d)
        instr := lines[i+1]
        lost := false
        for j := 0; j < len(instr) && !lost; j++ {
            c := instr[j]
            switch c {
            case 'L':
                d = turnLeft(d)
            case 'R':
                d = turnRight(d)
            case 'F':
                dx, dy := step(d)
                nx, ny := x+dx, y+dy
                if !inside(nx, ny, maxX, maxY) {
                    if hasScent(scents, x, y, d) {
                        continue
                    }
                    scents = append(scents, Scent{x, y, d})
                    lost = true
                } else {
                    x, y = nx, ny
                }
            default:
                // ignore unknown
            }
        }
        if lost { out = append(out, fmt.Sprintf("%d %d %c LOST", x, y, d)) } else { out = append(out, fmt.Sprintf("%d %d %c", x, y, d)) }
    }
    return strings.Join(out, "\n") + "\n\n", nil
}

func turnLeft(d byte) byte {
    switch d { case 'N': return 'W'; case 'W': return 'S'; case 'S': return 'E'; case 'E': return 'N' }
    return d
}
func turnRight(d byte) byte {
    switch d { case 'N': return 'E'; case 'E': return 'S'; case 'S': return 'W'; case 'W': return 'N' }
    return d
}
func step(d byte) (int,int) {
    switch d { case 'N': return 0,1; case 'E': return 1,0; case 'S': return 0,-1; case 'W': return -1,0 }
    return 0,0
}
func inside(x,y,maxX,maxY int) bool { return 0 <= x && x <= maxX && 0 <= y && y <= maxY }
func hasScent(s []Scent, x,y int, d byte) bool {
    for _, sc := range s { if sc.x==x && sc.y==y && sc.d==d { return true } }
    return false
}

func main(){
    b := new(strings.Builder)
    r := bufio.NewReader(os.Stdin)
    for {
        chunk, err := r.ReadString('\n')
        b.WriteString(chunk)
        if err == io.EOF { break }
        if err != nil { fmt.Fprintln(os.Stderr, err.Error()); os.Exit(1) }
    }
    s := b.String()
    if strings.TrimSpace(s) == "" { fmt.Fprintln(os.Stderr, "No input provided"); os.Exit(1) }
    out, err := run(s)
    if err != nil { fmt.Fprintln(os.Stderr, err.Error()); os.Exit(1) }
    fmt.Print(out)
}
