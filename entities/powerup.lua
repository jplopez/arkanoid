powerup=entity:extend({
  s= 0,
  x=_screen_left+rnd(_screen_right),
  y=_screen_top+rnd(64),
  w=8,
  h=8,
  speed=0.5,
  --picked attrs
  c=0,
  msg=nil,

  init=function(_ENV)
    entity.init(_ENV)
    _st={visible,hidden,idle,picked}
    set(_ENV,visible)
  end,

  update=function(_ENV)
    -- hide powerup if is off the screen or was hidden, destroy
    if((y>_screen_bot) or is(_ENV,hidden))destroy(_ENV)return

    if is(_ENV,visible)then
      x=mid(_screen_left,x+cos(t()),_screen_right-8) 
      y=max(_screen_top,y+speed)
    end
    if(is(_ENV,picked))y-=1
  end, 

  draw=function(_ENV)
    if(is(_ENV,visible))spr(s,x,y)
    if(is(_ENV,picked))draw_pup_msg(_ENV)
  end,
  
  draw_pup_msg=function(_ENV)
    if(msg) then
      c=(c+1)%12
      if(c==0)then set(_ENV,hidden)
      else print(msg,x-5,y-5,8+rnd(3))end
    else set(_ENV,hidden)end
  end,

  collide=function(_ENV,other)
    return (is(_ENV,visible) and 
          global._colle:is_rect_colliding({x=x,y=y,w=w,h=h},other))
  end,

  apply=function(_ENV,...)end,

  new_by_id=function(_ENV,id,tbl) 
    tbl=tbl or {}
    if(pup_factory[id])return pup_factory[id](tbl)
  end,
})