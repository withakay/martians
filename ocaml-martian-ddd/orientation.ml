type orientation = N | E | S | W

let left = function N->W | W->S | S->E | E->N
let right = function N->E | E->S | S->W | W->N
let step = function N->(0,1) | E->(1,0) | S->(0,-1) | W->(-1,0)

let of_string = function "N"->N | "E"->E | "S"->S | "W"->W | _->failwith "bad orient"
let to_string = function N->"N" | E->"E" | S->"S" | W->"W"

