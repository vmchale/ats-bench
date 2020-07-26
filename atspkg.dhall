let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:38172c1bfad21ef2f1870d4489943236cee531ccc52314b8e91fa660a3f3fab7

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
