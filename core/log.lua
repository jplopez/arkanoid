function log(text)
 logger:log(text)
end

logger=class:new({

 filename="log",
 prefix="",

 log=function(self, text, overwrite)
	fn = self.filename or "log"
	pfx=self.prefix or ""
	printh(pfx.." "..text, fn, overwrite)
 end,

 warn=function(self, text, overwrite)
	self:log("WARN "..text, overwrite)
 end,

 err=function(self, text, overwrite)
	self:log("ERR "..text, overwrite)
 end

})

----------
-- debug
----------

_debug=true
_debug_flags={
 ball   = false,
 paddle = false,
 events = false,
 timers = false,
 level  = false
}

function debug()
 if not _debug then 
   return false end

 local b = _players["p1"]["ball"]
 local p = _players["p1"]["paddle"]

	if _debug_flags["ball"] then
		log("ball (x1,y1),(x2,y2) = (" 
	    ..tostr(b.x)..","..tostr(b.y)..")"
	    ..",("..tostr(b.x+(b.r*2))..","..tostr(b.y+(b.r*2))..")")
	 	log("     (dx,dy) = ("..tostr(b.dx)..","..tostr(b.dy)..")")
 	end
 
 if _debug_flags["events"] then
	 print("e"..tostr(_debug_e_pos), 
	     _screen_left, 
	     _screen_top+23, 7)
	 print("b"..tostr(_debug_b_pos),
	     _screen_left, 
	     _screen_top+32, b.clr)
	 print("p"..tostr(_debug_p_pos),
	     _screen_left, 
	     _screen_top+41, p.clr)
	 print("d"..tostr(_debug_d_pos),
	     _screen_left, 
	     _screen_top+50, p.clr)
 end

 if _debug_flags["paddle"] then 
	 print ("p (x:y) ("..tostr(p.x)
	     ..","..tostr(p.y)..")"
	     .." state:"..tostr(p.state)
	     .." dx:"..tostr(p.dx)
	     ,p.clr)
 end
 
--  if _debug_flags["events"] then
-- 	 print("#e".. count(_col_eng.events),7)
-- 	 for e in all(_col_eng.events) do
-- 	  print(" "..e:to_string())
-- 	 end
--  end
 
 if _debug_flags["timers"] then
	 print("t:".. count(_timers),7)
	 t=_timers["start_timer"]
	 print("st: l:"..tostr(t.length)
	   .." fr:"..t.fr)
 end
 
 if _debug_flags["level"] then
	 print("lvl br:".. _cur_lvl.br_count
	   .." l:".._cur_lvl.br_left ,7)
  local i=1
  for brl in all(_cur_lvl.grid) do
   for br in all(brl) do
    print("br"..i.." "..br.x..","..br.y)
    i+=1
   end
  end
 end
 
 
 return true

end
