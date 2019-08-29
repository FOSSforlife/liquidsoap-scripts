#!/usr/bin/env liquidsoap

%include "secret.liq"
set("init.daemon.pidfile.path", "/home/ej/.opam/4.07.1/bin/liquidsoap")

favorites=normalize(playlist("#{liqpath}/music/favorites"))
other=normalize(playlist("#{liqpath}/music/other"))
fallbacksingle=single("#{homepath}/shockfront.mp3")

radio=random(weights=[2,3], [favorites, other])
radio=fallback(track_sensitive = false, [radio, fallbacksingle])

output.icecast(
  %vorbis, 
  host="localhost", 
  port=port, 
  password=password, 
  mount="music1.ogg",
  radio
)