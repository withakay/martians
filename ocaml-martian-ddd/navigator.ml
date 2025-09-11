open Robot
open Grid
open Scents

let execute (module R: REPO) (g: grid) (r: robot) (instr: string) =
  String.iter (fun c ->
    if not r.lost then match c with
    | 'L' -> turn_left r
    | 'R' -> turn_right r
    | 'F' -> let next = next_forward r in
             if not (contains g next) then (
               if not (R.has r.position r.orientation) then
                 (R.add r.position r.orientation; r.lost <- true)
               else ()
             ) else r.position <- next
    | _ -> ()
  ) instr
