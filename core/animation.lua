-- Animation function that supports
-- animation speed, looping (or not looping),
-- stopping on a specific frame, flipping
-- horizontal and/or vertical, and playing
-- in reverse
-- Source:
--   Git Repo:Lib-Pico8
--   Author:  Scathe (@clowerweb)
animation=object:extend({
  start=0,
  frames=1,
  cur=0, -- cursor
  step=1,
  speed=10,
  fr=30, --60 frame rates
  flipx=false,
  flipy=false,
  loop=false,
  reverse=false,

  playing=false,

  play=function(_ENV)playing=true end,
  rewind=function(_ENV)cur=(0)play(_ENV) end,

  update=function(_ENV)
    if(not playing) return false
    log("1 anim upd "..cur)
    step+=1
    if not reverse then
      if(step%flr(fr/speed)==0)cur+=1 
      if(cur==frames) then 
        if(loop)then cur=0 else playing=false end
      end
    else
      if(step%flr(fr/speed)==0)cur-=1 
      if(cur<0) then 
        if(loop)then cur=0 else playing=false end
      end
    end
    log("2 anim upd "..cur)
  end,

  draw=function(_ENV,obj,offx,offy)
    if(not playing) return false
    if(not obj)return false 
    offx,offy=offx or 0,offy or 0
    spr(start+cur,obj.x+offx,obj.y+offy,1,1,flipx,flipy)
  end
})