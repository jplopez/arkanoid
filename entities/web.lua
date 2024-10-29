web_anim=animation({
  start=101,
  frames=3,
  fr=60,
  speed=10,
  loop=true,
  playing=true,
})

web=entity:extend({
  x1=_screen_left,
  y1=_screen_bot-11,
  x2=_screen_right,
  y2=_screen_bot-11,
  clr=3,
  shield=1,
  hit=0,

  anim=web_anim,

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
      web_anim:set(stopped)
    end
    if(is(_ENV,visible)) then
      if(not web_anim:is(playing))web_anim:set(playing)
      web_anim:update()
    end
  end,

  draw=function(_ENV)
    if(is(_ENV,idle))sfx(10)set(_ENV,visible)
    
    if(is(_ENV,visible))then
      local px2=_ppaddle.x+_ppaddle.w
      line(x1,y1,_ppaddle.x,y2,clr)
      line(px2,y1,x2,y2,clr)
      web_anim:draw({x=_ppaddle.x-2,y=y1-2})
      web_anim:draw({x=px2-2,y=y1-2})
    end
  end,

  collide=function(_ENV,other)
    if(other.r) return collision_engine:is_circle_rect_colliding(other,hit_blocks.web)
    return false
  end,

  on_collision=function(_ENV,b)sfx(9)hit+=b.hits end
})