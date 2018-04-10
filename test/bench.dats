#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "bench.dats"

implement main0 () =
  {
    val d = get_slope(delay)
    val _ = print("estimate: ")
    val _ = display_time(d)
  }
