-- collision handler to keep the ball within the playable screen
ball_screen_collision_handler = collision_handler:new({
  
  handle = function(self, ball, side)

--    if ball.state == _ball_states.sticky then
    if ball:is_state("sticky") then
      return false
    end

    -- local top_dist = ((ball.y-ball.r) - _screen_top) 
    -- local bot_dist = (_screen_bot - (ball.y+ball.r)) 
    -- local left_dist = ((ball.x-ball.r) - _screen_left) 
    -- local right_dist = (_screen_right - (ball.x+ball.r)) 
    -- min_dist = min(
    --       min(top_dist, bot_dist), 
    --       min(left_dist, right_dist))

    log("ball screen side "..side)
    -- log("top, bot, left, right "
    --     .. top_dist .. "," .. bot_dist .. "," .. left_dist .. "," .. right_dist)
    
    if side == "top" then
      ball.dy = abs(ball.dy)
    end
    if side == "bottom" then
      ball.dy = abs(ball.dy) -- keeps going down
      self:handle_loose_ball(ball)
    end

    if side == "left" then
      ball.dx = abs(ball.dx)
    end
    if side == "right" then
      ball.dx = -abs(ball.dx)
    end

    sfx(0)
    -- sound ball bouncing wall
  end,

  handle_loose_ball=function(self, ball)
    if (ball.y >= _screen_bot) then
      sfx(4)
      local lives = _players["p1"]["lives"]
  
      if lives<=0 then
        _state="gameover"
      else
        _players["p1"]["lives"]=lives-1
        ball:serve()
      end
    end
  end
})