import scala.io.Source

object Main {
  def main(args: Array[String]): Unit = {
    val data = Source.stdin.getLines().mkString("\n")
    if (data.trim.isEmpty) { Console.err.println("No input provided"); sys.exit(1) }
    val lines = data.split("\r?\n").map(_.trim).filter(_.nonEmpty)
    if (lines.isEmpty) { Console.err.println("Empty input"); sys.exit(1) }
    val head = lines(0).split("\\s+")
    if (head.length < 2) { Console.err.println("Invalid header"); sys.exit(1) }
    val MX = head(0).toInt; val MY = head(1).toInt
    val dirs = Array('N','E','S','W')
    def left(d: Char) = { val i = dirs.indexOf(d); dirs((i+3)%4) }
    def right(d: Char) = { val i = dirs.indexOf(d); dirs((i+1)%4) }
    def step(d: Char) = d match { case 'N'=>(0,1); case 'E'=>(1,0); case 'S'=>(0,-1); case 'W'=>(-1,0); case _=>(0,0) }
    def inside(x:Int,y:Int) = 0<=x && x<=MX && 0<=y && y<=MY
    var scents = Set.empty[(Int,Int,Char)]
    val out = new StringBuilder
    var i = 1
    while (i+1 < lines.length) {
      val p = lines(i).split("\\s+")
      var x = p(0).toInt; var y = p(1).toInt; var d = p(2).charAt(0)
      val instr = lines(i+1)
      var lost = false
      for (c <- instr if !lost) c match {
        case 'L' => d = left(d)
        case 'R' => d = right(d)
        case 'F' => val (dx,dy) = step(d); val nx=x+dx; val ny=y+dy;
                    if (!inside(nx,ny)) { val key=(x,y,d); if (scents(key)) () else { scents += key; lost=true } }
                    else { x=nx; y=ny }
        case _ =>
      }
      out.append(s"$x $y $d${if (lost) " LOST" else ""}\n")
      i += 2
    }
    print(out.result())
    println()
  }
}

