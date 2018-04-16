#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "bench.dats"

fun expensive_computation() : void =
  let
    fun loop(n : intGt(0)) : int =
      case+ n of
        | 1 => 1
        | n =>> n + loop(n - 1)
    
    var i = loop(1000000)
    var _ = tostring_int(i)
  in end

val delay: io = lam () => expensive_computation()

implement main0 () =
  {
    val _ = print_slope("dummy", 8, delay)
  }
