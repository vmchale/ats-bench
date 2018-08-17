let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in prelude.default ⫽
  { libraries =
    [
      prelude.staticLib ⫽
      { name = "atsbench"
      , libTarget = "target/libatsbench.a"
      , src = [ "bench.dats" ]
      }
    ]
  , cflags = [ "-O2" ]
  }
