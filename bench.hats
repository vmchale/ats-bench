#include "./bench.dats"

extern
fn display_all {n:nat}(s : string, n : int(n), d : io) : void =
  "mac#"

(*
extern
fn display_all_t {a:t@ype}{n:nat}(s : string, n : int(n), f : a -<cloref1> void, x : a) : void =
  "mac#"*)
implement display_all (s, n, d) =
  print_slope(s, n, d)

(*
implement display_all_t (s, n, f, x) =
  print_slope_t(s, n, f, x) *)
