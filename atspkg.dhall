let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:c04fe26a86f2e2bd5c67c17f213ee30379d520f5fad11254a8f17e936250e27e

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
