-- gst: Game State manager for Pico8
_gstc={cur=nil}
function gst(k) return gstt(k) end
function gstt(k,on,off)
  if(k!=nil) then
    local f=function()end
    _gstc[k]=_gstc[k] or {key=k, on=f,off=f}
    if(on)_gstc[k].on=on 
    if(off)_gstc[k].off=off 
    local o=_gstc.cur
    if(o)_gstc[o].off(o,k)
    _gstc.cur=k
    _gstc[k].on(o,k)
  end
  return _gstc.cur
end