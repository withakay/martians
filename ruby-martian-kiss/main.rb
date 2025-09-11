#!/usr/bin/env ruby
data = STDIN.read
if data.strip.empty?
  STDERR.puts 'No input provided'
  exit 1
end
lines = data.each_line.map{|s| s.strip}.reject{|s| s.empty?}
raise 'Empty input' if lines.empty?
head = lines[0].split
raise 'Invalid header' if head.length < 2
mx = head[0].to_i; my = head[1].to_i
dirs = ['N','E','S','W']
step = {'N'=>[0,1],'E'=>[1,0],'S'=>[0,-1],'W'=>[-1,0]}
scents = {}
out = []
i = 1
while i+1 < lines.length
  p = lines[i].split; i += 1
  instr = lines[i]; i += 1
  x = p[0].to_i; y = p[1].to_i; d = p[2]
  lost = false
  instr.each_char do |c|
    break if lost
    case c
    when 'L'
      d = dirs[(dirs.index(d)-1) % 4]
    when 'R'
      d = dirs[(dirs.index(d)+1) % 4]
    when 'F'
      dx,dy = step[d]
      nx = x+dx; ny = y+dy
      if nx < 0 || nx > mx || ny < 0 || ny > my
        key = [x,y,d]
        if scents[key]
          next
        else
          scents[key] = true
          lost = true
        end
      else
        x = nx; y = ny
      end
    else
      # ignore unknown
    end
  end
  out << sprintf("%d %d %s%s", x,y,d, lost ? ' LOST' : '')
end
puts out.join("\n")
puts

