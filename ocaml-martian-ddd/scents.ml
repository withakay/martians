open Position
open Orientation

module type REPO = sig
  val has : position -> orientation -> bool
  val add : position -> orientation -> unit
end

module In_memory : REPO = struct
  let set : (int*int*orientation, unit) Hashtbl.t = Hashtbl.create 97
  let key p o = (p.x, p.y, o)
  let has p o = Hashtbl.mem set (key p o)
  let add p o = Hashtbl.replace set (key p o) ()
end

