-- collision handler to keep the ball within the playable screen
ball_screen_collision_handler = collision_handler:new({
  
  handle = function(self, ball, side)

    if ball:is_state("sticky") then
      return false
    end
    
    if side == _top then
      ball.dy = abs(ball.dy)
    end
    if side == _bottom then
      ball.dy = abs(ball.dy) -- keeps going down
      self:handle_loose_ball(ball)
    end

    if side == _left then
      ball.dx = abs(ball.dx)
    end
    if side == _right then
      ball.dx = -abs(ball.dx)
    end

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
    if (ball.y >= _screen_bot) then
      sfx(4)
      local lives = _players["p1"]["lives"]
  
      if lives<=0 then
        -- log("Game state: ".._state.." -> gameover")
        -- _state="gameover"
        set_gamestate("gameover")
      else
        _players["p1"]["lives"]=lives-1
        ball:serve()
      end
    end
  end
})