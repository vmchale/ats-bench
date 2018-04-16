let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall
in


prelude.default ⫽
  { libraries =
    [
      prelude.staticLib ⫽ 
      { name = "atsbench"
      , libTarget = "target/libatsbench.a"
      , src = [ "bench.dats" ]
      -- , includes = [ "mylibies_link.hats", ".atspkg/contrib/channel_link.hats" ]
      -- , links = [ { _1 = "bench.sats", _2 = ".atspkg/contrib/channel_link.hats" }
      }
    ]
  , cflags = [ "-O2" ]
  }
