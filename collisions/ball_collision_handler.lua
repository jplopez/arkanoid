bscr_handler = collision_handler:new({
  
  handle = function(self, ball, side)
    if(ball:is_state("sticky") or ball:is_state("hidden")) return false

    if (ball.y>=_screen_bot)self:handle_loose_ball(ball)
    -- ball direction according to side
    if(side==_top) ball.dy = abs(ball.dy)
    if(side==_bottom) ball.dy = abs(ball.dy)
    if(side==_left) ball.dx = abs(ball.dx)
    if(side==_right) ball.dx = -abs(ball.dx)
    -- ball bouncing wall sfx and screen shake
    if(ball:power()==_pwr_off)  sfx(0)
    if(ball:power()==_pwr_ball) sfx(0)
    if(ball:power()==_pwr_fury) then 
      _shake+=1
      sfx(0,0)
      sfx(7,1)  
    end
  end,

  handle_loose_ball=function(self, ball)
    sfx(4)
    ball:state("hidden")
    if(ball != _pball) del(_colle.balls,ball)
    del(_pup_extra_balls,ball)
    if(#_colle.balls==0) then
      _plives-=1
      if(_plives==0) gamestate("gameover")
      _colle.balls={_pball}
      _pball:serve()
      disable_all_aspects()
    end
  end
})