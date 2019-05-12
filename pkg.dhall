let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in λ(x : List Natural) →
  prelude.makePkg { x = x, name = "ats-bench", githubUsername = "vmchale" }
    ⫽ { description = [ "Helper functions for benchmarking ATS." ] : Optional Text }
