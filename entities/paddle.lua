-- paddle
paddle = class:new({
  x = 52,
  y = 112,
  w = 24,
  h = 8,
  clr = rnd(_pals["paddle"]),
  dx = 2,

  hit_clr = 7,
  hit_frames = 3,
  hit_count = 0,

  init = function(self)
    local mid_screen = _screen_left + (_screen_right - _screen_left) / 2
    self.x = mid_screen - self.w / 2
    self.dx = 2
    self:state("idle")
  end,

  update = function(self)

    local dir = 0 -- no movement
    local tol = collision_engine.tolerance
    if(btn(0)) dir=-1 -- move left
    if(btn(1)) dir=1  -- move right

    self.x = mid(_screen_left + tol, 
        self.x + (dir*self.dx),
        _screen_right - self.w - tol)
    self:state("move")
  end,

  draw = function(self)
    -- rectfill(
    --   self.x, self.y,
    --   self.x + self.w, self.y + self.h,
    --   self:paddle_clr())
    sspr(40,40,16,8,self.x,self.y,self.w-8,self.h, false, false)
    sspr(40,40,8,8,self.x+16,self.y,8,self.h, true, false)

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