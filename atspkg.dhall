let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall
in

{-
  , libraries =
    [
      lib ⫽ 
      { libTarget = "target/libconccurency.a"
      , includes = [ "mylibies_link.hats", ".atspkg/contrib/channel_link.hats" ]
      , links = [ { _1 = "channel.sats", _2 = ".atspkg/contrib/channel_link.hats" } ]-}

prelude.default ⫽
  { test =
    [ prelude.bin ⫽
      { src = "test/bench.dats"
      , target = "target/bench"
      }
    ]
  , compiler = [0,3,10]
  , cflags = [ "-O2" ]
  }
