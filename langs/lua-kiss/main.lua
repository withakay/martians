local data = io.read("*a") or ""
if data:match("%S") == nil then
    io.stderr:write("No input provided\n"); os.exit(1)
end

local lines = {}
for ln in data:gmatch("[^\r\n]+") do
    ln = ln:gsub("^%s+", ""):gsub("%s+$", "")
    if ln ~= "" then table.insert(lines, ln) end
end
if #lines == 0 then
    io.stderr:write("Empty input\n"); os.exit(1)
end

local head = {}
for t in lines[1]:gmatch("%S+") do table.insert(head, t) end
if #head < 2 then
    io.stderr:write("Invalid header\n"); os.exit(1)
end
local MX = tonumber(head[1])
local MY = tonumber(head[2])

local dirs = { 'N', 'E', 'S', 'W' }
local step = { N = { 0, 1 }, E = { 1, 0 }, S = { 0, -1 }, W = { -1, 0 } }
local function left(d)
    for i = 1, 4 do if dirs[i] == d then return dirs[(i + 2) % 4 + 1] end end
end
local function right(d)
    for i = 1, 4 do if dirs[i] == d then return dirs[i % 4 + 1] end end
end

local scents = {}
local out = {}
local i = 2
while i <= #lines - 1 do
    local p = {}
    for t in lines[i]:gmatch("%S+") do table.insert(p, t) end
    local x = tonumber(p[1]); local y = tonumber(p[2]); local d = p[3]
    local instr = lines[i + 1]
    local lost = false
    for c in instr:gmatch(".") do
        if lost then break end
        if c == 'L' then
            d = left(d)
        elseif c == 'R' then
            d = right(d)
        elseif c == 'F' then
            local dx, dy = table.unpack(step[d])
            local nx, ny = x + dx, y + dy
            if not (0 <= nx and nx <= MX and 0 <= ny and ny <= MY) then
                local key = string.format("%d,%d,%s", x, y, d)
                if not scents[key] then
                    scents[key] = true; lost = true
                end
            else
                x, y = nx, ny
            end
        end
    end
    table.insert(out, string.format("%d %d %s%s", x, y, d, lost and " LOST" or ""))
    i = i + 2
end
print(table.concat(out, "\n") .. "\n")
