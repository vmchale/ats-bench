#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"

staload "libats/ML/SATS/atspre.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define :: list_vt_cons
#define nil list_vt_nil

extern
fun same(int) : intGt(0) =
  "ext#"

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

int same(int x) { return x; }
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

fun create_entry(n : int, x : io) : double =
  let
    val pre_d = bench_f(same(n), x)
  in
    gnumber_int<double>(pre_d)
  end

typedef regression = @{ intercept = double, slope = double }
typedef pair = @{ x = double, y = double }

fun sum(xs : !List_vt(double)) : double =
  list_vt_foldleft_cloptr<double>( xs
                                 , 0.0
                                 , lam (acc, next) =<cloptr1> acc + next
                                 )

// TODO make this a SATS file.
fun regress(pairs : List_vt(pair)) : regression =
  let
    val n = list_vt_length(pairs)
    val ys = list_vt_map_cloref(pairs, lam p =<cloref1> p.y)
    val xs = list_vt_map_cloref(pairs, lam p =<cloref1> p.x)
    val xys = list_vt_map_cloref(pairs, lam p =<cloref1> p.x * p.y)
    val xxs = list_vt_mapfree_cloref(pairs, lam p =<cloref1> p.x * p.x)
    val sigma_y = sum(ys)
    val sigma_x = sum(xs)
    val sigma_xy = sum(xys)
    val sigma_xx = sum(xxs)
    val _ = list_vt_free(ys)
    val _ = list_vt_free(xs)
    val _ = list_vt_free(xys)
    val _ = list_vt_free(xxs)
    val denom = (n * sigma_xx - sigma_x * sigma_x)
    val intercept = (sigma_y * sigma_xx - sigma_x * sigma_xy) / denom
    val slope = (n * sigma_xy - sigma_x * sigma_y) / denom
  in
    @{ intercept = intercept, slope = slope }
  end

fun seq {n:nat} .<n>. (i : int(n)) : list_vt(int, n) =
  case+ i of
    | 0 => nil
    | n =>> (n - 1) :: seq(n - 1)

fun create_pairs(d : io) : List_vt(pair) =
  let
    val pre_seq = seq(6)
    val correct = list_vt_mapfree_cloref( pre_seq
                                        , lam n =<cloref1> (3 ** $UN.cast(n))
                                        )
    val pairs = list_vt_mapfree_cloref(correct, lam n => let
                                        val nd = gnumber_int<double>(n)
                                      in
                                        @{ x = nd, y = create_entry($UN.cast(n), delay) }
                                      end)
  in
    pairs
  end

fun get_slope(d : io) : double =
  let
    val pairs = regress(create_pairs(d))
  in
    pairs.slope
  end

// TODO: linear regression: 1, 3, 9, 27, 81 times?
implement main0 () =
  {
    val d = get_slope(delay)
    val _ = print("estimate: ")
    val _ = display_time(d)
  }
