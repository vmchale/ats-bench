let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in λ(x : List Natural) →
  prelude.makePkg { x = x, name = "ats-bench", githubUsername = "vmchale" }
    ⫽ { description = [ "Helper functions for benchmarking ATS." ] : Optional Text }
