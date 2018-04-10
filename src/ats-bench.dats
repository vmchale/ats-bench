#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"

staload "libats/libc/SATS/stdio.sats"

extern
fun start_timer() : void =
  "ext#"

extern
fun microseconds() : int =
  "ext#"

extern
fun dup(int) : int =
  "ext#"

%{
#include <sys/time.h>
#include <time.h>

struct timeval timer;

void start_timer() { gettimeofday(&timer, NULL); }

int microseconds() {
  struct timeval now;
  gettimeofday(&now, NULL);
  int secs = now.tv_sec - timer.tv_sec;
  int us = now.tv_usec - timer.tv_usec;
  return (1000000 * secs + us);
}
%}

//   [l:addr] (a@l, a@l -<lin,prf> void | ptr l)
typedef io = () -> void

fun display_time(x : double) : void =
  ifcase
    | x >= 1000000 => println!(x / 1000000, " s")
    | x >= 1000 => println!(x / 1000, " ms")
    | _ => println!(x, " μs")

fun bench_f(n : intGt(0), x : io) : int =
  let
    val before = start_timer()
    
    fun loop { n : nat | n > 0 } .<n>. (n : int(n), x : io) : void =
      case+ n of
        | 1 => x()
        | m =>> (x() ; loop(m - 1, x))
    
    val _ = loop(n, x)
  in
    microseconds()
  end

fun expensive_computation() : void =
  let
    fun loop(n : intGt(0)) : int =
      case+ n of
        | 1 => 1
        | n =>> n + loop(n - 1)
    
    val i = loop(1000000)
    val _ = tostring_int(i)
  in end

val delay: io = lam () => expensive_computation()

fun create_entry(n : intGt(0), x : io) : double =
  let
    val pre_d = bench_f(n, x)
  in
    gnumber_int<double>(pre_d)
  end

// TODO: linear regression: 1, 3, 9, 27, 81 times?
implement main0 () =
  {
    val d = create_entry(27, delay) / 27
    val _ = display_time(d)
  }
