-- ball hitting paddle
ball_screen_event = event:new({

  col_side = {
    top = false,
    bottom = false,
    left = false,
    right = false
  },

  eval = function(self)
    log("ball_screen_event eval")
    local ball = _players["p1"]["ball"]

    -- sticky ball
    if ball.state == _ball_states.sticky then
      return false
    end

    local top_dist = ((ball.y-ball.r) - _screen_top) <= _col_eng.tol
    local bot_dist = (_screen_bot - (ball.y+ball.r)) <= _col_eng.tol
    local left_dist = ((ball.x-ball.r) - _screen_left) <= _col_eng.tol
    local right_dist = (_screen_right - (ball.x+ball.r)) <= _col_eng.tol

    self.col_side = {
      top = top_dist,
      bottom = bot_dist,
      left = left_dist,
      right = right_dist
    }
    return (top_dist or bot_dist or left_dist or right_dist)
  end,

  update = function(self)
    local ball = _players["p1"]["ball"]
    log("is_circle_inside_rect_collision_side update init (dx,dy):("
        ..ball.dx..","..ball.dy..")")
    log("t,b,l,r"..tostr(self.col_side["top"]).." "
      ..tostr(self.col_side["bottom"]).." "
      ..tostr(self.col_side["left"]).." "
      ..tostr(self.col_side["right"]).." ")
    
    if self.col_side["top"] then
      ball.dy = abs(ball.dy)
    end
    if self.col_side["bottom"] then
      ball.dy = abs(ball.dy) -- keeps going down
    end
    if self.col_side["left"] then
      ball.dx = abs(ball.dx)
    end
    if self.col_side["right"] then
      ball.dx = -abs(ball.dx)
    end

    sfx(0) -- sound ball bouncing wall
    log("is_circle_inside_rect_collision_side update end (dx,dy):("
        ..ball.dx..","..ball.dy..")")
  end,

  to_string = function(self)
    return "ball_screen_event pos(x,y):("
        .. tostr(self.x_pos) .. ","
        .. tostr(self.y_pos) .. ")"
  end
})