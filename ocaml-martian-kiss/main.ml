open Printf

type direction = N | E | S | W
type position = { x: int; y: int; d: direction }
type scent = int * int * direction

let dir_to_char = function N -> 'N' | E -> 'E' | S -> 'S' | W -> 'W'
let char_to_dir = function 'N' -> N | 'E' -> E | 'S' -> S | 'W' -> W | _ -> N

let turn_left = function N -> W | W -> S | S -> E | E -> N
let turn_right = function N -> E | E -> S | S -> W | W -> N

let step = function
  | N -> (0, 1)
  | E -> (1, 0)
  | S -> (0, -1)
  | W -> (-1, 0)

let inside x y mx my = x >= 0 && x <= mx && y >= 0 && y <= my

let rec process_instruction pos mx my scents lost = function
  | [] -> (pos, scents, lost)
  | c::rest ->
    if lost then (pos, scents, lost)
    else
      match c with
      | 'L' -> process_instruction {pos with d = turn_left pos.d} mx my scents lost rest
      | 'R' -> process_instruction {pos with d = turn_right pos.d} mx my scents lost rest
      | 'F' ->
        let dx, dy = step pos.d in
        let nx, ny = pos.x + dx, pos.y + dy in
        if not (inside nx ny mx my) then
          if List.mem (pos.x, pos.y, pos.d) scents then
            process_instruction pos mx my scents lost rest
          else
            process_instruction pos mx my ((pos.x, pos.y, pos.d)::scents) true rest
        else
          process_instruction {x = nx; y = ny; d = pos.d} mx my scents lost rest
      | _ -> process_instruction pos mx my scents lost rest

let rec read_lines acc =
  try
    let line = input_line stdin in
    read_lines (line :: acc)
  with End_of_file -> List.rev acc

let trim s =
  let len = String.length s in
  let rec find_start i =
    if i >= len then len
    else if s.[i] = ' ' || s.[i] = '\t' || s.[i] = '\r' || s.[i] = '\n' then find_start (i + 1)
    else i in
  let rec find_end i =
    if i < 0 then -1
    else if s.[i] = ' ' || s.[i] = '\t' || s.[i] = '\r' || s.[i] = '\n' then find_end (i - 1)
    else i in
  let start = find_start 0 in
  let stop = find_end (len - 1) in
  if start > stop then "" else String.sub s start (stop - start + 1)

let () =
  let lines = read_lines [] |> List.map trim |> List.filter (fun s -> s <> "") in
  match lines with
  | [] -> eprintf "Empty input\n"; exit 1
  | header::rest ->
    let parts = String.split_on_char ' ' header in
    let mx = int_of_string (List.nth parts 0) in
    let my = int_of_string (List.nth parts 1) in
    let rec process_robots robots scents =
      match robots with
      | [] -> ()
      | pos_str::instr_str::rest ->
        let pos_parts = String.split_on_char ' ' pos_str in
        let x = int_of_string (List.nth pos_parts 0) in
        let y = int_of_string (List.nth pos_parts 1) in
        let d = char_to_dir (String.get (List.nth pos_parts 2) 0) in
        let pos = {x; y; d} in
        let instructions = List.init (String.length instr_str) (String.get instr_str) in
        let final_pos, new_scents, lost = process_instruction pos mx my scents false instructions in
        printf "%d %d %c%s\n" final_pos.x final_pos.y (dir_to_char final_pos.d) (if lost then " LOST" else "");
        process_robots rest new_scents
      | _ -> () in
    process_robots rest [];
    print_endline ""
