final class Grid { final int maxX, maxY; Grid(int maxX,int maxY){ this.maxX=maxX; this.maxY=maxY; }
  boolean contains(Position p){ return 0<=p.x && p.x<=maxX && 0<=p.y && p.y<=maxY; }
}

