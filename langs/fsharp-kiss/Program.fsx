open System
open System.IO

let data = Console.In.ReadToEnd()
if String.IsNullOrWhiteSpace data then
    Console.Error.WriteLine("No input provided"); exit 1

let lines =
    data.Split([|'\r';'\n'|], StringSplitOptions.RemoveEmptyEntries)
    |> Array.map (fun s -> s.Trim())
    |> Array.filter (fun s -> s<>"")
if lines.Length = 0 then Console.Error.WriteLine("Empty input"); exit 1
let head = lines.[0].Split([|' '|], StringSplitOptions.RemoveEmptyEntries)
if head.Length < 2 then Console.Error.WriteLine("Invalid header"); exit 1
let MX = int head.[0]
let MY = int head.[1]

let dirs = [| 'N'; 'E'; 'S'; 'W' |]
let left d = let i = Array.IndexOf(dirs, d) in dirs.[(i+3)%4]
let right d = let i = Array.IndexOf(dirs, d) in dirs.[(i+1)%4]
let step d = match d with | 'N' -> 0,1 | 'E' -> 1,0 | 'S' -> 0,-1 | 'W' -> -1,0 | _ -> 0,0
let inside x y = 0<=x && x<=MX && 0<=y && y<=MY

let mutable scents = Set.empty<(int*int*char)>
let out = System.Text.StringBuilder()
let mutable i = 1
while i+1 < lines.Length do
    let p = lines.[i].Split([|' '|], StringSplitOptions.RemoveEmptyEntries)
    let mutable x = int p.[0]
    let mutable y = int p.[1]
    let mutable d = p.[2].[0]
    let instr = lines.[i+1]
    let mutable lost = false
    for c in instr do
        if not lost then
            match c with
            | 'L' -> d <- left d
            | 'R' -> d <- right d
            | 'F' ->
                let dx,dy = step d
                let nx,ny = x+dx, y+dy
                if not (inside nx ny) then
                    if scents.Contains(x,y,d) then ()
                    else scents <- scents.Add(x,y,d); lost <- true
                else x <- nx; y <- ny
            | _ -> ()
    out.Append(sprintf "%d %d %c%s\n" x y d (if lost then " LOST" else "")) |> ignore
    i <- i + 2
Console.Out.Write(out.ToString())
Console.Out.WriteLine()
