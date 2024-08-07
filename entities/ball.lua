-- ball
_ball_states = {
  idle = "idle",
  move = "move",
  sticky = "sticky"
}

ball = class:new({
  x = _screen_left, 
  y = _screen_bot - 20,
  dx = 0.5, 
  dy = -1, 
  r = 2,
  clr = 8,

  state = _ball_states.idle,

  update = function(self)

    if self.state == _ball_states.sticky then
      if btn(5) then
        self.state = _ball_states.move
      else 
        self:serve()
      end
    end

    if self.state == _ball_states.move then
      self.x += self.dx
      self.y += self.dy
    end
  end,

  draw = function(self)
    circfill(self.x, self.y,
      self.r, self.clr)
  end,
 
  serve = function(self)
    --resets paddle and ball
    local p = _players["p1"]["paddle"]

    self.x = p.x + p.w / 2
    self.y = p.y - (self.r*2)
    self.dx = 0.5
    self.dy = -1
    self.state = _ball_states.sticky
  end
})