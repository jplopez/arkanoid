bscr_handler=collision_handler:extend({

  handle = function(_ENV,b,side)
    side=side or b.col_side
    if(b:is(sticky) or b:is(hidden))return false
    if (b.y>=_screen_bot)handle_loose_ball(_ENV,b)return
    -- ball direction according to side
    if(side==_top)b.dy=abs(b.dy)
    if(side==_bottom)b.dy=abs(b.dy)
    if(side==_left)b.dx=abs(b.dx)
    if(side==_right)b.dx=-abs(b.dx)
    -- b bouncing wall sfx and screen shake
    if(b.power==_pwr_off)sfx(0)
    if(b.power==_pwr_ball)sfx(0)
    if(b.power==_pwr_fury)then 
      _shake+=1
      sfx(0,0)
      sfx(7,1)  
    end
  end,

  handle_loose_ball=function(_ENV,b)
    sfx(4)
    b:set(hidden)
    del(global._colle.balls,b)
    del(global._pup_extra_balls,b)
    if(#global._colle.balls==0)then
      global._plives-=1
      if(global._plives==0)then gset(gameover)
      else 
        global._colle.balls={global._pball}
        global._pball:set(sticky)
        global._pball:serve()
        disable_all_aspects()
      end
    end
  end
})