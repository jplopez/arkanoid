-- paddle
_paddle_states = {
  idle = "idle",
  left = "left",
  right = "right",
  hit = "hit"
}

paddle = class:new({
  x = 52,
  y = 120,
  w = 24,
  h = 3,
  clr = rnd(_pals["paddle"]),
  dx = 2,

  state = _paddle_states.idle,

  hit_clr = 7,
  hit_frames = 3,
  hit_count = 0,

  init = function(self)
    local mid_screen = _screen_left + (_screen_right - _screen_left) / 2
    self.x = mid_screen - self.w / 2
    self.dx = 2
    self.state = _paddle_states.idle
  end,

  update = function(self)
    if btn(0) then -- move left
      self.x = mid(_screen_left + _col_eng.tol, 
            self.x - self.dx,
            _screen_right - self.w - _col_eng.tol)
      self.state = _paddle_states.left
    elseif btn(1) then -- move right
      self.x = mid(_screen_left + _col_eng.tol, 
            self.x + self.dx, 
            _screen_right - self.w - _col_eng.tol)
      self.state = _paddle_states.right
    end
  end,

  draw = function(self)
    rectfill(
      self.x, self.y,
      self.x + self.w, self.y + self.h,
      self:paddle_clr()
    )
  end,

  on_collision = function(self)
    self.hit_count = self.hit_frames
  end,

  paddle_clr = function(self)
    if self.hit_count > 0 then
      self.hit_count -= 1
      return self.hit_clr
    else
      return self.clr
    end
  end
})