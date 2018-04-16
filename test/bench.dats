#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "bench.dats"

implement main0 () =
  {
    val _ = print_slope("dummy", delay)
  }
