-- collision handler to keep the ball within the playable screen
ball_screen_collision_handler = collision_handler:new({
  
  handle = function(self, ball, side)

--    if ball.state == _ball_states.sticky then
    if ball:is_state("sticky") then
      return false
    end

    --log("ball screen side "..side)
    -- log("top, bot, left, right "
    --     .. top_dist .. "," .. bot_dist .. "," .. left_dist .. "," .. right_dist)
    
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

    sfx(0)
    -- sound ball bouncing wall
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