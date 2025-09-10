open Position

type grid = { max_x:int; max_y:int }

let contains g p = 0 <= p.x && p.x <= g.max_x && 0 <= p.y && p.y <= g.max_y

