data = IO.read(:stdio, :all) || ""
if String.trim(data) == "" do
  IO.puts(:stderr, "No input provided"); System.halt(1)
end
lines = data |> String.split(["\n","\r"], trim: true) |> Enum.map(&String.trim/1) |> Enum.filter(&(&1!=""))
if Enum.empty?(lines) do IO.puts(:stderr, "Empty input"); System.halt(1) end
[mxs, mys | _] = String.split(Enum.at(lines,0))
mx = String.to_integer(mxs); my = String.to_integer(mys)
dirs = [?N,?E,?S,?W]
left = fn d -> Enum.at(dirs, rem(Enum.find_index(dirs, &(&1==d))+3,4)) end
right = fn d -> Enum.at(dirs, rem(Enum.find_index(dirs, &(&1==d))+1,4)) end
step = fn
  ?N -> {0,1}
  ?E -> {1,0}
  ?S -> {0,-1}
  ?W -> {-1,0}
  _ -> {0,0}
end
inside = fn x,y -> 0<=x and x<=mx and 0<=y and y<=my end
scents = MapSet.new()

{_, out} =
  1..(div(length(lines)-1,2))
  |> Enum.reduce({scents, []}, fn idx, {sc,out} ->
    p = Enum.at(lines, idx*2-1) |> String.split()
    {x0,y0,d0} = {String.to_integer(Enum.at(p,0)), String.to_integer(Enum.at(p,1)), hd(String.to_charlist(Enum.at(p,2)))}
    instr = Enum.at(lines, idx*2)
    {x,y,d,lost,sc2} =
      instr
      |> String.to_charlist()
      |> Enum.reduce({x0,y0,d0,false,sc}, fn c,{x,y,d,lost,sc} ->
        cond do
          lost -> {x,y,d,true,sc}
          c==?L -> {x,y,left.(d),false,sc}
          c==?R -> {x,y,right.(d),false,sc}
          c==?F ->
            {dx,dy} = step.(d); nx=x+dx; ny=y+dy
            if not inside.(nx,ny) do
              key = {x,y,d}
              if MapSet.member?(sc,key), do: {x,y,d,false,sc}, else: {x,y,d,true,MapSet.put(sc,key)}
            else
              {nx,ny,d,false,sc}
            end
          true -> {x,y,d,false,sc}
        end
      end)
    {sc2, [Enum.join([Integer.to_string(x), Integer.to_string(y), <<d>> <> (if lost, do: " LOST", else: "")], " ") | out]}
  end)

out |> Enum.reverse() |> Enum.each(&IO.puts/1)
IO.puts("")
