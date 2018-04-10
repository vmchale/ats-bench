let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall


in prelude.default ⫽
  { tests =
    [ prelude.bin ⫽
      { src = "bench.dats"
      , target = "target/bench"
      }
    ]
  , compiler = [0,3,10]
  }
