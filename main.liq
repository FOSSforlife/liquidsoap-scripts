#!/usr/bin/env liquidsoap

%include "secret.liq"
set("init.daemon",true)
set("server.telnet",true)

favorites=normalize(playlist("#{liqpath}/music/favorites"))
other=normalize(playlist("#{liqpath}/music/other"))
fallbacksingle=single("#{homepath}/shockfront.mp3")

radio=random(weights=[2,3], [favorites, other])
radio=fallback(track_sensitive = false, [radio, fallbacksingle])
radio=mksafe(radio)

output.icecast(
  %vorbis, 
  host="localhost", 
  port=port, 
  password=password, 
  mount="music1.ogg",
  description="If you like what you hear, check out my music collection at https://bandcamp.com/eliasjackson.",
  radio
)
