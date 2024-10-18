ball=entity:extend({
  x=_screen_left, 
  y=_screen_bot-20,
  dx=0.5,
  dy=-1,
  r=1.75,
  
  sx=0,
  sy=8,
  hits=1,
  pwr=0,
  power=_pwr_off,
  stats={
    [_pwr_off]={sx=0,sy=8,hits=_pwr_off_hit},
    [_pwr_ball]={sx=8,sy=8,hits=_pwr_ball_hit},
    [_pwr_fury]={sx=16,sy=8,hits=_pwr_fury_hit},
  },
  
  init=function(_ENV)
    entity.init(_ENV)
    _st={idle,moving,sticky,hidden}
    _cur=idle
  end,

  update=function(_ENV)
    -- serve ball
    if(btn(4)and(is(_ENV,hidden)))serve(_ENV)
    if(is(_ENV,sticky))then
      if(btn(0))dx=-abs(dx) -- move left
      if(btn(1))dx=abs(dx)  -- move right 
      if(btn(5))set(_ENV,moving) -- launch ball
      x=_ppaddle.x+(_ppaddle.w/2)
    end
    if(is(_ENV,moving))then
      x+=dx
      y+=dy
    end
    --update attributes impacted by powerbar
    if(pwr<_pwr_ball)power=_pwr_off
    if(pwr>=_pwr_ball and pwr<_pwr_fury)power=_pwr_ball
    if(pwr>=_pwr_fury)power=_pwr_fury
    local stat=stats[power]
    sx,sy,hits=stat.sx,stats.sy,stats.hits
  end,

  draw=function(_ENV)if(not is(_ENV,hidden))sspr(sx,sy,5,5,x-r,y-r,5,5)end,

  --Return col[bool] and side[number]
  collide=function(_ENV,other)
    local col,side=false,nil
    if(is(_ENV,moving))then
      if(other and other.w)then 
        col,side=_colle:is_circle_rect_colliding({x=x,y=y,r=r},other)
      else 
        col,side=_colle:is_circle_screen_colliding({x=x,y=y,r=r})
      end
    end
    return col,side
  end,

  serve=function(_ENV,tbl)
    tbl=tbl or {}
    set(_ENV,sticky)
    --resets paddle and ball
    pwr=0
    --adjust ball x only if it is outside of paddle
    x=tbl.x or _ppaddle.x+(_ppaddle.w/2)
    y=tbl.y or _ppaddle.y-(r)
    if(not _aspects["paddle_glue"].enabled) dx=tbl.dx or 0.5
    dy=tbl.dy or -abs(dy)
  end
})