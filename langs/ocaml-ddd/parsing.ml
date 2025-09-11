open Position
open Orientation

let ints line = line |> String.trim |> String.split_on_char ' ' |> List.filter (fun s -> s<>"") |> List.map int_of_string

let parse_grid line = match ints line with | [x;y] -> (x,y) | _ -> failwith "bad grid"

let parse_robot line =
  match String.split_on_char ' ' (String.trim line) |> List.filter ((<>) "") with
  | [sx; sy; so] -> ({x=int_of_string sx; y=int_of_string sy}, of_string so)
  | _ -> failwith "bad robot"

let normalize s = String.to_seq s |> Seq.filter (fun c -> c='L' || c='R' || c='F') |> String.of_seq
