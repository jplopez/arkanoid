web=entity:extend({
  x1=_screen_left,
  y1=_screen_bot-11,
  x2=_screen_right,
  y2=_screen_bot-11,
  clr=3,
  shield=1,
  hit=0,
  _fc=0,
  
  -- sprites to animate the net lights
  spr_map={
  --{sx,sy,sw,sh,dx,dy}
    {53,33,3,3,2,1},
    {49,33,3,3,2,1},
    {48,32,5,5,3,2},
  },

  init=function(_ENV) 
    entity.init(_ENV)
    _st={idle,visible,hidden}
    set(_ENV,hidden)
  end,

  update=function(_ENV)
    if(hit>=shield)then
      global.paddle_web:toggle(false)
      sfx(31)
      hit=0
    end
    _fc=(_fc+1)%30
  end,

  draw=function(_ENV)
    if(is(_ENV,idle))sfx(10)set(_ENV,visible)
    
    if(is(_ENV,visible))then
      local px2=_ppaddle.x+_ppaddle.w
      line(x1,y1,_ppaddle.x,y2,clr)
      line(px2,y1,x2,y2,clr)
      --animates the net lights
      local s=spr_map[flr(_fc/10)+1]
      sspr(s[1],s[2],s[3],s[4],_ppaddle.x-s[5],y1-s[6],s[3],s[4])
      sspr(s[1],s[2],s[3],s[4],px2-s[5],y1-s[6],s[3],s[4])
    end
  end,

  collide=function(_ENV,other)
    if(other.r) return collision_engine:is_circle_rect_colliding(other,hit_blocks.web)
    return false
  end,

  on_collision=function(_ENV,b)sfx(9)hit+=b.hits end
})