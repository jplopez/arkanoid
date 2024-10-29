brick_hit_anim=animation:extend({
  start=40,
  frames=5,
  speed=20,
  fr=60,
  loop=false,
  playing=false,
})

brick=entity:extend({
  x=_screen_left + 12,
  y=_screen_top + 10,
  w=8,
  h=5,
  s=20,
  unbreakable=false,
  score_mul=5,
  
  hit_anim=brick_hit_anim(),
  
  init=function(_ENV)
    entity.init(_ENV)
    _st={visible,hit,hidden}
    _cur=visible
  end,

  update=_noop,

  draw=function(_ENV)
    if(is(_ENV,hidden))return true
    if(is(_ENV,visible))spr(s,x,y)
    if(is(_ENV,hit))draw_hit(_ENV)
  end,

  draw_hit=function(_ENV)
    hit_anim:update()
    if(hit_anim.playing) then 
      hit_anim:draw({x=x,y=y})
    else return set(_ENV,hidden) end
  end,

  on_collision=function(_ENV,b)
    b=b or _pball
    if(unbreakable and b.power~=_pwr_fury)then  -- only fury ball (red) beats unbreakable bricks
      b.pwr+=_pwrbar_increment
      sfx(6) -- metal cling sound
      return set(_ENV,visible)
    end
    score_hit(_ENV,b)
    hit_anim:rewind()
    return set(_ENV,hit)
  end,

  score_hit=function(_ENV,b)
    b=b or _pball
    local new_combo=_pcombo+b.hits    
    -- Update player's score and combo and ball pwr 
    _score:add(score_mul*new_combo)
    _pcombo=new_combo

    b.pwr+=ceil(new_combo/_pwrbar_combo_factor)
    -- brick hit sound: combo sfx goes up to 7
    if(b.power==_pwr_off)sfx(10+mid(1,new_combo,7))
    if(b.power==_pwr_ball or b.power==_pwr_fury)sfx(09)
  end,

  join=function(_ENV,other)
    if(other~=nil) then 
      x=min(x,other.x)
      y=min(y,other.y)
      w=max(x+w,other.x+other.w)-x
      h=max(y+h,other.y+other.h)-y
    end
  end,
})