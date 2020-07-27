let prelude =
      https://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in    prelude.default
    ⫽ { libraries =
        [   prelude.staticLib
          ⫽ { name = "atsbench"
            , libTarget = "target/libatsbench.a"
            , src = [ "bench.dats" ]
            }
        ]
      , cflags = [ "-O2" ]
      , compiler = [ 0, 4, 0 ]
      , version = [ 0, 3, 13 ]
      }
