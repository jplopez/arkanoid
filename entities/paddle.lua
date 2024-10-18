paddle=entity:extend({ 
  x=52,y=112,w=24,h=8,dx=2,
  states={"idle","move","hit"}, 

  init=function(_ENV)
    entity.init(_ENV)
    _st={idle,moving,hit} 
    local mid_screen=_screen_left+(_screen_right-_screen_left)/2
    x,dx=mid_screen-w/2,2
    set(_ENV,idle)
  end,

  update=function(_ENV)
    local dir=0 --no movement
    if(btn(0))dir=-1 --move left
    if(btn(1))dir=1  --move right
    x=mid(_screen_left+_tol,x+(dir*dx),
      _screen_right-w-_tol)
    set(_ENV,moving)
  end,

  draw=function(_ENV)
    sspr(40,40,8,8,x,y,8,h,false,false)     --left wing
    sspr(48,40,8,8,x+8,y,w-16,h,false,false)--center
    sspr(40,40,8,8,x+w-8,y,8,h,true,false)  --right wing
  end,

  on_collision=_noop,
})