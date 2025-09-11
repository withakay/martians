data = read(stdin, String)
if isempty(strip(data))
    println(stderr, "No input provided"); exit(1)
end
lines = filter(!isempty, strip.(split(data, r"[\r\n]+")))
if isempty(lines)
    println(stderr, "Empty input"); exit(1)
end
head = split(lines[1])
if length(head) < 2
    println(stderr, "Invalid header"); exit(1)
end
MX = parse(Int, head[1]); MY = parse(Int, head[2])
dirs = ['N','E','S','W']
step = Dict('N'=>(0,1),'E'=>(1,0),'S'=>(0,-1),'W'=>(-1,0))
scents = Set{Tuple{Int,Int,Char}}()
out = IOBuffer()
global i = 2
while i <= length(lines)-1
    p = split(lines[i])
    x = parse(Int, p[1]); y = parse(Int, p[2]); d = p[3][1]
    instr = lines[i+1]
    lost = false
    for c in instr
        if lost; break; end
        if c=='L'
            idx = findfirst(==(d), dirs)
            d = dirs[mod(idx-2,4)+1]
        elseif c=='R'
            idx = findfirst(==(d), dirs)
            d = dirs[mod(idx,4)+1]
        elseif c=='F'
            (dx,dy) = step[d]
            nx = x+dx; ny = y+dy
            if !(0<=nx<=MX && 0<=ny<=MY)
                key = (x,y,d)
                if key in scents
                    continue
                else
                    push!(scents, key); lost = true
                end
            else
                x = nx; y = ny
            end
        end
    end
    println(out, string(x, " ", y, " ", d, lost ? " LOST" : ""))
    global i += 2
end
print(String(take!(out)))
println()
