let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall
in

let cc = "gcc"
in

prelude.default ⫽
  { test =
    [ prelude.bin ⫽
      { src = "test/bench.dats"
      , target = "target/bench-${cc}"
      }
    ]
  , compiler = [0,3,10]
  , ccompiler = cc
  , cflags = [ "-O2" ] -- , "-fstruct-passing" ]
  }
