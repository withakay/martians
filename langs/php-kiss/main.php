<?php
$data = stream_get_contents(STDIN);
if (trim($data) === '') { fwrite(STDERR, "No input provided\n"); exit(1); }
$lines = array_values(array_filter(array_map('trim', preg_split("/[\r\n]+/", $data)), fn($s)=>$s!==''));
if (count($lines)===0) { fwrite(STDERR, "Empty input\n"); exit(1); }
$head = preg_split('/\s+/', $lines[0]);
if (count($head) < 2) { fwrite(STDERR, "Invalid header\n"); exit(1); }
$MX = intval($head[0]); $MY = intval($head[1]);
$dirs = ['N','E','S','W'];
$step = ['N'=>[0,1],'E'=>[1,0],'S'=>[0,-1],'W'=>[-1,0]];
$scents = [];
$out = [];
for ($i=1; $i+1<count($lines); $i+=2) {
  $p = preg_split('/\s+/', $lines[$i]);
  $x = intval($p[0]); $y = intval($p[1]); $d = $p[2];
  $instr = $lines[$i+1];
  $lost = false;
  for ($k=0; $k<strlen($instr) && !$lost; $k++) {
    $c = $instr[$k];
    if ($c==='L') { $d = $dirs[(array_search($d,$dirs)+3)%4]; }
    elseif ($c==='R') { $d = $dirs[(array_search($d,$dirs)+1)%4]; }
    elseif ($c==='F') {
      [$dx,$dy] = $step[$d];
      $nx = $x + $dx; $ny = $y + $dy;
      if (! (0 <= $nx && $nx <= $MX && 0 <= $ny && $ny <= $MY)) {
        $key = "$x,$y,$d";
        if (isset($scents[$key])) { continue; }
        $scents[$key] = true; $lost = true;
      } else { $x=$nx; $y=$ny; }
    }
  }
  $out[] = $x.' '.$y.' '.$d.($lost ? ' LOST' : '');
}
echo implode("\n", $out)."\n\n";
