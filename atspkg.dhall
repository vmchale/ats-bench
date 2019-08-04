let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

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
