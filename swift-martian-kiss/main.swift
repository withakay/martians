import Foundation

let data = String(data: FileHandle.standardInput.readDataToEndOfFile(), encoding: .utf8) ?? ""
if data.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
    FileHandle.standardError.write(Data("No input provided\n".utf8))
    exit(1)
}
let lines = data.split(whereSeparator: { $0 == "\n" || $0 == "\r\n" }).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
if lines.isEmpty {
    FileHandle.standardError.write(Data("Empty input\n".utf8)); exit(1)
}
let head = lines[0].split(separator: " ")
if head.count < 2 { FileHandle.standardError.write(Data("Invalid header\n".utf8)); exit(1) }
let MX = Int(head[head.startIndex])!, MY = Int(head[head.index(after: head.startIndex)])!
let dirs: [Character] = ["N","E","S","W"]
func left(_ d: Character) -> Character { let i = dirs.firstIndex(of: d)!; return dirs[(i+3)%4] }
func right(_ d: Character) -> Character { let i = dirs.firstIndex(of: d)!; return dirs[(i+1)%4] }
func inside(_ x: Int,_ y: Int) -> Bool { return 0 <= x && x <= MX && 0 <= y && y <= MY }
func step(_ d: Character) -> (Int,Int) { switch d { case "N": return (0,1); case "E": return (1,0); case "S": return (0,-1); case "W": return (-1,0); default: return (0,0) } }

var scents = Set<String>()
var out: [String] = []
var i = 1
while i+1 < lines.count {
    let p = lines[i].split(separator: " ")
    var x = Int(p[0])!, y = Int(p[1])!, d = p[2].first!
    let instr = lines[i+1]
    var lost = false
    for c in instr {
        if lost { break }
        if c == "L" { d = left(d) }
        else if c == "R" { d = right(d) }
        else if c == "F" {
            let (dx,dy) = step(d)
            let nx = x+dx, ny = y+dy
            if !inside(nx, ny) {
                let key = "\(x),\(y),\(d)"
                if scents.contains(key) { continue }
                scents.insert(key); lost = true
            } else { x = nx; y = ny }
        }
    }
    out.append("\(x) \(y) \(d)\(lost ? " LOST" : "")")
    i += 2
}
print(out.joined(separator: "\n") + "\n")

