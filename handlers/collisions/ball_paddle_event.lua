-- ball hitting paddle
ball_paddle_event = event:new({
  dx_next = "",
  dy_next = "",

  side = "",

  eval = function(self)
    log("ball_paddle_event eval")
    local ball = _players["p1"]["ball"]
    local paddle = _players["p1"]["paddle"]

    -- sticky ball
    if ball.state == _ball_states.sticky then
      return false
    end

    self.dx_next = ""
    self.dy_next = ""
    self.side = ""

    local tol = _col_eng.tol
    local is_colliding, s = _col_eng:is_circle_rect_collision_side(ball, paddle)

    if is_colliding then
      log("ball_paddle_event collision detected")

      --to deprecate
      _col_eng.ball_paddle = true

      --calculate position with respect to paddle (x,y) where the collision took place.

      --horizontal
      if s["top"] then
        self.dy_next = "up"
        self.side = "up"
        self.x_pos = ball.x - paddle.x
        self.y_pos = paddle.y - (ball.y+ball.r)
      elseif s["bottom"] then
        self.dy_next = "down"
        self.side = "down"
        self.x_pos = ball.x - paddle.x
        self.y_pos = (paddle.y+paddle.h) - (ball.y-ball.r)
      end

      --vertical
      if s["right"] then
        self.dx_next = "right"
        self.side = "right"
        self.x_pos = (ball.x - ball.r) - (paddle.x+paddle.w)
        self.y_pos = ball.y - paddle.y
      elseif s["left"] then
        self.dx_next = "left"
        self.side = "left"
        self.x_pos = (ball.x + ball.r) - paddle.x
        self.y_pos = ball.y - paddle.y
      end

        if (self.side ~= "") then
        paddle:on_collision()
      end

      -- _debug_p_pos=
      --   "("..paddle.x..","..paddle.y..") "..
      --   "("..paddle_x2..","..paddle_y2..")"
      -- _debug_b_pos=
      --   "("..ball.x..","..ball.y..") "..
      --   "("..ball_x2..","..ball_y2..")"
      -- _debug_e_pos=
      --   "("--..self.x_pos..","..self.y_pos..") "
      -- _debug_d_pos=
      --   "next:("..
      --   self.dx_next..","..
      --   self.dy_next..")"

      return true
    else
      --no overlap
      --to deprecate
      _col_eng.ball_paddle = false
      return false
    end
  end,

  update = function(self)
    local ball = _players["p1"]["ball"]
    local paddle = _players["p1"]["paddle"]

    --upd ball's dx and dy
    ball.dx, ball.dy = self:upd_dx_dy(ball, paddle)
    sfx(1) -- ball bound in paddle sound
    _players["p1"]["combo"] = 1
  end,

  upd_dx_dy = function(self, ball, paddle)
    local new_dx = ball.dx
    local new_dy = ball.dy

    log("upd-dx-dy pos("..self.x_pos..","..self.y_pos..") "..self.side)
 
    -- if self.dy_next=="up" then
    if self.side == "up" then
      -- log("upd-dx-dy - up")
      local seg = paddle.w / 6
      new_dy = -abs(new_dy)
      
      if self.x_pos <= seg then
        new_dx = -2
      elseif self.x_pos <= seg * 2 then
        new_dx = -1.5
      elseif self.x_pos <= seg * 3 then
        new_dx = -1
      elseif self.x_pos <= seg * 4 then
        new_dx = 1
      elseif self.x_pos <= seg * 5 then
        new_dx = 1.5
      else
        -- self.x_pos<=(seg*6)
        new_dx = 2
      end

      -- elseif self.dy_next=="down" then
    elseif self.side == "down" then
      -- log("upd-dx-dy - down")
      new_dx = -1 * abs(new_dx)
      new_dy = abs(new_dy)
      -- side hit gives extra speed
      -- elseif self.dx_next=="left" then
    elseif self.side == "left" then
      -- log("upd-dx-dy - left")
      new_dx = -2.5
      new_dy = -1 * abs(new_dy)
      -- elseif self.dx_next=="right" then
    elseif self.side == "right" then
      -- log("upd-dx-dy - right")
      new_dx = 2.5
      new_dy = -1 * abs(new_dy)
    end

    self.dx_next = ""
    self.dy_next = ""
    log("upd-dx-dy new(x,y)=("..new_dx..","..new_dy..")")
    return new_dx, new_dy
  end,

  to_string = function(self)
    return "ball_paddle_event\n"
        --event:string(self)..
        .. " n(x,y):("
        .. tostr(self.dx_next) .. ","
        .. tostr(self.dy_next) .. ")"
  end
})