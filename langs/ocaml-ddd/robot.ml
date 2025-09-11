open Position
open Orientation

type robot = { mutable position: position; mutable orientation: orientation; mutable lost: bool }

let create p o = { position=p; orientation=o; lost=false }
let turn_left r = r.orientation <- left r.orientation
let turn_right r = r.orientation <- right r.orientation
let next_forward r = let dx,dy = step r.orientation in { x = r.position.x + dx; y = r.position.y + dy }

