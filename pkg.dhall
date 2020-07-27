let prelude =
      https://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in  λ(x : List Natural) →
        prelude.makePkg { x, name = "ats-bench", githubUsername = "vmchale" }
      ⫽ { description = Some "Helper functions for benchmarking ATS." }
