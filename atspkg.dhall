let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall


in prelude.default ⫽
  { bin =
    [ prelude.bin ⫽
      { src = "src/ats-bench.dats"
      , target = "target/ats-bench"
      }
    ]
  , compiler = [0,3,10]
  }
