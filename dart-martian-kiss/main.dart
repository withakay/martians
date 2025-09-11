import 'dart:convert';
import 'dart:io';

void main() async {
  final data = await utf8.decoder.bind(stdin).join();
  if (data.trim().isEmpty) {
    stderr.writeln('No input provided');
    exit(1);
  }
  final lines = data
      .split(RegExp(r'[\r\n]+'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
  if (lines.isEmpty) {
    stderr.writeln('Empty input');
    exit(1);
  }
  final head = lines[0].split(RegExp(r'\s+'));
  if (head.length < 2) {
    stderr.writeln('Invalid header');
    exit(1);
  }
  final MX = int.parse(head[0]);
  final MY = int.parse(head[1]);
  const dirs = ['N', 'E', 'S', 'W'];
  final step = {
    'N': [0, 1],
    'E': [1, 0],
    'S': [0, -1],
    'W': [-1, 0],
  };
  final scents = <String>{};
  final out = StringBuffer();
  for (var i = 1; i + 1 < lines.length; i += 2) {
    final p = lines[i].split(RegExp(r'\s+'));
    var x = int.parse(p[0]);
    var y = int.parse(p[1]);
    var d = p[2];
    final instr = lines[i + 1];
    var lost = false;
    for (final c in instr.split('')) {
      if (lost) break;
      if (c == 'L') {
        d = dirs[(dirs.indexOf(d) - 1) % 4];
      } else if (c == 'R') {
        d = dirs[(dirs.indexOf(d) + 1) % 4];
      } else if (c == 'F') {
        final dx = step[d]![0];
        final dy = step[d]![1];
        final nx = x + dx, ny = y + dy;
        if (!(0 <= nx && nx <= MX && 0 <= ny && ny <= MY)) {
          final key = '$x,$y,$d';
          if (scents.contains(key)) continue;
          scents.add(key);
          lost = true;
        } else {
          x = nx;
          y = ny;
        }
      }
    }
    out.writeln('$x $y $d${lost ? ' LOST' : ''}');
  }
  stdout.write(out.toString());
  stdout.writeln();
}
