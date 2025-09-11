open Grid
open Scents
open Robot
open Navigator
open Parsing
open Orientation

let read_all ic =
  let rec aux acc =
    try let s = input_line ic |> String.trim in aux (if s<>"" then s::acc else acc) with End_of_file -> List.rev acc
  in aux []

let run ic oc =
  match read_all ic with
  | [] -> output_string oc "\n"
  | header::rest ->
      let mx,my = parse_grid header in
      let grid = { max_x = mx; max_y = my } in
      let rec loop lines scents =
        match lines with
        | meta :: instr :: tail ->
            let pos,o = parse_robot meta in
            let r = create pos o in
            let instr = normalize instr in
            execute (module In_memory : REPO) grid r instr;
            Printf.fprintf oc "%d %d %s%s\n" r.position.x r.position.y (to_string r.orientation) (if r.lost then " LOST" else "");
            loop tail scents
        | _ -> ()
      in
      loop rest (); output_char oc '\n'
